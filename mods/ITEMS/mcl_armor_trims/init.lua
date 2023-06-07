mcl_armor_trims = {
    blacklisted = {["mcl_farming:pumpkin_face"]=true, ["mcl_armor:elytra"]=true, ["mcl_armor:elytra_enchanted"]=true},
    overlays    = {"sentry","dune","coast","wild","tide","ward","vex","rib","snout","eye","spire"},
    colors      = {["amethyst"]="#8246a5",["gold"]="#ce9627",["emerald"]="#1b9958",["copper"]="#c36447",["diamond"]="#5faed8",["iron"]="#938e88",["lapis"]="#1c306b",["netherite"]="#302a26",["quartz"]="#c9bcb9",["redstone"]="#af2c23"}
}

local function define_items()
    local register_list = {}
    for itemname, itemdef in pairs(minetest.registered_tools) do
        if itemdef._mcl_armor_texture and type(itemdef._mcl_armor_texture) == "string" and not mcl_armor_trims.blacklisted[itemname] then
            for _, overlay in pairs(mcl_armor_trims.overlays) do
                for mineral, color in pairs(mcl_armor_trims.colors) do
                    local new_name = itemname .. "_trimmed_" .. overlay .. "_" .. mineral
                    local new_def = table.copy(itemdef)

                    local piece_overlay = overlay
                    local invOverlay = ""
                    if string.find(itemname,"helmet") then
                        invOverlay = "^(helmet_trim.png"
                        piece_overlay = piece_overlay .. "_helmet"
                    elseif string.find(itemname,"chestplate") then
                        invOverlay = "^(chestplate_trim.png"
                        piece_overlay = piece_overlay .. "_chestplate"
                    elseif string.find(itemname,"leggings") then
                        invOverlay = "^(leggings_trim.png"
                        piece_overlay = piece_overlay .. "_leggings"
                    elseif string.find(itemname,"boots") then
                        invOverlay = "^(boots_trim.png"
                        piece_overlay = piece_overlay .. "_boots"
                    end

                    invOverlay = invOverlay .. "^[colorize:" .. color .. ":150)"
                    piece_overlay = piece_overlay .. ".png"

                    new_def.groups.not_in_creative_inventory = 1
                    new_def.groups.not_in_craft_guide = 1
                    new_def._mcl_armor_texture = new_def._mcl_armor_texture .. "^(" .. piece_overlay .. "^[colorize:" .. color .. ":150)"
                    new_def.inventory_image = itemdef.inventory_image .. invOverlay

                    if string.find(itemname, "_enchanted") then
                        new_def._mcl_enchanting_enchanted_tool = new_name
                    else
                        new_def._mcl_enchanting_enchanted_tool = itemname .. "_enchanted_trimmed_" .. overlay .. "_" .. mineral
                    end
                    register_list[":" .. new_name] = new_def
                end
            end
        end
    end

    for new_name, new_def in pairs(register_list) do
        minetest.register_tool(new_name, new_def)
    end
end

minetest.register_on_mods_loaded(define_items)
dofile(minetest.get_modpath(minetest.get_current_modname()).."/templates.lua")