local plyMeta = FindMetaTable("Player")
local entMeta = FindMetaTable("Entity")

local recipes = {
	["jetpack"] = {result = "industrial_jetpack", recipe = {"industrial_adv_alloy", "industrial_adv_alloy", "industrial_fuel"}, power = 6000, ctable = "industrial_crafting_table", func = function(ent) end},
	["laser"] = {result = "industrial_laser", recipe = {"industrial_gold", "industrial_glass", "industrial_adv_alloy"}, power = 600, ctable = "industrial_crafting_table", func = function(ent) end},
	["medicine"] = {result = "industrial_medicide", recipe = {"industrial_zinc", "industrial_honey"}, power = 400, ctable = "industrial_crafting_table", func = function(ent) end},
	["oil well"] = {result = "industrial_oil_miner", recipe = {"industrial_metal", "industrial_metal", "industrial_metal"}, power = 400, ctable = "industrial_crafting_table", func = function(ent) end},
	["oil refinery"] = {result = "industrial_oil_refinery", recipe = {"industrial_metal", "industrial_metal", "industrial_oil"}, power = 600, ctable = "industrial_crafting_table", func = function(ent) end},
	["battery"] = {result = "industrial_battery", recipe = {"industrial_metal", "industrial_metal"}, power = 600, ctable = "industrial_crafting_table", func = function(ent) end},
	["gunpowder"] = {result = "industrial_gunpowder", recipe = {"industrial_coal_dust", "industrial_sand"}, power = 200, ctable = "industrial_crafting_table", func = function(ent) end},
	["carbon mesh"] = {result = "industrial_carbon_mesh", recipe = {"industrial_coal_dust", "industrial_coal_dust"}, power = 60, ctable = "industrial_crafting_table", func = function(ent) end},
	["nano suit"] = {result = "industrial_nano_suit", recipe = {"industrial_carbon_plate", "industrial_carbon_plate", "industrial_carbon_plate", "industrial_carbon_plate", "industrial_battery"}, power = 10000, ctable = "industrial_crafting_table", func = function(ent) end},
	["quantum suit"] = {result = "industrial_quantum_suit", recipe = {"industrial_nano_suit", "industrial_quantum_plate", "industrial_quantum_plate", "industrial_quantum_plate", "industrial_quantum_plate", "industrial_battery_gold"}, power = 20000, ctable = "industrial_crafting_table", func = function(ent) end},
	["golden battery"] = {result = "industrial_battery_gold", recipe = {"industrial_battery", "industrial_gold", "industrial_gold"}, power = 920, ctable = "industrial_crafting_table", func = function(ent) end},
	["coal engine"] = {result = "industrial_engine_coal", recipe = {"industrial_metal", "industrial_metal", "industrial_metal", "industrial_coal"}, power = 480, ctable = "industrial_crafting_table", func = function(ent) end},
	["combustion engine"] = {result = "industrial_engine_combustion", recipe = {"industrial_engine_coal", "industrial_oil", "industrial_fuel"}, power = 640, ctable = "industrial_crafting_table", func = function(ent) end},
	["biofuel engine"] = {result = "industrial_engine_biofuel", recipe = {"industrial_engine_coal", "industrial_biofuel", "industrial_foliage"}, power = 640, ctable = "industrial_crafting_table", func = function(ent) end},
	["royal crucible engine"] = {result = "industrial_engine_crucible", recipe = {"industrial_engine_combustion", "industrial_gold", "industrial_gold"}, power = 640, ctable = "industrial_crafting_table", func = function(ent) end},
	["machine block"] = {result = "industrial_machine_block", recipe = {"industrial_metal", "industrial_metal", "industrial_metal", "industrial_metal"}, power = 640, ctable = "industrial_crafting_table", func = function(ent) end},
	["electric furnace"] = {result = "industrial_electric_furnace", recipe = {"industrial_machine_block", "industrial_coal"}, power = 640, ctable = "industrial_crafting_table", func = function(ent) end},
	["macerator"] = {result = "industrial_macerator", recipe = {"industrial_machine_block", "industrial_metal"}, power = 640, ctable = "industrial_crafting_table", func = function(ent) end},
	["compressor"] = {result = "industrial_compressor", recipe = {"industrial_machine_block", "industrial_metal"}, power = 640, ctable = "industrial_crafting_table", func = function(ent) end},
	["cured plate"] = {result = "industrial_cured_plate", recipe = {"industrial_carbon_plate", "industrial_zinc"}, power = 1800, ctable = "industrial_crafting_table", func = function(ent) end},
	["brass"] = {result = "industrial_brass", recipe = {"industrial_metal", "industrial_zinc"}, power = 400, ctable = "industrial_crafting_table", func = function(ent) end},
	["munition table"] = {result = "industrial_munition_table", recipe = {"industrial_adv_alloy", "industrial_adv_alloy"}, power = 1200, ctable = "industrial_crafting_table", func = function(ent) end},
	["forestry table"] = {result = "industrial_forestry_table", recipe = {"industrial_metal", "industrial_metal"}, power = 800, ctable = "industrial_crafting_table", func = function(ent) end},
	
	["empty missile casing"] = {result = "industrial_missile_empty", recipe = {"industrial_adv_alloy", "industrial_adv_alloy"}, power = 4000, ctable = "industrial_munition_table", func = function(ent) end},
	["napalm missile"] = {result = "industrial_missile_napalm", recipe = {"industrial_missile_empty", "industrial_fuel", "industrial_fuel"}, power = 10000, ctable = "industrial_munition_table", func = function(ent) end},
	["nuclear missile"] = {result = "industrial_missile_nuke", recipe = {"industrial_missile_empty", "industrial_uranium", "industrial_uranium"}, power = 20000, ctable = "industrial_munition_table", func = function(ent) end},
	
	["artificial garden"] = {result = "industrial_garden", recipe = {"industrial_metal", "industrial_metal", "industrial_glass"}, power = 120, ctable = "industrial_forestry_table", func = function(ent) end},
	["bee trap"] = {result = "industrial_bee_trap", recipe = {"industrial_wood", "industrial_wood", "industrial_flower", "industrial_flower"}, power = 120, ctable = "industrial_forestry_table", func = function(ent) end},
	["apiary"] = {result = "industrial_apiary", recipe = {"industrial_wood", "industrial_wood", "industrial_wood", "industrial_wood"}, power = 120, ctable = "industrial_forestry_table", func = function(ent) end},
}

function IndustrialMod_CreateRecipe(name, tab)
	if (recipes[name] != nil) then
		recipes[name] = tab
		return true
	else
		return false
	end
end

function plyMeta:NearestItem(item)
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 100)) do
		if (item == v:GetClass()) then
			return v
		end
	end
	return false
end

hook.Add("PlayerSay", "IndustrialMod_Crafting", function(ply, txt, isTeam)
	if (string.sub(string.lower(txt), 1, 6) == "/craft") then
		local item = string.sub(txt, 8)
		for k, v in pairs(recipes) do
			if (string.find(tostring(k), item, 1, true)) then
				local ctable = ply:NearestItem(v.ctable)
				if ctable then
					if (ctable:GetStoredPower() >= v.power) then
						local ingredients = {}
						for _, ing in pairs(v.recipe) do
							for _k, _v in pairs(ents.FindInSphere(ply:GetPos(), 100)) do
								if ((ing == _v:GetClass()) and (not table.HasValue(ingredients, _v:EntIndex()))) then
									PrintTable(ingredients, 2)
									table.insert(ingredients, _v:EntIndex())
								end
							end
						end
						if (#ingredients == #v.recipe) then
							PrintTable(ingredients, 2)
							for __, del in pairs(ingredients) do
								SafeRemoveEntity(Entity(del))
							end
							ctable:SetStoredPower(math.Clamp(ctable:GetStoredPower() - v.power, 0, ctable:GetStoredPower()))
							local ent = ents.Create(v.result)
							ent:SetPos(ctable:GetPos() + Vector(0, 0, 60))
							ent:Spawn()
							v.func(ent)
						else
							ply:ChatPrint("Not enough ingredients nearby!")
							ply:ChatPrint("Required ingredients:")
							for ___, ent in pairs(v.recipe) do
								ply:ChatPrint(scripted_ents.Get(ent).PrintName)
							end
							return
						end
					else
						ply:ChatPrint("Crafting table doesn't have enough power!")
						ply:ChatPrint("Required power: "..v.power)
						return
					end
				else
					ply:ChatPrint("No table nearby!")
					ply:ChatPrint("Required table: "..scripted_ents.Get(v.ctable).PrintName)
					return
				end
			end
		end
	end
	if (string.sub(string.lower(txt), 1, 11) == "/howtocraft") then
		local item = string.sub(txt, 13)
		for k, v in pairs(recipes) do
			if (string.find(tostring(k), item, 1, true)) then
				ply:ChatPrint("=========================")
				ply:ChatPrint("Recipe for "..tostring(k))
				ply:ChatPrint("Power needed: "..tostring(v.power))
				ply:ChatPrint("Table needed: "..scripted_ents.Get(v.ctable).PrintName)
				for __, ent in pairs(v.recipe) do
					ply:ChatPrint(scripted_ents.Get(ent).PrintName)
				end
				ply:ChatPrint("=========================")
			end
		end
	elseif (string.sub(string.lower(txt), 1, 13) == "/craftinglist") then
		for k, v in pairs(recipes) do
			ply:ChatPrint("=========================")
			ply:ChatPrint("Recipe for "..tostring(k))
			ply:ChatPrint("Power needed: "..tostring(v.power))
			ply:ChatPrint("Table needed: "..scripted_ents.Get(v.ctable).PrintName)
			for __, ent in pairs(v.recipe) do
				ply:ChatPrint(scripted_ents.Get(ent).PrintName)
			end
		end
		ply:ChatPrint("=========================")
	end
end)
