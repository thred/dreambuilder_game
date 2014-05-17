minetest.register_craft({
	output = 'auto_tree_tap:off 1',
	recipe = {
		{'group:wood', 'technic:treetap','group:wood'},
		{'default:stone', 'mesecons:piston','default:stone'},
		{'default:stone', 'mesecons:mesecon','default:stone'},
	}
})

local function swap_node(pos, name)
    local node = minetest.get_node(pos)
    if node.name == name then
        return
    end
    node.name = name
    minetest.swap_node(pos, node)
end

--define the functions from https://github.com/minetest/minetest/pull/834 while waiting for the devs to notice it
local function dir_to_facedir(dir, is6d)
	--account for y if requested
	if is6d and math.abs(dir.y) > math.abs(dir.x) and math.abs(dir.y) > math.abs(dir.z) then
		
		--from above
		if dir.y < 0 then
			if math.abs(dir.x) > math.abs(dir.z) then
				if dir.x < 0 then
					return 19
				else
					return 13
				end
			else
				if dir.z < 0 then
					return 10
				else
					return 4
				end
			end
		
		--from below
		else
			if math.abs(dir.x) > math.abs(dir.z) then
				if dir.x < 0 then
					return 15
				else
					return 17
				end
			else
				if dir.z < 0 then
					return 6
				else
					return 8
				end
			end
		end
	
	--otherwise, place horizontally
	elseif math.abs(dir.x) > math.abs(dir.z) then
		if dir.x < 0 then
			return 3
		else
			return 1
		end
	else
		if dir.z < 0 then
			return 2
		else
			return 0
		end
	end
end

local function delay(x)
	return (function() return x end)
end

local function break_node (pos, facedir)
	--locate the outgoing velocity, front, and back of the node via facedir_to_dir
	if type(facedir) ~= "number" or facedir < 0 or facedir > 23 then return end

	local vel = minetest.facedir_to_dir(facedir);
	local front = {x=pos.x - vel.x, y=pos.y - vel.y, z=pos.z - vel.z}
	
	local node = minetest.get_node(front)
	if node.name == "air" or node.name == "ignore" then
		return nil
	elseif minetest.registered_nodes[node.name] and minetest.registered_nodes[node.name].liquidtype ~= "none" then
		return nil
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	--check node to make sure it is diggable
	local def = ItemStack({name=node.name}):get_definition()
	if #def ~= 0 and not def.diggable or (def.can_dig and not def.can_dig(front, digger)) then --node is not diggable
		return
	end
	if minetest.is_protected(front, "auto_tap") then
		minetest.record_protection_violation(front, "auto_tap")
		return
	end
	local node_name = node.name
	if node_name ~= "moretrees:rubber_tree_trunk" then
		return
	end
	node.name = "moretrees:rubber_tree_trunk_empty"
	minetest.swap_node(front, node)

	local item1 = pipeworks.tube_item({x=pos.x, y=pos.y, z=pos.z}, "technic:raw_latex")
			item1:get_luaentity().start_pos = {x=pos.x, y=pos.y, z=pos.z}
			item1:setvelocity(vel)
			item1:setacceleration({x=0, y=0, z=0})
end

local node_breaker_on = function(pos, node)
	if node.name == "auto_tree_tap:off" then
		swap_node(pos, "auto_tree_tap:on")
		break_node(pos, node.param2)
		nodeupdate(pos)
	end
end

local node_breaker_off = function(pos, node)
	if node.name == "auto_tree_tap:on" then
		swap_node(pos, "auto_tree_tap:off")
		nodeupdate(pos)
	end
end

minetest.register_node("auto_tree_tap:off", {
	description = "Auto-Tap",
	tile_images = {"autotap_top_off.png","autotap_bottom_off.png","autotap_side2_off.png","autotap_side1_off.png",
			"autotap_back.png","autotap_front_off.png"},
	is_ground_content = true,
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2, mesecon = 2,tubedevice=1},
	mesecons= {effector={rules=pipeworks.rules_all,action_on=node_breaker_on, action_off=node_breaker_off}},
	sounds = default.node_sound_stone_defaults(),
	tube = {connect_sides={back=1}},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("pick", 1)
		inv:set_stack("pick", 1, ItemStack("default:pick_mese"))
	end,
	after_place_node = function (pos, placer)
		pipeworks.scan_for_tube_objects(pos, placer)
		local placer_pos = placer:getpos()
		
		--correct for the player's height
		if placer:is_player() then placer_pos.y = placer_pos.y + 1.5 end
		
		--correct for 6d facedir
		if placer_pos then
			local dir = {
				x = pos.x - placer_pos.x,
				y = pos.y - placer_pos.y,
				z = pos.z - placer_pos.z
			}
			local node = minetest.get_node(pos)
			node.param2 = dir_to_facedir(dir, true)
			minetest.set_node(pos, node)
			minetest.log("action", "real (6d) facedir: " .. node.param2)
		end
	end,
	after_dig_node = pipeworks.scan_for_tube_objects,
})

minetest.register_node("auto_tree_tap:on", {
	description = "Auto-Tap",
	tile_images = {"autotap_top_on.png","autotap_bottom_on.png","autotap_side2_on.png","autotap_side1_on.png",
			"autotap_back.png","autotap_front_on.png"},
	mesecons= {effector={rules=pipeworks.rules_all,action_on=node_breaker_on, action_off=node_breaker_off}},
	is_ground_content = true,
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2, mesecon = 2,tubedevice=1,not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	tube = {connect_sides={back=1}},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("pick", 1)
		inv:set_stack("pick", 1, ItemStack("default:pick_mese"))
	end,
	after_place_node = function (pos, placer)
		pipeworks.scan_for_tube_objects(pos, placer)
		local placer_pos = placer:getpos()
		
		--correct for the player's height
		if placer:is_player() then placer_pos.y = placer_pos.y + 1.5 end
		
		--correct for 6d facedir
		if placer_pos then
			local dir = {
				x = pos.x - placer_pos.x,
				y = pos.y - placer_pos.y,
				z = pos.z - placer_pos.z
			}
			local node = minetest.get_node(pos)
			node.param2 = dir_to_facedir(dir, true)
			minetest.set_node(pos, node)
			minetest.log("action", "real (6d) facedir: " .. node.param2)
		end
	end,
	after_dig_node = pipeworks.scan_for_tube_objects,
})
