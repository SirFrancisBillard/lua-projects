g_ItemTable = {}
g_RecipeTable = {}

function RegisterItem(tab)
	local item = tab
	if not item.id or not item.name then return false end
	game.AddAmmoType({name = item.id, dmgtype = DMG_BULLET})
	if CLIENT then
		language.Add(item.id .. "_ammo", item.name)
	end
	item.func = item.func or "Use"
	item.use = item.use or function(ply) end
	if type(item.recipe) == "table" then
		item.oldUse = item.use
		item.use = function(ply)
			local good = true
			for k, v in pairs(item.recipe.needs) do
				if not ply:HasItem(k, v) then
					good = false
				end
			end
			if good then
				for k, v in pairs(item.recipe.needs) do
					ply:TakeItem(k, v)
				end
				ply:GiveItem(item.recipe.product)
			end
			return good
		end
	end
	item.model = item.model or "models/error.mdl"
	item.price = item.price or 10
	concommand.Add("_____use_item_" .. item.id, function(ply, cmd, args)
		if ply:HasItem(item.id) and SERVER and item.use(ply) then
			ply:TakeItem(item.id, 1)
		end
	end)
	g_ItemTable[item.id] = item
end

RegisterItem{
	id = "melon",
	name = "Watermelon",
	desc = "A lovely fruit.",
	func = "Eat",
	model = "models/props_junk/watermelon01.mdl",
	use = function(ply)
		ply:SetHealth(math.min(ply:Health() + 1, ply:GetMaxHealth()))
		return true
	end
}

RegisterItem{
	id = "fuel_can",
	name = "Gasoline",
	desc = "A can of gasoline.",
	func = "Use",
	model = "models/props_junk/gascan001a.mdl"
}

RegisterItem{
	id = "cloth_rags",
	name = "Cloth Rag",
	desc = "A rag made of cloth.",
	func = "Use",
	model = "models/props/cs_office/Paper_towels.mdl"
}

RegisterItem{
	id = "empty_bottle",
	name = "Empty Bottle",
	desc = "An empty glass bottle.",
	func = "Use",
	model = "models/props_junk/garbage_glassbottle003a.mdl"
}

RegisterItem{
	id = "schematic_molotov",
	name = "Molotov Schematic",
	desc = "A blueprint for a molotov cocktail.",
	func = "Make",
	model = "models/props_c17/paper01.mdl",
	recipe = {
		needs = {
			["empty_bottle"] = 1,
			["cloth_rags"] = 1,
			["fuel_can"] = 1
		},
		product = "item_molotov"
	}
}

RegisterItem{
	id = "item_molotov",
	name = "Molotov Cocktail",
	desc = "A highly explosive bottle of fuel.",
	func = "Equip",
	model = "models/props/CS_militia/bottle01.mdl",
	use = function(ply)
		ply:Give("weapon_molotov_c")
		return true
	end
}
