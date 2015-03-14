-- Industrial lights mod by DanDuncombe
-- License: CC-By-Sa

ilights = {}

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end

if minetest.get_modpath("unified_inventory") or not minetest.setting_getbool("creative_mode") then
	ilights.expect_infinite_stacks = false
else
	ilights.expect_infinite_stacks = true
end

ilights.modpath = minetest.get_modpath("ilights")

-- The important stuff!

ilights.types = {
	{"white",      "White"},
	{"grey",       "Grey"},
	{"black",      "Black"},
	{"red",        "Red"},
	{"yellow",     "Yellow"},
	{"green",      "Green"},
	{"cyan",       "Cyan"},
	{"blue",       "Blue"},
	{"magenta",    "Magenta"},
	{"orange",     "Orange"},
	{"violet",     "Violet"},
	{"dark_grey",  "Dark Grey"},
	{"dark_green", "Dark Green"},
	{"pink", "Pink", "pink"},
	{"brown", "Brown", "brown"},
}

local lamp_cbox = {
	type = "fixed",
	fixed = { -11/32, -8/16, -11/32, 11/32, 4/16, 11/32 }
}

for _, row in ipairs(ilights.types) do
	local name = row[1]
	local desc = row[2]

	-- Node Definition

	minetest.register_node("ilights:light_"..name, {
		description = desc.." Industrial Light",
	    drawtype = "mesh",
		mesh = "ilights_lamp.obj",
		tiles = {"ilights_lamp_"..name..".png"},
		groups = {cracky=3},
	    paramtype = "light",
	    paramtype2 = "facedir",
	    light_source = 15,
		selection_box = lamp_cbox,
		collision_box = lamp_cbox,
		on_place = minetest.rotate_node
	})

	if name then

		--Choose craft material
		minetest.register_craft({
			output = "ilights:light_"..name.." 3",
			recipe = {
				{ "",                     "default:steel_ingot",  "" },
				{ "dye:"..name,           "default:glass",        "dye:"..name },
				{ "default:steel_ingot",  "default:torch",        "default:steel_ingot" }
			},
		})

	end
end
