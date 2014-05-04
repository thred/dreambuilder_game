
-- Redefine grass and dirt nodes

dirt = mushroom:clone_node("default:dirt")
	dirt.drop = {
		max_items = 2,
		items = {
			{
				items = {'mushroom:spore1'},
				rarity = 40,
			},
			{
				items = {'mushroom:spore2'},
				rarity = 40,
			},
			{
				items = {'default:dirt'},
			}
		}
	}

minetest.register_node(":default:dirt", dirt)

dirt_with_grass = mushroom:clone_node("default:dirt_with_grass")
	dirt_with_grass.drop = {
		max_items = 2,
		items = {
			{
				items = {'mushroom:spore1'},
				rarity = 40,
			},
			{
				items = {'mushroom:spore2'},
				rarity = 40,
			},
			{
				items = {'default:dirt'},
			}
		}
	}

minetest.register_node(":default:dirt_with_grass", dirt_with_grass)

