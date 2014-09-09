
-- simple mod to add 45 degree walls
-- exploits the torchlike draw type.
--
-- by Vanessa Ezekowitz

angled_walls = {}

-- functions to clone tables/existing nodes

function angled_walls.copy_table(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == 'table' then
			v = angled_walls.copy_table(v)
		end
		copy[k] = v
	end
	return copy
end

function angled_walls.clone_node(name)
	return angled_walls.copy_table(minetest.registered_nodes[name])
end

-- helper function to rotate the object after it's placed

function angled_walls.rotate_to_45(pos, name)
	local nodename = name
	local wall_xm = minetest.get_node({ x=pos.x-1, y=pos.y, z=pos.z })
	local wall_xp = minetest.get_node({ x=pos.x+1, y=pos.y, z=pos.z })
	local wall_zm = minetest.get_node({ x=pos.x,   y=pos.y, z=pos.z-1})
	local wall_zp = minetest.get_node({ x=pos.x,   y=pos.y, z=pos.z+1})

	local corner_xmzm = minetest.get_node({ x=pos.x-1, y=pos.y, z=pos.z-1 })
	local corner_xpzm = minetest.get_node({ x=pos.x+1, y=pos.y, z=pos.z-1 })
	local corner_xmzp = minetest.get_node({ x=pos.x-1, y=pos.y, z=pos.z+1 })
	local corner_xpzp = minetest.get_node({ x=pos.x+1, y=pos.y, z=pos.z+1 })

	local iswall_xm = (wall_xm.name ~= "air")
	local iswall_xp = (wall_xp.name ~= "air")
	local iswall_zm = (wall_zm.name ~= "air")
	local iswall_zp = (wall_zp.name ~= "air")

	-- first, look for a neighboring 45-degree wall, and extend it if found

	if string.find(corner_xmzm.name, nodename) then
		local fdir = corner_xmzm.param2
		minetest.set_node(pos, {name = corner_xmzm.name, param2 = fdir})
		return

	elseif string.find(corner_xpzp.name, nodename) then
		local fdir = corner_xpzp.param2
		minetest.set_node(pos, {name = corner_xpzp.name, param2 = fdir})
		return

	elseif string.find(corner_xpzm.name, nodename) then
		local fdir = corner_xpzm.param2
		minetest.set_node(pos, {name = corner_xpzm.name, param2 = fdir})
		return

	elseif string.find(corner_xmzp.name, nodename) then
		local fdir = corner_xmzp.param2
		minetest.set_node(pos, {name = corner_xmzp.name, param2 = fdir})
		return

	-- only xm+zp, or only xp+zm means on-floor torchlike

	elseif iswall_xm and iswall_zp and not iswall_xp and not iswall_zm then
		minetest.set_node(pos, {name = nodename.."_315", param2 = 1})
		return

	elseif iswall_xp and iswall_zm and not iswall_xm and not iswall_zp then 
		minetest.set_node(pos, {name = nodename.."_135", param2 = 1})
		return
	
	-- only xm+zm, or only xp+zp means on-ceiling torchlike.

	elseif iswall_xm and iswall_zm and not iswall_xp and not iswall_zp then
		minetest.set_node(pos, {name = nodename.."_225", param2 = 0})
		return

	else -- iswall_xp and iswall_zp and not iswall_xm and not iswall_zm
		minetest.set_node(pos, {name = nodename, param2 = 0})
	end

end

local nodes_list = {
	{ "default:brick",				"brick" },
	{ "default:wood",				"wood" },
	{ "default:junglewood",			"jungle_wood" },
	{ "default:steelblock",			"steelblock" },
	{ "default:sandstone",			"sandstone" },
	{ "default:sandstonebrick",		"sandstone_brick" },
	{ "default:cobble",				"cobble" },
	{ "default:desert_cobble", 		"desert_cobble" },
	{ "default:stone",				"stone" },
	{ "default:stonebrick",			"stone_brick" },
	{ "default:desert_stone",		"desert_stone" },
	{ "default:desert_stonebrick",	"desert_stone_brick" }
}

for i in ipairs(nodes_list) do

	local nodename = nodes_list[i][1]
	local angledname = nodes_list[i][2]
	local newnode = angled_walls.clone_node(nodename)

	newnode.drawtype = "torchlike"
	newnode.inventory_image = newnode.tiles[1]
	newnode.tiles = { "angled_walls_"..angledname..".png" }
	newnode.description = newnode.description.." (angled wall)"
	newnode.paramtype = "light"
	newnode.paramtype2 = "wallmounted"
	newnode.visual_scale = 1.414
	newnode.after_place_node = function(pos, placer, itemstack, pointed_thing)
		angled_walls.rotate_to_45(pos, "angled_walls:"..angledname.."_corner")
	end
	newnode.node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
			{-0.4375, -0.5, 0.375, -0.375, 0.5, 0.4375},
			{-0.375, -0.5, 0.3125, -0.3125, 0.5, 0.375},
			{-0.3125, -0.5, 0.25, -0.25, 0.5, 0.3125},
			{-0.25, -0.5, 0.1875, -0.1875, 0.5, 0.25},
			{-0.1875, -0.5, 0.125, -0.125, 0.5, 0.1875},
			{-0.125, -0.5, 0.0625, -0.0625, 0.5, 0.125},
			{-0.0625, -0.5, 0, 0, 0.5, 0.0625},
			{0, -0.5, -0.0625, 0.0625, 0.5, 0},
			{0.0625, -0.5, -0.125, 0.125, 0.5, -0.0625},
			{0.125, -0.5, -0.1875, 0.1875, 0.5, -0.125},
			{0.1875, -0.5, -0.25, 0.25, 0.5, -0.1875},
			{0.25, -0.5, -0.3125, 0.3125, 0.5, -0.25},
			{0.3125, -0.5, -0.375, 0.375, 0.5, -0.3125},
			{0.375, -0.5, -0.4375, 0.4375, 0.5, -0.375},
			{0.4375, -0.5, -0.5, 0.5, 0.5, -0.4375}
		}
	}
	newnode.selection_box = newnode.node_box

	minetest.register_node("angled_walls:"..angledname.."_corner", newnode)

	local newnode2 = angled_walls.clone_node("angled_walls:"..angledname.."_corner")
	newnode2.tiles = { "angled_walls_"..angledname..".png^[transformFX" }
	newnode2.description = newnode.description.." (angled wall, 135 degrees)"
	newnode2.groups.not_in_creative_inventory = 1
	newnode2.drop = "angled_walls:"..angledname.."_corner"
	newnode2.node_box = {
		type = "fixed",
		fixed = {
			{0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
			{0.375, -0.5, 0.375, 0.4375, 0.5, 0.4375},
			{0.3125, -0.5, 0.3125, 0.375, 0.5, 0.375},
			{0.25, -0.5, 0.25, 0.3125, 0.5, 0.3125},
			{0.1875, -0.5, 0.1875, 0.25, 0.5, 0.25},
			{0.125, -0.5, 0.125, 0.1875, 0.5, 0.1875},
			{0.0625, -0.5, 0.0625, 0.125, 0.5, 0.125},
			{0, -0.5, 0, 0.0625, 0.5, 0.0625},
			{-0.0625, -0.5, -0.0625, 0, 0.5, 0},
			{-0.125, -0.5, -0.125, -0.0625, 0.5, -0.0625},
			{-0.1875, -0.5, -0.1875, -0.125, 0.5, -0.125},
			{-0.25, -0.5, -0.25, -0.1875, 0.5, -0.1875},
			{-0.3125, -0.5, -0.3125, -0.25, 0.5, -0.25},
			{-0.375, -0.5, -0.375, -0.3125, 0.5, -0.3125},
			{-0.4375, -0.5, -0.4375, -0.375, 0.5, -0.375},
			{-0.5, -0.5, -0.5, -0.4375, 0.5, -0.4375}
		}
	}
	newnode2.selection_box = newnode2.node_box

	minetest.register_node("angled_walls:"..angledname.."_corner_135", newnode2)

	local newnode3 = angled_walls.clone_node("angled_walls:"..angledname.."_corner")
	newnode3.description = newnode.description.." (angled wall, 225 degrees)"
	newnode3.tiles = { "angled_walls_"..angledname..".png^[transformFX" }
	newnode3.groups.not_in_creative_inventory = 1
	newnode3.drop = "angled_walls:"..angledname.."_corner"
	newnode3.node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
			{-0.4375, -0.5, 0.375, -0.375, 0.5, 0.4375},
			{-0.375, -0.5, 0.3125, -0.3125, 0.5, 0.375},
			{-0.3125, -0.5, 0.25, -0.25, 0.5, 0.3125},
			{-0.25, -0.5, 0.1875, -0.1875, 0.5, 0.25},
			{-0.1875, -0.5, 0.125, -0.125, 0.5, 0.1875},
			{-0.125, -0.5, 0.0625, -0.0625, 0.5, 0.125},
			{-0.0625, -0.5, 0, 0, 0.5, 0.0625},
			{0, -0.5, -0.0625, 0.0625, 0.5, 0},
			{0.0625, -0.5, -0.125, 0.125, 0.5, -0.0625},
			{0.125, -0.5, -0.1875, 0.1875, 0.5, -0.125},
			{0.1875, -0.5, -0.25, 0.25, 0.5, -0.1875},
			{0.25, -0.5, -0.3125, 0.3125, 0.5, -0.25},
			{0.3125, -0.5, -0.375, 0.375, 0.5, -0.3125},
			{0.375, -0.5, -0.4375, 0.4375, 0.5, -0.375},
			{0.4375, -0.5, -0.5, 0.5, 0.5, -0.4375}
		}
	}
	newnode3.selection_box = newnode3.node_box

	minetest.register_node("angled_walls:"..angledname.."_corner_225", newnode3)

	local newnode4 = angled_walls.clone_node("angled_walls:"..angledname.."_corner")
	newnode4.description = newnode.description.." (angled wall, 315 degrees)"
	newnode4.groups.not_in_creative_inventory = 1
	newnode4.drop = "angled_walls:"..angledname.."_corner"
	newnode4.node_box = {
		type = "fixed",
		fixed = {
			{0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
			{0.375, -0.5, 0.375, 0.4375, 0.5, 0.4375},
			{0.3125, -0.5, 0.3125, 0.375, 0.5, 0.375},
			{0.25, -0.5, 0.25, 0.3125, 0.5, 0.3125},
			{0.1875, -0.5, 0.1875, 0.25, 0.5, 0.25},
			{0.125, -0.5, 0.125, 0.1875, 0.5, 0.1875},
			{0.0625, -0.5, 0.0625, 0.125, 0.5, 0.125},
			{0, -0.5, 0, 0.0625, 0.5, 0.0625},
			{-0.0625, -0.5, -0.0625, 0, 0.5, 0},
			{-0.125, -0.5, -0.125, -0.0625, 0.5, -0.0625},
			{-0.1875, -0.5, -0.1875, -0.125, 0.5, -0.125},
			{-0.25, -0.5, -0.25, -0.1875, 0.5, -0.1875},
			{-0.3125, -0.5, -0.3125, -0.25, 0.5, -0.25},
			{-0.375, -0.5, -0.375, -0.3125, 0.5, -0.3125},
			{-0.4375, -0.5, -0.4375, -0.375, 0.5, -0.375},
			{-0.5, -0.5, -0.5, -0.4375, 0.5, -0.4375}
		}
	}
	newnode4.selection_box = newnode4.node_box

	minetest.register_node("angled_walls:"..angledname.."_corner_315", newnode4)

	minetest.register_alias("angled_walls:"..angledname.."_corner2", "angled_walls:"..angledname.."_corner_135")

end

