local HR = "---------------------+--------------------------------+" ..
	   "------------+------------+------------+-------+-------+--------"
local stats = profiler.mod_statistics.stats
local core = core
local function log(...) core.log("action", ...) end

local function shorten(str, length)
	if str and str:len() > length then
		return "..." .. str:sub(-(length-3))
	end
	return str
end

local function print_row(name, type, statistics)
	local samples = profiler.mod_statistics.samples
	log(string.format("%20s | %30s | %10d | %10d | %10d | %5d | %5d | %5d",
		shorten(name, 20) or "",
		shorten(type, 30) or "",
		statistics.min_us,
		statistics.max_us,
		statistics.all_us/samples,
		statistics.min_per,
		statistics.max_per,
		(statistics.all_per or (100 * samples))/samples -- extra handling for "total"
	))
end

function profiler.print_log(cmd, filter)
	log("Values below show times/percentages per server step.")
	log("Following suffixes are used for entities:")
	log("\t#oa := on_activate, #os := on_step, #op := on_punch, #or := on_rightclick, #gs := get_staticdata")
	log(string.format("%20s | %30s | %11s | %11s | %11s | %5s | %5s | %5s",
		"modname", "type" , "min µs", "max µs", "avg µs", "min %", "max %", "avg %"
	))
	log(HR)
	for modname,statistics in pairs(stats) do
		if modname ~= "total" then
			if (filter == "") or (modname == filter) then
				print_row(modname, nil, statistics)

				if statistics.types ~= nil then
					for type,typestats in pairs(statistics.types) do
						print_row(nil, type, typestats)
					end
				end
			end
		end
	end
	log(HR)
	if filter == "" then
		print_row("total", nil, stats.total)
	end
	log("")

	return true
end
