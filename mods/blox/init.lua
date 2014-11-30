--[[
***********
Blox
by Sanchez
***********
--]]
local version = "0.6.1"

local DyeSub = ""

local BloxColours = {
	"pink",
	"yellow",
	"white",
	"orange",
	"purple",
	"blue",
	"cyan",
	"red",
	"green",
	"black",
}

local UNIFIED = {
	"magenta",
	"yellow",
	"white",
	"orange",
	"violet",
	"blue",
	"cyan",
	"red",
	"green",
	"black",
}

local BuiltInDyes = {
	"pink",
	"yellow",
	"white",
	"orange",
	"violet",
	"blue",
	"cyan",
	"red",
	"green",
	"black",
}

local FuelBlox = {
	"wood",
	"diamond_wood",
	"corner_wood",
	"checker_wood",
}

-- Nodes

minetest.register_node("blox:glowstone", {
	description = "Glowstone",
	tile_images = {"blox_glowstone.png"},
	--inventory_image = "blox_glowstone.png",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 30	,
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blox:glowore", {
	description = "Glow Ore",
	tile_images = {"default_stone.png^blox_glowore.png"},
	--inventory_image = {"default_stone.png^blox_glowore.png"},
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = false,
	light_source = 12	,
		drop = {
		max_items = 1,
		items = {
			{
				items = {"blox:glowstone"},
				rarity = 15,
			},
			{
				items = {"blox:glowdust"},
			}
		}
	},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blox:glowdust", {
	description = "Glow Dust",
	drawtype = "plantlike",
	tile_images = {"blox_glowdust.png"},
	inventory_image = "blox_glowdust.png",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 8	,
	walkable = false,
	groups = {cracky=3, snappy=3},
	})

	for _, colour in ipairs(BloxColours) do
	local cname = colour .. 'checker'

	minetest.register_node('blox:' .. cname, {
		description = colour .. " checker",
		tile_images = { 'blox_' .. cname .. '.png' },
		--inventory_image = 'blox_' .. cname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
	})

	local sname = colour .. 'square'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " stone square",
		tile_images = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
	})

	local sname = colour .. 'stone'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " stone",
		tile_images = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
	})

	local sname = colour .. 'cross'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " cross",
		tile_images = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
	})

	local sname = colour .. 'wood'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " wood",
		tile_images = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=1},
		sounds = default.node_sound_wood_defaults(),
	})

	local sname = colour .. 'loop'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " decorative block",
		tile_images = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
	})

	local sname = colour .. 'quarter'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " large checker",
		tile_images = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
	})

	local sname = colour .. 'quarter_wood'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " large wooden checker",
		tile_images = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=1},
		sounds = default.node_sound_wood_defaults(),
	})

	local sname = colour .. 'checker_wood'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " wooden checker",
		tile_images = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=1},
		sounds = default.node_sound_wood_defaults(),
	})

	local sname = colour .. 'corner'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " corners",
		tile_images = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
	})

	local sname = colour .. 'cobble'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " cobble",
		tile_images = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
	})

	local sname = colour .. 'diamond_wood'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " wooden diamond",
		tile_images = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=1},
		sounds = default.node_sound_wood_defaults(),
	})

	local sname = colour .. 'diamond'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " stone diamond",
		tile_images = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
	})
end

-- Crafting

minetest.register_craft({
	output = 'blox:glowstone 2',
	recipe = {
		{'', 'blox:glowdust', ''},
		{'blox:glowdust', 'default:stone', 'blox:glowdust'},
		{'', 'blox:glowdust', ''},
	}
})


for _, colour in ipairs(UNIFIED) do

if colour == "magenta" then
DyeSub = "pink" else if colour == "violet" then
DyeSub = "purple" else
DyeSub = colour
end
end

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'quarter 4',
	recipe = {
		{'default:stone', 'unifieddyes:' .. colour},
		{'unifieddyes:' .. colour, 'default:stone'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'quarter 4',
	recipe = {
		{'unifieddyes:' .. colour, 'default:stone'},
		{'default:stone', 'unifieddyes:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'square 6',
	recipe = {
		{'unifieddyes:' .. colour, 'default:stone', 'default:stone'},
		{'default:stone', 'unifieddyes:' .. colour, 'default:stone'},
		{'default:stone', 'default:stone', 'unifieddyes:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'stone 4',
	recipe = {
		{'', 'default:stone', ''},
		{'default:stone', 'unifieddyes:' .. colour, 'default:stone'},
		{'', 'default:stone', ''},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'cross 4',
	recipe = {
		{'default:stone', '', 'default:stone'},
		{'', 'unifieddyes:' .. colour, ''},
		{'default:stone', '', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'wood 4',
	recipe = {
		{'', 'default:wood', ''},
		{'default:wood', 'unifieddyes:' .. colour, 'default:wood'},
		{'', 'default:wood', ''},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'quarter_wood 4',
	recipe = {
		{'default:wood', 'unifieddyes:' .. colour},
		{'unifieddyes:' .. colour, 'default:wood'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'quarter_wood 4',
	recipe = {
		{'unifieddyes:' .. colour, 'default:wood'},
		{'default:wood', 'unifieddyes:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'checker_wood 6',
	recipe = {
		{'default:wood', 'unifieddyes:' .. colour,'default:wood'},
		{'unifieddyes:' .. colour, 'default:wood', 'unifieddyes:' .. colour},
		{'default:wood', 'unifieddyes:' .. colour,'default:wood'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'checker_wood 8',
	recipe = {
		{'unifieddyes:' .. colour, 'default:wood', 'unifieddyes:' .. colour},
		{'default:wood', 'unifieddyes:' .. colour,'default:wood'},
		{'unifieddyes:' .. colour, 'default:wood', 'unifieddyes:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'checker 6',
	recipe = {
		{'default:stone', 'unifieddyes:' .. colour,'default:stone'},
		{'unifieddyes:' .. colour, 'default:stone', 'unifieddyes:' .. colour},
		{'default:stone', 'unifieddyes:' .. colour,'default:stone'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'checker 8',
	recipe = {
		{'unifieddyes:' .. colour, 'default:stone', 'unifieddyes:' .. colour},
		{'default:stone', 'unifieddyes:' .. colour,'default:stone'},
		{'unifieddyes:' .. colour, 'default:stone', 'unifieddyes:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'loop 6',
	recipe = {
		{'default:stone', 'default:stone', 'default:stone'},
		{'default:stone', 'unifieddyes:' .. colour, 'default:stone'},
		{'default:stone', 'default:stone', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'cobble 4',
	recipe = {
		{'', 'default:cobble', ''},
		{'default:cobble', 'unifieddyes:' .. colour, 'default:cobble'},
		{'', 'default:cobble', ''},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'corner 4',
	recipe = {
		{'unifieddyes:' .. colour, '', 'unifieddyes:' .. colour},
		{'', 'default:stone', ''},
		{'unifieddyes:' .. colour, '', 'unifieddyes:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'diamond 6',
	recipe = {
		{'default:stone', 'unifieddyes:' .. colour, 'default:stone'},
		{'unifieddyes:' .. colour, '', 'unifieddyes:' .. colour},
		{'default:stone', 'unifieddyes:' .. colour, 'default:stone'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'diamond_wood 6',
	recipe = {
		{'default:wood', 'unifieddyes:' .. colour, 'default:wood'},
		{'unifieddyes:' .. colour, '', 'unifieddyes:' .. colour},
		{'default:wood', 'unifieddyes:' .. colour, 'default:wood'},
	}
})

end


for _, colour in ipairs(BuiltInDyes) do

if colour == "violet" then
DyeSub = "purple" else
DyeSub = colour
end

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'quarter 4',
	recipe = {
		{'default:stone', 'dye:' .. colour},
		{'dye:' .. colour, 'default:stone'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'quarter 4',
	recipe = {
		{'dye:' .. colour, 'default:stone'},
		{'default:stone', 'dye:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'square 6',
	recipe = {
		{'dye:' .. colour, 'default:stone', 'default:stone'},
		{'default:stone', 'dye:' .. colour, 'default:stone'},
		{'default:stone', 'default:stone', 'dye:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'stone 4',
	recipe = {
		{'', 'default:stone', ''},
		{'default:stone', 'dye:' .. colour, 'default:stone'},
		{'', 'default:stone', ''},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'cross 4',
	recipe = {
		{'default:stone', '', 'default:stone'},
		{'', 'dye:' .. colour, ''},
		{'default:stone', '', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'wood 4',
	recipe = {
		{'', 'default:wood', ''},
		{'default:wood', 'dye:' .. colour, 'default:wood'},
		{'', 'default:wood', ''},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'quarter_wood 4',
	recipe = {
		{'default:wood', 'dye:' .. colour},
		{'dye:' .. colour, 'default:wood'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'quarter_wood 4',
	recipe = {
		{'dye:' .. colour, 'default:wood'},
		{'default:wood', 'dye:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'checker_wood 6',
	recipe = {
		{'default:wood', 'dye:' .. colour,'default:wood'},
		{'dye:' .. colour, 'default:wood', 'dye:' .. colour},
		{'default:wood', 'dye:' .. colour,'default:wood'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'checker_wood 8',
	recipe = {
		{'dye:' .. colour, 'default:wood', 'dye:' .. colour},
		{'default:wood', 'dye:' .. colour,'default:wood'},
		{'dye:' .. colour, 'default:wood', 'dye:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'checker 6',
	recipe = {
		{'default:stone', 'dye:' .. colour,'default:stone'},
		{'dye:' .. colour, 'default:stone', 'dye:' .. colour},
		{'default:stone', 'dye:' .. colour,'default:stone'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'checker 8',
	recipe = {
		{'dye:' .. colour, 'default:stone', 'dye:' .. colour},
		{'default:stone', 'dye:' .. colour,'default:stone'},
		{'dye:' .. colour, 'default:stone', 'dye:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'loop 6',
	recipe = {
		{'default:stone', 'default:stone', 'default:stone'},
		{'default:stone', 'dye:' .. colour, 'default:stone'},
		{'default:stone', 'default:stone', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'cobble 4',
	recipe = {
		{'', 'default:cobble', ''},
		{'default:cobble', 'dye:' .. colour, 'default:cobble'},
		{'', 'default:cobble', ''},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'corner 4',
	recipe = {
		{'dye:' .. colour, '', 'dye:' .. colour},
		{'', 'default:stone', ''},
		{'dye:' .. colour, '', 'dye:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'diamond 6',
	recipe = {
		{'default:stone', 'dye:' .. colour, 'default:stone'},
		{'dye:' .. colour, '', 'dye:' .. colour},
		{'default:stone', 'dye:' .. colour, 'default:stone'},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'diamond_wood 6',
	recipe = {
		{'default:wood', 'dye:' .. colour, 'default:wood'},
		{'dye:' .. colour, '', 'dye:' .. colour},
		{'default:wood', 'dye:' .. colour, 'default:wood'},
	}
})

end

--Fuel
	for _, colour in ipairs(BloxColours) do

	for _, blox in ipairs(FuelBlox) do

minetest.register_craft({
	type = "fuel",
	recipe = "blox:" .. colour .. blox,
	burntime = 7,
})

end
end


-- Chunk sizes for ore generation (bigger = ore deposits are more scattered around)

glowore_chunk_size = 14


-- Amount of ore per chunk (higher = bigger ore deposits)
glowore_ore_per_chunk = 2


-- Minimal depths of ore generation (Y coordinate)
glowore_min_depth = -31000


-- Maximal depths of ore generation (Y coordinate)
glowore_max_depth = -2


-- Ore generation

local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x - minp.x + 1) * (y_max - y_min + 1) * (maxp.z - minp.z + 1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local chunk_size = 3
	if ore_per_chunk <= 4 then
		chunk_size = 2
	end
	local inverse_chance = math.floor(chunk_size * chunk_size * chunk_size / ore_per_chunk)
	-- print(generate_ore num_chunks: ..dump(num_chunks))
	for i=1,num_chunks do
	if (y_max-chunk_size+1 <= y_min) then return end
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1	
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.get_node(p2).name == wherein then
						minetest.set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
	-- print(generate_ore done)
end

minetest.register_on_generated(function(minp, maxp, seed)
	math.randomseed(os.time())
	local current_seed = seed + math.random(10, 100)
	local function get_next_seed()
		current_seed = current_seed + 1
		return current_seed
	end

	generate_ore("blox:glowore", "default:stone", minp, maxp, get_next_seed(),
	1/glowore_chunk_size/glowore_chunk_size/glowore_chunk_size, glowore_ore_per_chunk, glowore_min_depth, glowore_max_depth)
	
end)

print("Blox Mod [" ..version.. "] Loaded!")
