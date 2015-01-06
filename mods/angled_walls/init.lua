
-- simple mod to add 45 degree walls
-- exploits the torchlike draw type.
--
-- by Vanessa Ezekowitz

angled_walls = {}

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
	{ "default:brick",				"brick",				"slab_brick",				"default_brick.png" },
	{ "default:wood",				"wood",					"slab_wood",				"default_wood.png" },
	{ "default:junglewood",			"jungle_wood",			"slab_junglewood",			"default_junglewood.png" },
	{ "default:steelblock",			"steelblock",			"slab_steelblock",			"default_steel_block.png" },
	{ "default:sandstone",			"sandstone",			"slab_sandstone",			"default_sandstone.png" },
	{ "default:sandstonebrick",		"sandstone_brick",		"slab_sandstonebrick",		"default_sandstone_brick.png" },
	{ "default:cobble",				"cobble",				"slab_cobble",				"default_cobble.png" },
	{ "default:desert_cobble", 		"desert_cobble",		"slab_desert_cobble",		"default_desert_cobble.png" },
	{ "default:stone",				"stone",				"slab_stone",				"default_stone.png" },
	{ "default:stonebrick",			"stone_brick",			"slab_stonebrick",			"default_stone_brick.png" },
	{ "default:desert_stone",		"desert_stone",			"slab_desert_stone",		"default_desert_stone.png" },
	{ "default:desert_stonebrick",	"desert_stone_brick",	"slab_desert_stonebrick",	"default_desert_stone_brick.png" }
}

for i in ipairs(nodes_list) do

	local nodename =	nodes_list[i][1]
	local angledname =	nodes_list[i][2]
	local recipeitem =	nodes_list[i][3]
	local invtexture =	nodes_list[i][4]

	local cbox = {
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

	minetest.register_node("angled_walls:"..angledname.."_corner", {
		description = angledname.." (angled wall)",
		tiles = { "angled_walls_"..angledname..".png" },
		drawtype = "torchlike",
		inventory_image = invtexture,
		paramtype = "light",
		paramtype2 = "wallmounted",
		visual_scale = 1.414,
		drop = "angled_walls:"..angledname.."_corner",
		groups = { snappy=1 },
		collision_box = cbox,
		selection_box = cbox,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			angled_walls.rotate_to_45(pos, "angled_walls:"..angledname.."_corner")
		end,

	})

	local cbox = {
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

	minetest.register_node("angled_walls:"..angledname.."_corner_135", {
		description = angledname.." (angled wall, 135 degrees)",
		tiles = { "angled_walls_"..angledname..".png^[transformFX" },
		drawtype = "torchlike",
		paramtype = "light",
		paramtype2 = "wallmounted",
		visual_scale = 1.414,
		drop = "angled_walls:"..angledname.."_corner",
		groups = { snappy=1, not_in_creative_inventory = 1 },
		collision_box = cbox,
		selection_box = cbox,
	})

	local cbox = {
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

	minetest.register_node("angled_walls:"..angledname.."_corner_225", {
		description = angledname.." (angled wall, 225 degrees)",
		tiles = { "angled_walls_"..angledname..".png^[transformFX" },
		drawtype = "torchlike",
		paramtype = "light",
		paramtype2 = "wallmounted",
		visual_scale = 1.414,
		drop = "angled_walls:"..angledname.."_corner",
		groups = { snappy=1, not_in_creative_inventory = 1 },
		collision_box = cbox,
		selection_box = cbox,
	})

	local cbox = {
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

	minetest.register_node("angled_walls:"..angledname.."_corner_315", {
		description = angledname.." (angled wall, 315 degrees)",
		tiles = { "angled_walls_"..angledname..".png^[transformFX" },
		drawtype = "torchlike",
		paramtype = "light",
		paramtype2 = "wallmounted",
		visual_scale = 1.414,
		drop = "angled_walls:"..angledname.."_corner",
		groups = { snappy=1, not_in_creative_inventory = 1 },
		collision_box = cbox,
		selection_box = cbox,
	})

	minetest.register_alias("angled_walls:"..angledname.."_corner2", "angled_walls:"..angledname.."_corner_135")

	minetest.register_craft( {
	    output = "angled_walls:"..angledname.."_corner 12",
		recipe = {
			{ "", "", "stairs:"..recipeitem },
			{ "", "stairs:"..recipeitem, "" },
			{ "stairs:"..recipeitem, "", "" }
		}
	})

	if recipeitem ~= "slab_desert_cobble" then
		minetest.register_craft( {
			output = "angled_walls:"..angledname.."_corner 12",
			recipe = {
				{ "", "", "moreblocks:"..recipeitem },
				{ "", "moreblocks:"..recipeitem, "" },
				{ "moreblocks:"..recipeitem, "", "" }
			}
		})
	end
end

