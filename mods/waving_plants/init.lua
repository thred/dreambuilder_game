-- This file just makes some tweaks to the various default plants and some
-- non-default ones that depend on plants_lib, to make them wave if the
-- appropriate shader is enabled.  This code is temporary and will be trimmed 
-- down as the mods supplying those objects are updated.

-- default stuff

for i = 1, 5 do 
	local new_grass = plantslib:clone_node("default:grass_"..i)
		new_grass.waving = 1
	minetest.register_node(":default:grass_"..i, new_grass)
end

local new_grass = plantslib:clone_node("default:junglegrass")
	new_grass.waving = 1
minetest.register_node(":default:junglegrass", new_grass)

-- farming, farming_plus 

for i = 1, 8 do
	local new_wheat = plantslib:clone_node("farming:wheat_"..i)
		new_wheat.waving = 1
	minetest.register_node(":farming:wheat_"..i, new_wheat)

	local new_cotton = plantslib:clone_node("farming:cotton_"..i)
		new_cotton.waving = 1
	minetest.register_node(":farming:cotton_"..i, new_cotton)
end

local new_weed = plantslib:clone_node("farming:weed")
	new_weed.waving = 1
minetest.register_node(":farming:weed", new_weed)

-- Undergrowth modpack

local new_youngtree = plantslib:clone_node("youngtrees:youngtree_top")
	new_youngtree.waving = 1
minetest.register_node(":youngtrees:youngtree_top", new_youngtree)

-- Ferns mod

for i = 1, 3 do
	local new_fern = plantslib:clone_node("ferns:fern_0"..i)
		new_fern.waving = 1
	minetest.register_node(":ferns:fern_0"..i, new_fern)
end

local new_fern = plantslib:clone_node("ferns:tree_fern_leaves")
	new_fern.waving = 1
minetest.register_node(":ferns:tree_fern_leaves", new_fern)

-- Dryplants mod

local new_reed = plantslib:clone_node("dryplants:reedmace_height_2")
	new_reed.waving = 1
minetest.register_node(":dryplants:reedmace_height_2", new_reed)

local new_reed = plantslib:clone_node("dryplants:reedmace_height_3")
	new_reed.waving = 1
minetest.register_node(":dryplants:reedmace_height_3", new_reed)

local new_reed = plantslib:clone_node("dryplants:reedmace_height_3_spikes")
	new_reed.waving = 1
minetest.register_node(":dryplants:reedmace_height_3_spikes", new_reed)

local new_juncus = plantslib:clone_node("dryplants:juncus")
	new_juncus.waving = 1
minetest.register_node(":dryplants:juncus", new_juncus)

local new_juncus = plantslib:clone_node("dryplants:juncus_02")
	new_juncus.waving = 1
minetest.register_node(":dryplants:juncus_02", new_juncus)

-- Farming plus

local new_leaves = plantslib:clone_node("farming_plus:banana_leaves")
	new_leaves.waving = 1
minetest.register_node(":farming_plus:banana_leaves", new_leaves)

local new_leaves = plantslib:clone_node("farming_plus:cocoa_leaves")
	new_leaves.waving = 1
minetest.register_node(":farming_plus:cocoa_leaves", new_leaves)

