local S = minetest.get_translator(minetest.get_current_modname())

mcl_stairs.register_stair_and_slab("stone_rough", {
	recipeitem = "mcl_core:stone",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:stone"}},
})

mcl_stairs.register_slab("stone", {
	recipeitem = "mcl_core:stone_smooth",
	tiles = {"mcl_stairs_stone_slab_top.png", "mcl_stairs_stone_slab_top.png", "mcl_stairs_stone_slab_side.png"},
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:stone_smooth"}},
})

mcl_stairs.register_stair_and_slab("andesite", {
	recipeitem = "mcl_core:andesite",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:andesite"}},
})
mcl_stairs.register_stair_and_slab("granite", {
	recipeitem = "mcl_core:granite",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:granite"}},
})
mcl_stairs.register_stair_and_slab("diorite", {
	recipeitem = "mcl_core:diorite",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:diorite"}},
})

mcl_stairs.register_stair_and_slab("cobble", {
	recipeitem = "mcl_core:cobble",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:cobble"}},
})
mcl_stairs.register_stair_and_slab("mossycobble", {
	recipeitem = "mcl_core:mossycobble",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:mossycobble"}},
})

mcl_stairs.register_stair_and_slab("brick_block", {
	recipeitem = "mcl_core:brick_block",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:brick_block"}},
})


mcl_stairs.register_stair_and_slab("sandstone", {
	recipeitem = "mcl_core:sandstone",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:sandstone"}},
})
mcl_stairs.register_stair_and_slab("sandstonesmooth2", {
	recipeitem = "mcl_core:sandstonesmooth2",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:sandstone"}},
})
mcl_stairs.register_stair_and_slab("sandstonesmooth", {
	recipeitem = "mcl_core:sandstonesmooth",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:sandstone", "mcl_core:sandstonesmooth2"}},
})

mcl_stairs.register_stair_and_slab("redsandstone", {
	recipeitem = "mcl_core:redsandstone",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:redsandstone"}},
})
mcl_stairs.register_stair_and_slab("redsandstonesmooth2", {
	recipeitem = "mcl_core:redsandstonesmooth2",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:redsandstone"}},
})
mcl_stairs.register_stair_and_slab("redsandstonesmooth", {
	recipeitem = "mcl_core:redsandstonesmooth",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:redsandstone", "mcl_core:redsandstonesmooth2"}},
})

mcl_stairs.register_stair_and_slab("stonebrick", {
	recipeitem = "mcl_core:stonebrick",
	base_description = S("Stone Brick"),
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:stone", "mcl_core:stonebrick"}}
})

mcl_stairs.register_stair_and_slab("andesite_smooth", {
	recipeitem = "mcl_core:andesite_smooth",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:andesite_smooth", "mcl_core:andesite"}}
})

mcl_stairs.register_stair_and_slab("granite_smooth", {
	recipeitem = "mcl_core:granite_smooth",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:granite_smooth", "mcl_core:granite"}}
})

mcl_stairs.register_stair_and_slab("diorite_smooth", {
	recipeitem = "mcl_core:diorite_smooth",
	extra_fields = {_mcl_stonecutter_recipes = {"mcl_core:diorite_smooth", "mcl_core:diorite"}}
})

mcl_stairs.register_stair("stonebrickmossy", {
	recipeitem = "mcl_core:stonebrickmossy",
	base_description = S("Mossy Stone Brick"),
	{_mcl_stonecutter_recipes = {"mcl_core:stonebrickmossy"}}
})
