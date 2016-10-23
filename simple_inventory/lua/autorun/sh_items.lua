g_ItemTable = {}

function RegisterItem(tab)
	local item = tab
	if not item.id or not item.name then return end
	item.func = item.func or "Use"
	item.use = item.use or "nope"
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
	id = "medkit",
	name = "Medical Kit",
	desc = "A large kit filled with medical supplies.",
	func = "Use",
	model = "models/Items/HealthKit.mdl",
	use = function(ply)
		ply:SetHealth(math.min(ply:Health() + 40, ply:GetMaxHealth()))
		return true
	end
}

RegisterItem{
	id = "health_vial",
	name = "Health Vial",
	desc = "A small vial filled with medicine.",
	func = "Use",
	model = "models/healthvial.mdl",
	use = function(ply)
		ply:SetHealth(math.min(ply:Health() + 20, ply:GetMaxHealth()))
		return true
	end
}

RegisterItem{
	id = "kevlar",
	name = "Kevlar Vest",
	desc = "A suitcase with armor inside.",
	func = "Equip",
	model = "models/props_c17/SuitCase_Passenger_Physics.mdl",
	use = function(ply)
		ply:SetArmor(100)
		return true
	end
}

RegisterItem{
	id = "kettle",
	name = "Kettle",
	desc = "A small kettle for making hot beverages.",
	func = "Use",
	model = "models/props_interiors/pot01a.mdl"
}

RegisterItem{
	id = "coffee_grounds",
	name = "Coffee Grounds",
	desc = "A small bag of coffee grounds.",
	func = "Roast",
	model = "models/props_junk/garbage_bag001a.mdl",
	use = function(ply)
		if ply:HasItem("kettle") then
			ply:GiveItem("coffee")
			return true
		else
			return false
		end
	end
}

RegisterItem{
	id = "coffee",
	name = "Coffee",
	desc = "A mug filled with hot coffee.",
	func = "Drink",
	model = "models/props_junk/garbage_coffeemug001a.mdl",
	use = function(ply)
		ply:SetHealth(math.min(ply:Health() + 12, ply:GetMaxHealth()))
		return true
	end
}
