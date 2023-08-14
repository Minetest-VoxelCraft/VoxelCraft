
--these are the "rotation strings" of the old sign rotation scheme
local rotkeys = {
	"22_5",
	"45",
	"67_5"
}
--this is a translation table for the old sign rotation scheme to degrotate
--the first level is the itemstring part and the second level represents
--the facedir param2 (+1) mapped to the degrotate param2
local nidp2_degrotate = {
	["22_5"] = {
		225,
		165,
		105,
		45,
	},
	["45"] = {
		210,
		150,
		90,
		30,
	},
	["67_5"] = {
		195,
		135,
		75,
		15,
	}
}

function mcl_signs.upgrade_sign_meta(pos)
		local m = minetest.get_meta(pos)
		local col = m:get_string("mcl_signs:text_color")
		local glo = m:get_string("mcl_signs:glowing_sign")
		if col ~= "" then
			m:set_string("color",col)
			m:set_string("mcl_signs:text_color","")
		end
		if glo == "true" then
			m:set_string("glow",glo)
		end
		if glo ~= "" then
			m:set_string("mcl_signs:glowing_sign","")
		end
		mcl_signs.get_text_entity (pos, true) -- the 2nd "true" arg means deleting the entity for respawn
end

function mcl_signs.upgrade_sign_rot(pos,node)
	local numsign = false
	for _,v in pairs(rotkeys) do
		if node.name:find(v) then
			node.name = node.name:gsub(v,"")
			node.param2 = nidp2_degrotate[v][node.param2 + 1]
			numsign = true
		end
	end
	if not numsign then
		local def = minetest.registered_nodes[node.name]
		if def and def._mcl_sign_type == "standing" then
			if node.param2 == 1 or node.param2 == 121 then
				node.param2 = 180
			elseif node.param2 == 2 or node.param2 == 122 then
				node.param2 = 120
			elseif node.param2 == 3 or node.param2 == 123 then
				node.param2 = 60
			end
		end
	end
	minetest.swap_node(pos,node)
	mcl_signs.upgrade_sign_meta(pos)
	mcl_signs.update_sign(pos)
end

minetest.register_lbm({
	nodenames = {"group:sign"},
	name = "mcl_signs:update_old_signs",
	label = "Update old signs",
	run_at_every_load = false,
	action = mcl_signs.upgrade_sign_rot,
})

minetest.register_lbm({
	nodenames = mcl_signs.old_rotnames,
	name = "mcl_signs:update_old_rotated_standing",
	label = "Update old standing rotated signs",
	run_at_every_load = true, --these nodes are supposed to completely be replaced
	action = mcl_signs.upgrade_sign_rot
})
