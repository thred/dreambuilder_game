local mod_statistics = {
	step_total = 0,
	samples = 0,
	data = {},
	stats = {
		total = {
			min_us = math.huge,
			max_us = 0,
			all_us = 0,
			min_per = 100,
			max_per = 100
		}
	}
}
profiler.mod_statistics = mod_statistics
local total = mod_statistics.stats.total

local replacement_table = {
	"register_globalstep",
	"register_on_placenode",
	"register_on_dignode",
	"register_on_punchnode",
	"register_on_generated",
	"register_on_newplayer",
	"register_on_dieplayer",
	"register_on_respawnplayer",
	"register_on_prejoinplayer",
	"register_on_joinplayer",
	"register_on_leaveplayer",
	"register_on_cheat",
	"register_on_chat_message",
	"register_on_player_receive_fields",
	"register_on_mapgen_init",
	"register_on_craft",
	"register_craft_predict",
	"register_on_item_eat"
}

--------------------------------------------------------------------------------
function mod_statistics.log_time(type, modname, time_in_us)

	if modname == nil then
		modname = "builtin"
	end
	
	if mod_statistics.data[modname] == nil then
		mod_statistics.data[modname] = {}
	end
	
	if mod_statistics.data[modname][type] == nil then
		mod_statistics.data[modname][type] = 0
	end
	
	mod_statistics.data[modname][type] =
		mod_statistics.data[modname][type] + time_in_us
	mod_statistics.step_total = mod_statistics.step_total + time_in_us
end

--------------------------------------------------------------------------------
function mod_statistics.update_statistics(dtime)
	local sample_time = mod_statistics.step_total
	if sample_time == 0 then return end -- rare but happens and is currently of no informational value
	mod_statistics.samples = mod_statistics.samples + 1

	for modname,types in pairs(mod_statistics.data) do
		local modstats = mod_statistics.stats[modname]
		if modstats == nil then
			modstats = {
				min_us = math.huge,
				max_us = 0,
				all_us = 0,
				min_per = 100,
				max_per = 0,
				all_per = 0
			}
			mod_statistics.stats[modname] = modstats
		end
		
		local modtime = 0
		for type,time in pairs(types) do
			modtime = modtime + time
			if modstats.types == nil then
				modstats.types = {}
			end

			local typestats = modstats.types[type]
			if typestats == nil then
				typestats = {
					min_us = math.huge,
					max_us = 0,
					all_us = 0,
					min_per = 100,
					max_per = 0,
					all_per = 0
				}
				modstats.types[type] = typestats
			end

			--update us values
			typestats.min_us = math.min(time, typestats.min_us)
			typestats.max_us = math.max(time, typestats.max_us)
			typestats.all_us = typestats.all_us + time

			--update percentage values
			local cur_per = (time/sample_time) * 100
			typestats.min_per = math.min(typestats.min_per, cur_per)
			typestats.max_per = math.max(typestats.max_per, cur_per)
			typestats.all_per = typestats.all_per + cur_per

			mod_statistics.data[modname][type] = 0
		end

		--per mod statistics
		--update us values
		modstats.min_us = math.min(modtime, modstats.min_us)
		modstats.max_us = math.max(modtime, modstats.max_us)
		modstats.all_us = modstats.all_us + modtime

		--update percentage values
		local cur_per = (modtime/sample_time) * 100
		modstats.min_per = math.min(modstats.min_per, cur_per)
		modstats.max_per = math.max(modstats.max_per, cur_per)
		modstats.all_per = modstats.all_per + cur_per
	end

	--update "total"
	total.min_us = math.min(mod_statistics.step_total, total.min_us)
	total.max_us = math.max(mod_statistics.step_total, total.max_us)
	total.all_us = total.all_us + mod_statistics.step_total

	mod_statistics.step_total = 0
end

--------------------------------------------------------------------------------
local function build_callback(log_id, fct)
	return function( toregister )
		local modname = core.get_current_modname()
		
		fct(function(...)
			local starttime = core.get_us_time()
			-- note maximum 10 return values are supported unless someone finds
			-- a way to store a variable lenght return value list
			local r0, r1, r2, r3, r4, r5, r6, r7, r8, r9 = toregister(...)
			local delta = core.get_us_time() - starttime
			mod_statistics.log_time(log_id, modname, delta)
			return r0, r1, r2, r3, r4, r5, r6, r7, r8, r9
			end
		)
	end
end

--------------------------------------------------------------------------------
local function initialize_profiling()
	core.log("action", "Initialize tracing")
	
	mod_statistics.entity_callbacks = {}
	
	-- first register our own globalstep handler
	core.register_globalstep(mod_statistics.update_statistics)
	
	local rp_register_entity = core.register_entity
	core.register_entity = function(name, prototype)
		local modname = core.get_current_modname()
		local new_on_activate = nil
		local new_on_step = nil
		local new_on_punch = nil
		local new_rightclick = nil
		local new_get_staticdata = nil
		
		if prototype.on_activate ~= nil then
			local cbid = name .. "#oa"
			mod_statistics.entity_callbacks[cbid] = prototype.on_activate
			new_on_activate = function(self, staticdata, dtime_s)
				local starttime = core.get_us_time()
				mod_statistics.entity_callbacks[cbid](self, staticdata, dtime_s)
				local delta = core.get_us_time() -starttime
				mod_statistics.log_time(cbid, modname, delta)
			end
		end
		
		if prototype.on_step ~= nil then
			local cbid = name .. "#os"
			mod_statistics.entity_callbacks[cbid] = prototype.on_step
			new_on_step = function(self, dtime)
				local starttime = core.get_us_time()
				mod_statistics.entity_callbacks[cbid](self, dtime)
				local delta = core.get_us_time() -starttime
				mod_statistics.log_time(cbid, modname, delta)
			end
		end
	
		if prototype.on_punch ~= nil then
			local cbid = name .. "#op"
			mod_statistics.entity_callbacks[cbid] = prototype.on_punch
			new_on_punch = function(self, hitter)
				local starttime = core.get_us_time()
				mod_statistics.entity_callbacks[cbid](self, hitter)
				local delta = core.get_us_time() -starttime
				mod_statistics.log_time(cbid, modname, delta)
			end
		end
		
		if prototype.rightclick ~= nil then
			local cbid = name .. "#rc"
			mod_statistics.entity_callbacks[cbid] = prototype.rightclick
			new_rightclick = function(self, clicker)
				local starttime = core.get_us_time()
				mod_statistics.entity_callbacks[cbid](self, clicker)
				local delta = core.get_us_time() -starttime
				mod_statistics.log_time(cbid, modname, delta)
			end
		end
		
		if prototype.get_staticdata ~= nil then
			local cbid = name .. "#gs"
			mod_statistics.entity_callbacks[cbid] = prototype.get_staticdata
			new_get_staticdata = function(self)
				local starttime = core.get_us_time()
				local retval = mod_statistics.entity_callbacks[cbid](self)
				local delta = core.get_us_time() -starttime
				mod_statistics.log_time(cbid, modname, delta)
				return retval
			end
		end
	
		prototype.on_activate = new_on_activate
		prototype.on_step = new_on_step
		prototype.on_punch = new_on_punch
		prototype.rightclick = new_rightclick
		prototype.get_staticdata = new_get_staticdata
		
		rp_register_entity(name,prototype)
	end
	
	for i,v in ipairs(replacement_table) do
		local to_replace = core[v]
		core[v] = build_callback(v, to_replace)
	end
	
	local rp_register_abm = core.register_abm
	core.register_abm = function(spec)
	
		local modname = core.get_current_modname()
	
		local replacement_spec = {
			nodenames = spec.nodenames,
			neighbors = spec.neighbors,
			interval  = spec.interval,
			chance    = spec.chance,
			action = function(pos, node, active_object_count, active_object_count_wider)
				local starttime = core.get_us_time()
				spec.action(pos, node, active_object_count, active_object_count_wider)
				local delta = core.get_us_time() - starttime
				mod_statistics.log_time("abm", modname, delta)
			end
		}
		rp_register_abm(replacement_spec)
	end
	
	core.log("action", "Mod profiling initialized")
end

initialize_profiling()
