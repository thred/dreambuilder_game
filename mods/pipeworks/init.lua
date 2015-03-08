-- Pipeworks mod by Vanessa Ezekowitz - 2013-07-13
--
-- This mod supplies various steel pipes and plastic pneumatic tubes
-- and devices that they can connect to.
--
-- License: WTFPL
--

local modpath, worldpath = minetest.get_modpath("pipeworks"), minetest.get_worldpath()

pipeworks = {
	modpath = modpath,
	expect_infinite_stacks = minetest.setting_getbool("creative_mode") and not minetest.get_modpath("unified_inventory"),

	meseadjlist={{x=0,y=0,z=1},{x=0,y=0,z=-1},{x=0,y=1,z=0},{x=0,y=-1,z=0},{x=1,y=0,z=0},{x=-1,y=0,z=0}},
	rules_all = {{x=0, y=0, z=1},{x=0, y=0, z=-1},{x=1, y=0, z=0},{x=-1, y=0, z=0},
		{x=0, y=1, z=1},{x=0, y=1, z=-1},{x=1, y=1, z=0},{x=-1, y=1, z=0},
		{x=0, y=-1, z=1},{x=0, y=-1, z=-1},{x=1, y=-1, z=0},{x=-1, y=-1, z=0},
		{x=0, y=1, z=0}, {x=0, y=-1, z=0}},
	mesecons_rules={{x=0,y=0,z=1},{x=0,y=0,z=-1},{x=1,y=0,z=0},{x=-1,y=0,z=0},{x=0,y=1,z=0},{x=0,y=-1,z=0}},
	liquid_texture = "default_water.png"
}

dofile(modpath.."/default_settings.txt")

-- Read the external config file if it exists.
if io.open(worldpath.."/pipeworks_settings.txt","r") then
	dofile(worldpath.."/pipeworks_settings.txt")
	io.close()
end

-- Helper functions

function pipeworks.may_configure(pos, player)
	local name = player:get_player_name()
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")

	if owner ~= "" then -- wielders and filters
		return owner == name
	end
	return not minetest.is_protected(pos, name)
end

-------------------------------------------
-- Load the various other parts of the mod

dofile(modpath.."/common.lua")
dofile(modpath.."/models.lua")
dofile(modpath.."/autoplace_pipes.lua")
dofile(modpath.."/autoplace_tubes.lua")
dofile(modpath.."/luaentity.lua")
dofile(modpath.."/item_transport.lua")
dofile(modpath.."/flowing_logic.lua")
dofile(modpath.."/crafts.lua")
dofile(modpath.."/tube_registration.lua")
dofile(modpath.."/routing_tubes.lua")
dofile(modpath.."/sorting_tubes.lua")
dofile(modpath.."/vacuum_tubes.lua")
dofile(modpath.."/signal_tubes.lua")
dofile(modpath.."/decorative_tubes.lua")
dofile(modpath.."/filter-injector.lua")
dofile(modpath.."/trashcan.lua")
dofile(modpath.."/wielder.lua")

if pipeworks.enable_pipes then dofile(modpath.."/pipes.lua") end
if pipeworks.enable_teleport_tube then dofile(modpath.."/teleport_tube.lua") end
if pipeworks.enable_pipe_devices then dofile(modpath.."/devices.lua") end
if pipeworks.enable_redefines then dofile(modpath.."/compat.lua") end
if pipeworks.enable_autocrafter then dofile(modpath.."/autocrafter.lua") end

minetest.register_alias("pipeworks:pipe", "pipeworks:pipe_110000_empty")

print("Pipeworks loaded!")

