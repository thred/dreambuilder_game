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
for _, row in ipairs(ilights.types) do
	local name = row[1]
	local desc = row[2]

	-- Node Definition

	minetest.register_node("ilights:light_"..name, {
	    drawtype = "nodebox",
		description = desc.." Industrial Light",
		tiles = {"ilight_"..name..".png^ilight_top.png",
		         "ilight_base.png",
		         "ilight_"..name..".png^ilight_side.png"},
		groups = {cracky=3},
	    paramtype = "light",
	    paramtype2 = "facedir",
	    light_source = 15,
	    node_box = {
		    type = "fixed",
		    fixed = {
			    { -4/16, -7/16, -4/16,  4/16,  3/16,  4/16 }, -- Bulb
			    { -6/16, -8/16, -6/16,  6/16, -7/16,  6/16 }, -- Base

			    { -3/16, -7/16, -9/32, -2/16,  7/32,  9/32 }, -- Wire
			    {  2/16, -7/16, -9/32,  3/16,  7/32,  9/32 }, -- Wire
			    { -9/32, -7/16, -3/16,  9/32,  7/32, -2/16 }, -- Wire
			    {  9/32, -7/16,  2/16, -9/32,  7/32,  3/16 }, -- Wire

			    { -9/32,  0/16, -9/32,  9/32,  1/16,  9/32 }, -- Side Wire
			    { -9/32, -5/16, -9/32,  9/32, -4/16,  9/32 }  -- Side Wire
		    },
	    },

		selection_box = {
			type = "fixed",
			fixed = { -6/16, -8/16, -6/16, 6/16, 7/32, 6/16 }
		},
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
