local S = minetest.get_translator("mcl_banners")

-- Pattern crafting. This file contains the code for crafting all the
-- emblazonings you can put on the banners. It's quite complicated;
-- run-of-the-mill crafting won't work here.

-- Maximum number of layers which can be put on a banner by crafting.
local max_layers_crafting = 12

-- Maximum number of layers when banner includes a gradient (workaround, see below).
local max_layers_gradient = 3

-- Max. number lines in the descriptions for the banner layers.
-- This is done to avoid huge tooltips.
local max_layer_lines = 6

-- List of patterns with crafting rules
local d = "group:dye" -- dye
local e = "" -- empty slot (one of them must contain the banner)
local patterns = {
	["border"] = {
		name = S("%s Bordure"),
		{ d, d, d },
		{ d, e, d },
		{ d, d, d },
	},
	["bricks"] = {
		name = S("%s Bricks"),
		type = "shapeless",
		{ e, "mcl_core:brick_block", d },
	},
	["circle"] = {
		name = S("%s Roundel"),
		{ e, e, e },
		{ e, d, e },
		{ e, e, e },
	},
	["creeper"] = {
		name = S("%s Creeper Charge"),
		type = "shapeless",
		{ e, "mcl_heads:creeper", d },
	},
	["cross"] = {
		name = S("%s Saltire"),
		{ d, e, d },
		{ e, d, e },
		{ d, e, d },
	},
	["curly_border"] = {
		name = S("%s Bordure Indented"),
		type = "shapeless",
		{ e, "mcl_core:vine", d },
	},
	["diagonal_up_left"] = {
		name = S("%s Per Bend Inverted"),
		{ e, e, e },
		{ d, e, e },
		{ d, d, e },
	},
	["diagonal_up_right"] = {
		name = S("%s Per Bend Sinister Inverted"),
		{ e, e, e },
		{ e, e, d },
		{ e, d, d },
	},
	["diagonal_right"] = {
		name = S("%s Per Bend"),
		{ e, d, d },
		{ e, e, d },
		{ e, e, e },
	},
	["diagonal_left"] = {
		name = S("%s Per Bend Sinister"),
		{ d, d, e },
		{ d, e, e },
		{ e, e, e },
	},
	["flower"] = {
		name = S("%s Flower Charge"),
		type = "shapeless",
		{ e, "mcl_flowers:oxeye_daisy", d },
	},
	["gradient"] = {
		name = S("%s Gradient"),
		{ d, e, d },
		{ e, d, e },
		{ e, d, e },
	},
	["gradient_up"] = {
		name = S("%s Base Gradient"),
		{ e, d, e },
		{ e, d, e },
		{ d, e, d },
	},
	["half_horizontal_bottom"] = {
		name = S("%s Per Fess Inverted"),
		{ e, e, e },
		{ d, d, d },
		{ d, d, d },
	},
	["half_horizontal"] = {
		name = S("%s Per Fess"),
		{ d, d, d },
		{ d, d, d },
		{ e, e, e },
	},
	["half_vertical"] = {
		name = S("%s Per Pale"),
		{ d, d, e },
		{ d, d, e },
		{ d, d, e },
	},
	["half_vertical_right"] = {
		name = S("%s Per Pale Inverted"),
		{ e, d, d },
		{ e, d, d },
		{ e, d, d },
	},
	["thing"] = {
		-- Symbol used for the “Thing”: U+1F65D 🙝

		name = S("%s Thing Charge"),
		type = "shapeless",
		-- TODO: Replace with enchanted golden apple
		{ e, "mcl_core:apple_gold", d },
	},
	["rhombus"] = {
		name = S("%s Lozenge"),
		{ e, d, e },
		{ d, e, d },
		{ e, d, e },
	},
	["skull"] = {
		name = S("%s Skull Charge"),
		type = "shapeless",
		{ e, "mcl_heads:wither_skeleton", d },
	},
	["small_stripes"] = {
		name = S("%s Paly"),
		{ d, e, d },
		{ d, e, d },
		{ e, e, e },
	},
	["square_bottom_left"] = {
		name = S("%s Base Dexter Canton"),
		{ e, e, e },
		{ e, e, e },
		{ d, e, e },
	},
	["square_bottom_right"] = {
		name = S("%s Base Sinister Canton"),
		{ e, e, e },
		{ e, e, e },
		{ e, e, d },
	},
	["square_top_left"] = {
		name = S("%s Chief Dexter Canton"),
		{ d, e, e },
		{ e, e, e },
		{ e, e, e },
	},
	["square_top_right"] = {
		name = S("%s Chief Sinister Canton"),
		{ e, e, d },
		{ e, e, e },
		{ e, e, e },
	},
	["straight_cross"] = {
		name = S("%s Cross"),
		{ e, d, e },
		{ d, d, d },
		{ e, d, e },
	},
	["stripe_bottom"] = {
		name = S("%s Base"),
		{ e, e, e },
		{ e, e, e },
		{ d, d, d },
	},
	["stripe_center"] = {
		name = S("%s Pale"),
		{ e, d, e },
		{ e, d, e },
		{ e, d, e },
	},
	["stripe_downleft"] = {
		name = S("%s Bend Sinister"),
		{ e, e, d },
		{ e, d, e },
		{ d, e, e },
	},
	["stripe_downright"] = {
		name = S("%s Bend"),
		{ d, e, e },
		{ e, d, e },
		{ e, e, d },
	},
	["stripe_left"] = {
		name = S("%s Pale Dexter"),
		{ d, e, e },
		{ d, e, e },
		{ d, e, e },
	},
	["stripe_middle"] = {
		name = S("%s Fess"),
		{ e, e, e },
		{ d, d, d },
		{ e, e, e },
	},
	["stripe_right"] = {
		name = S("%s Pale Sinister"),
		{ e, e, d },
		{ e, e, d },
		{ e, e, d },
	},
	["stripe_top"] = {
		name = S("%s Chief"),
		{ d, d, d },
		{ e, e, e },
		{ e, e, e },
	},
	["triangle_bottom"] = {
		name = S("%s Chevron"),
		{ e, e, e },
		{ e, d, e },
		{ d, e, d },
	},
	["triangle_top"] = {
		name = S("%s Chevron Inverted"),
		{ d, e, d },
		{ e, d, e },
		{ e, e, e },
	},
	["triangles_bottom"] = {
		name = S("%s Base Indented"),
		{ e, e, e },
		{ d, e, d },
		{ e, d, e },
	},
	["triangles_top"] = {
		name = S("%s Chief Indented"),
		{ e, d, e },
		{ d, e, d },
		{ e, e, e },
	},
}

-- Just a simple reverse-lookup table from dye itemstring to banner color ID
-- to avoid some pointless future iterations.
local dye_to_colorid_mapping = {}
for colorid, colortab in pairs(mcl_banners.colors) do
	dye_to_colorid_mapping[colortab[5]] = colorid
end

-- Create a banner description containing all the layer names
mcl_banners.make_advanced_banner_description = function(description, layers)
	if layers == nil or #layers == 0 then
		-- No layers, revert to default
		return ""
	else
		local layerstrings = {}
		for l=1, #layers do
			-- Prevent excess length description
			if l > max_layer_lines then
				break
			end
			-- Layer text line.
			local color = mcl_banners.colors[layers[l].color][6]
			local pattern_name = patterns[layers[l].pattern].name
			-- The pattern name is a format string (e.g. “%s Base”)
			table.insert(layerstrings, string.format(pattern_name, color))
		end
		-- Warn about missing information
		if #layers == max_layer_lines + 1 then
			table.insert(layerstrings, S("And one addional layer"))
		elseif #layers > max_layer_lines + 1 then
			table.insert(layerstrings, string.format(S("And %d addional layers"), #layers - max_layer_lines))
		end

		-- Final string concatenations: Just a list of strings
		local append = table.concat(layerstrings, "\n")
		description = description .. "\n" .. core.colorize("#8F8F8F", append)
		return description
	end
end

--[[ This is for handling all those complex pattern crafting recipes.
Parameters same as for minetest.register_craft_predict.
craft_predict is set true when called from minetest.craft_preview, in this case, this function
MUST NOT change the crafting grid.
]]
local banner_pattern_craft = function(itemstack, player, old_craft_grid, craft_inv, craft_predict)
	if minetest.get_item_group(itemstack:get_name(), "banner") ~= 1 then
		return
	end

	--[[ Basic item checks: Banners and dyes ]]
	local banner -- banner item
	local banner2 -- second banner item (used when copying)
	local dye -- itemstring of the dye being used
	local banner_index -- crafting inventory index of the banner
	local banner2_index
	for i = 1, player:get_inventory():get_size("craft") do
		local itemname = old_craft_grid[i]:get_name()
		if minetest.get_item_group(itemname, "banner") == 1 then
			if not banner then
				banner = old_craft_grid[i]
				banner_index = i
			elseif not banner2 then
				banner2 = old_craft_grid[i]
				banner2_index = i
			else
				return
			end
		-- Check if all dyes are equal
		elseif minetest.get_item_group(itemname, "dye") == 1 then
			if dye == nil then
				dye = itemname
			elseif itemname ~= dye then
				return ItemStack("")
			end
		end
	end
	if not banner then
		return
	end

	--[[ Check copy ]]
	if banner2 then
		-- Two banners found: This means copying!

		local b1meta = banner:get_meta()
		local b2meta = banner2:get_meta()
		local b1layers_raw = b1meta:get_string("layers")
		local b2layers_raw = b2meta:get_string("layers")
		local b1layers = minetest.deserialize(b1layers_raw)
		local b2layers = minetest.deserialize(b2layers_raw)
		if type(b1layers) ~= "table" then
			b1layers = {}
		end
		if type(b2layers) ~= "table" then
			b2layers = {}
		end

		-- For copying to be allowed, one banner has to have no layers while the other one has at least 1 layer.
		-- The banner with layers will be used as a source.
		local src_banner, src_layers, src_layers_raw, src_desc, src_index
		if #b1layers == 0 and #b2layers > 0 then
			src_banner = banner2
			src_layers = b2layers
			src_layers_raw = b2layers_raw
			src_desc = minetest.registered_items[src_banner:get_name()].description
			src_index = banner2_index
		elseif #b2layers == 0 and #b1layers > 0 then
			src_banner = banner
			src_layers = b1layers
			src_layers_raw = b1layers_raw
			src_desc = minetest.registered_items[src_banner:get_name()].description
			src_index = banner_index
		else
			return ItemStack("")
		end

		-- Set output metadata
		local imeta = itemstack:get_meta()
		imeta:set_string("layers", src_layers_raw)
		-- Generate new description. This clears any (anvil) name from the original banners.
		imeta:set_string("description", mcl_banners.make_advanced_banner_description(src_desc, src_layers))

		if not craft_predict then
			-- Don't destroy source banner so this recipe is a true copy
			craft_inv:set_stack("craft", src_index, src_banner)
		end

		return itemstack
	end

	-- No two banners found
	-- From here on we check which banner pattern should be added

	--[[ Check patterns ]]

	-- Get old layers
	local ometa = banner:get_meta()
	local layers_raw = ometa:get_string("layers")
	local layers = minetest.deserialize(layers_raw)
	if type(layers) ~= "table" then
		layers = {}
	end
	-- Disallow crafting when a certain number of layers is reached or exceeded
	if #layers >= max_layers_crafting then
		return ItemStack("")
	end
	-- Lower layer limit when banner includes any gradient.
	-- Workaround to circumvent Minetest bug (https://github.com/minetest/minetest/issues/6210)
	-- TODO: Remove this restriction when bug #6210 is fixed.
	if #layers >= max_layers_gradient then
		for l=1, #layers do
			if layers[l].pattern == "gradient" or layers[l].pattern == "gradient_up" then
				return ItemStack("")
			end
		end
	end

	local matching_pattern
	local max_i = player:get_inventory():get_size("craft")
	-- Find the matching pattern
	for pattern_name, pattern in pairs(patterns) do
		-- Shaped / fixed
		if pattern.type == nil then
			local pattern_ok = true
			local inv_i = 1
			-- This complex code just iterates through the pattern slots one-by-one and compares them with the pattern
			for p=1, #pattern do
				local row = pattern[p]
				for r=1, #row do
					local itemname = old_craft_grid[inv_i]:get_name()
					local pitem = row[r]
					if (pitem == d and minetest.get_item_group(itemname, "dye") == 0) or (pitem == e and itemname ~= e and inv_i ~= banner_index) then
						pattern_ok = false
						break
					else
					end
					inv_i = inv_i + 1
					if inv_i > max_i then
						break
					end
				end
				if inv_i > max_i then
					break
				end
			end
			-- Everything matched! We found our pattern!
			if pattern_ok then
				matching_pattern = pattern_name
				break
			end

		elseif pattern.type == "shapeless" then
			local orig = pattern[1]
			local no_mismatches_so_far = true
			-- This code compares the craft grid with the required items
			for o=1, #orig do
				local item_ok = false
				for i=1, max_i do
					local itemname = old_craft_grid[i]:get_name()
					if (orig[o] == e) or -- Empty slot: Always wins
							(orig[o] ~= e and orig[o] == itemname) or -- non-empty slot: Exact item match required
							(orig[o] == d and minetest.get_item_group(itemname, "dye") == 1) then -- Dye slot
						item_ok = true
						break
					end
				end
				-- Sorry, item not found. :-(
				if not item_ok then
					no_mismatches_so_far = false
					break
				end
			end
			-- Ladies and Gentlemen, we have a winner!
			if no_mismatches_so_far then
				matching_pattern = pattern_name
				break
			end
		end

		if matching_pattern then
			break
		end
	end
	if not matching_pattern then
		return ItemStack("")
	end

	-- Add the new layer and update other metadata
	local color = dye_to_colorid_mapping[dye]
	table.insert(layers, {pattern=matching_pattern, color=color})

	local imeta = itemstack:get_meta()
	imeta:set_string("layers", minetest.serialize(layers))

	local mname = ometa:get_string("name")
	-- Only change description if banner does not have a name
	if mname == "" then
		local odesc = itemstack:get_definition().description
		local description = mcl_banners.make_advanced_banner_description(odesc, layers)
		imeta:set_string("description", description)
	else
		imeta:set_string("description", ometa:get_string("description"))
		imeta:set_string("name", mname)
	end
	return itemstack
end

minetest.register_craft_predict(function(itemstack, player, old_craft_grid, craft_inv)
	return banner_pattern_craft(itemstack, player, old_craft_grid, craft_inv, true)
end)
minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	return banner_pattern_craft(itemstack, player, old_craft_grid, craft_inv, false)
end)

-- Register crafting recipes for all the patterns
for pattern_name, pattern in pairs(patterns) do
	-- Shaped and fixed recipes
	if pattern.type == nil then
		for colorid, colortab in pairs(mcl_banners.colors) do
			local banner = "mcl_banners:banner_item_"..colortab[1]
			local bannered = false
			local recipe = {}
			for row_id=1, #pattern do
				local row = pattern[row_id]
				local newrow = {}
				for r=1, #row do
					if row[r] == e and not bannered then
						newrow[r] = banner
						bannered = true
					else
						newrow[r] = row[r]
					end
				end
				table.insert(recipe, newrow)
			end
			minetest.register_craft({
				output = banner,
				recipe = recipe,
			})
		end
	-- Shapeless recipes
	elseif pattern.type == "shapeless" then
		for colorid, colortab in pairs(mcl_banners.colors) do
			local banner = "mcl_banners:banner_item_"..colortab[1]
			local orig = pattern[1]
			local recipe = {}
			for r=1, #orig do
				if orig[r] == e then
					recipe[r] = banner
				else
					recipe[r] = orig[r]
				end
			end

			minetest.register_craft({
				type = "shapeless",
				output = banner,
				recipe = recipe,
			})
		end
	end
end

-- Register crafting recipe for copying the banner pattern
for colorid, colortab in pairs(mcl_banners.colors) do
	local banner = "mcl_banners:banner_item_"..colortab[1]
	minetest.register_craft({
		type = "shapeless",
		output = banner,
		recipe = { banner, banner },
	})
end
