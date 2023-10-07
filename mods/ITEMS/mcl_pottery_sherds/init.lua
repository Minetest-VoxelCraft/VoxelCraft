mcl_pottery_sherds = {}
local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

mcl_pottery_sherds.names = {"angler", "archer", "arms_up", "blade", "brewer", "burn", "danger", "explorer", "friend", "heartbreak", "heart", "howl", "miner", "mourner", "plenty", "prize", "sheaf", "shelter", "skull", "snort"}

local pot_face_positions = {
	vector.new(0,0, 7/16 + 0.001),
	vector.new(-7/16 - 0.001, 0, 0),
	vector.new(0, 0, -7/16 - 0.001),
	vector.new(7/16 + 0.001,  0, 0),
}

local pot_face_rotations = {
	vector.new(0, 0, 0),
	vector.new(0, 0.5 * math.pi, 0),
	vector.new(0, 0, 0),
	vector.new(0, -0.5 * math.pi, 0),
}

local function readable_name(str)
	str = str:gsub("_", " ")
    return (str:gsub("^%l", string.upper))
end

for _,name in pairs(mcl_pottery_sherds.names) do
	minetest.register_craftitem("mcl_pottery_sherds:"..name, {
		description = S(readable_name(name).." Pottery Sherd"),
		_tt_help = S("Used for crafting decorated pots"),
		_doc_items_create_entry = false,
		inventory_image = "mcl_pottery_sherds_"..name..".png",
		wield_image = "mcl_pottery_sherds_"..name..".png",
		groups = { pottery_sherd = 1, decorated_pot_recipe = 1 },
		_mcl_pottery_sherd_name = name,
	})
end

local brick_groups = table.copy(minetest.registered_items["mcl_core:brick"].groups)
brick_groups["decorated_pot_recipe"] = 1
minetest.override_item("mcl_core:brick", { groups = brick_groups })

minetest.register_entity("mcl_pottery_sherds:pot_face",{
	initial_properties = {
		physical = false,
		visual = "upright_sprite",
		visual_size = {x=1.0, y=1.0},
		collisionbox = {0,0,0,0,0,0},
		pointable = false,
	},
	on_activate = function(self, staticdata)
		self.object:set_armor_groups({immortal=1})
		local s = minetest.deserialize(staticdata)
		if type(s) == "table" then
			self.object:set_properties({
				textures = { s.texture },
			})
		end
	end,
	get_staticdata = function(self)
		return minetest.serialize({ texture = self.texture })
	end,
	on_step = function(self)
		if minetest.get_node(self.object:get_pos()).name ~= "mcl_pottery_sherds:pot" then
			self.object:remove()
		end
	end
})

local function update_entities(pos,rm)
	local pots = {}
	for _,v in pairs(minetest.get_objects_inside_radius(pos, 0.5, true)) do
		local ent = v:get_luaentity()
		if ent and ent.name == "mcl_pottery_sherds:pot_face" then
			v:remove()
		end
	end
	if rm then return end
	local param2 = minetest.get_node(pos).param2
	local meta = minetest.get_meta(pos)
	local faces = minetest.deserialize(meta:get_string("pot_faces"))
	if not faces then return end
	local s = ""
	for k,v in pairs(pot_face_positions) do
		local face = faces[(k + param2) % 4 + 1]
		if face then
			local o = minetest.add_entity(pos + v, "mcl_pottery_sherds:pot_face")
			local e = o:get_luaentity()
			e.texture = "mcl_pottery_sherds_pattern_"..face..".png"
			o:set_properties({
				textures = { "mcl_pottery_sherds_pattern_"..face..".png" },
			})
			o:set_rotation(pot_face_rotations[k])
		end
	end
end

local potbox = {
	type = "fixed",
	fixed = {
		{ -3/16,  8/16, -3/16,  3/16,  12/16,  3/16 },
		{ -7/16,  -8/16, -7/16,  7/16,  8/16,  7/16 },
	}
}

minetest.register_node("mcl_pottery_sherds:pot", {
	description = S("Decorated Pot"),
	_tt_help = S("Nice looking pot"),
	_doc_items_longdesc = S("Pots are decorative blocks."),
	_doc_items_usagehelp = S("Specially decorated pots can be crafted using pottery sherds"),
	drawtype = "nodebox",
	node_box = potbox,
	selection_box = potbox,
	collision_box = potbox,
	tiles = {
		{ name = "mcl_pottery_sherds_pot_top.png", align_style = "world" },
		{ name = "mcl_pottery_sherds_pot_bottom.png", align_style = "world" },
		{ name = "mcl_pottery_sherds_pot_side.png", align_style = "world" },
	},
	use_texture_alpha = "clip",
	wield_image = "mcl_pottery_sherds_pot_side.png",
	inventory_image = minetest.inventorycube("mcl_pottery_sherds_pot_top.png", "mcl_pottery_sherds_pot_bottom.png", "mcl_pottery_sherds_pot_bottom.png"),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = { dig_immediate = 3, deco_block = 1, attached_node = 1, dig_by_piston = 1, flower_pot = 1, not_in_creative_inventory = 1 },
	sounds = mcl_sounds.node_sound_stone_defaults(),
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		meta:set_string("pot_faces",itemstack:get_meta():get_string("pot_faces"))
		update_entities(pos)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		update_entities(pos,true)
	end,
	on_rotate = function(pos, _,  _, mode, new_param2)
		if mode == screwdriver.ROTATE_AXIS then
			return false
		end
	end,
	after_rotate = function(pos)
		update_entities(pos)
	end,
})

local function get_sherd_name(itemstack)
	local def = minetest.registered_items[itemstack:get_name()]
	local r = nil
	if def and def._mcl_pottery_sherd_name then
		r = def._mcl_pottery_sherd_name
	end
	return r
end

minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	if itemstack:get_name() ~= "mcl_pottery_sherds:pot" then return end
	if old_craft_grid[1][2] == "mcl_core:brick" then return end
	local meta = itemstack:get_meta()

	meta:set_string("pot_faces",minetest.serialize({
		get_sherd_name(old_craft_grid[2]),
		get_sherd_name(old_craft_grid[6]),
		get_sherd_name(old_craft_grid[4]),
		get_sherd_name(old_craft_grid[8]),
	}))
	return itemstack
end)

minetest.register_craft({
	output = "mcl_pottery_sherds:pot",
	recipe = {
		{ "", "group:decorated_pot_recipe", "" },
		{ "group:decorated_pot_recipe", "", "group:decorated_pot_recipe" },
		{ "", "group:decorated_pot_recipe", "" },
	}
})
