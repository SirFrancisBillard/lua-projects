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

-- DRUGS

RegisterItem{
	id = "cocaine",
	name = "Cocaine",
	desc = "A highly addictive nervous stimulant.",
	func = "Use",
	model = "models/cocn.mdl",
	use = function(ply)
		if math.random(1, 10) == 1 then
			ply:Kill()
			return true
		else
			ply._PreCokeWalkSpeed = ply:GetWalkSpeed()
			ply._PreCokeRunSpeed = ply:GetRunSpeed()
			ply:SetWalkSpeed(ply:GetWalkSpeed() * 2)
			ply:SetRunSpeed(ply:GetRunSpeed() * 2)
			ply:ConCommand("pp_mat_overlay models/shadertest/shader3")
			ply:ConCommand("pp_mat_overlay_refractamount 0.05")
			timer.Simple(60, function()
				if not IsValid(ply) then return end
				ply:ConCommand("pp_mat_overlay \"\"")
				ply:SetWalkSpeed(ply._PreCokeWalkSpeed)
				ply:SetRunSpeed(ply._PreCokeRunSpeed)
			end )
			local sayings = {
				"HOW CAN I SHOOT WITH A FREAKING MELON ?",
				"IM FLYING AS A FOOTBALL!?",
				"IM FASTER THAN MY LOVELY BILLIES!"
			}
			ply:ConCommand("say " .. sayings[math.random(1, #sayings)])
			return true
		end
	end
}

RegisterItem{
	id = "heroin",
	name = "Heroin",
	desc = "Deadly narcotic type, but it gives an exiting feeling when you put a needle of it in your arm.",
	func = "Use",
	model = "models/katharsmodels/syringe_out/syringe_out.mdl",
	use = function(ply)
		if math.random(1, 10) == 1 then
			ply:Kill()
			return true
		else
			ply:SetHealth(math.min(ply:Health() + 40, ply:GetMaxHealth()))
			ply:ConCommand("pp_mat_overlay models/props_lab/Tank_Glass001")
			ply:ConCommand("pp_mat_overlay_refractamount 0.2")
			timer.Simple(60, function()
				if not IsValid(ply) then return end
				ply:ConCommand("pp_mat_overlay \"\"")
			end)
			local sayings = {
				"ma car is made from wood and bananas yo man",
				"stop looking at me yo bitch",
				"How Do You Use money i cant figer it out"
			}
			ply:ConCommand("say " .. sayings[math.random(1, #sayings)])
			return true
		end
	end
}

RegisterItem{
	id = "shroom",
	name = "Mushrooms",
	desc = "Fresh shrooms that you can eat directly.",
	func = "Use",
	model = "models/mushroom/mushroom.mdl",
	use = function(ply)
		if math.random(1, 10) == 1 then
			ply:Kill()
			return true
		else
			ply._PreShroomJumpPower = ply:GetJumpPower()
			ply:SetJumpPower(300)
			ply:SetHealth(math.min(ply:Health() + 20, ply:GetMaxHealth()))
			ply:ConCommand("pp_bloom 1")
			ply:ConCommand("pp_bloom_passes 10")
			ply:ConCommand("pp_bloom_darken 0.35")
			ply:ConCommand("pp_bloom_multiplayer 2")
			ply:ConCommand("pp_bloom_sizex 0")
			ply:ConCommand("pp_bloom_sizey 5")
			ply:ConCommand("pp_bloom_color 1")
			ply:SetDSP(6)
			timer.Simple(60, function()
				if not IsValid(ply) then return end
				ply:SetJumpPower(ply._PreShroomJumpPower)
				ply:ConCommand("pp_bloom 0")
				ply:SetDSP(1)
			end)
			local sayings = {
				"my pancakeyss are almost READYyy",
				"watermelons how to make ?!?",
				"How Do I Use legs???"
			}
			ply:ConCommand("say " .. sayings[math.random(1, #sayings)])
			return true
		end
	end
}

RegisterItem{
	id = "weed",
	name = "Cannabis",
	desc = "Weed will decrease your stress and gives you a relaxing feeling.",
	func = "Use",
	model = "models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl",
	use = function(ply)
		if math.random(1, 20) == 1 then
			ply:Kill()
			return true
		else
			for i = 1, 60 do
				timer.Simple(i, function()
					if not IsValid(ply) then return end
					ply:SetHealth(math.min(ply:Health() + 2, ply:GetMaxHealth()))
				end)
			end
			ply:ConCommand("pp_bloom 1")
			ply:ConCommand("pp_bloom_passes 10")
			ply:ConCommand("pp_bloom_darken 0.35")
			ply:ConCommand("pp_bloom_multiplayer 2")
			ply:ConCommand("pp_bloom_sizex 0")
			ply:ConCommand("pp_bloom_sizey 5")
			ply:ConCommand("pp_bloom_color 1")
			timer.Simple(60, function()
				if not IsValid(ply) then return end
				ply:ConCommand("pp_bloom 0")
			end)
			local sayings = {
				"hey gise. what if like the universe was just an videogame!!??!1 holy craaaap that would be awesomeeeeee",
				"does any1 hav goldfish!?1 i want goldfish plz thx",
				"hi how do i walk i cant figure it out"
			}
			ply:ConCommand("say " .. sayings[math.random(1, #sayings)])
			return true
		end
	end
}
