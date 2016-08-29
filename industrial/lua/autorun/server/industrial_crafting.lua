local plyMeta = FindMetaTable("Player")
local entMeta = FindMetaTable("Entity")

local recipes = {
	["jetpack"] = {result = "industrial_jetpack", recipe = {"industrial_metal", "industrial_metal", "industrial_fuel"}, power = 6000, func = function(ent) end},
	["laser"] = {result = "industrial_laser", recipe = {"industrial_gold", "industrial_fuel"}, power = 6000, func = function(ent) end},
	["medicine"] = {result = "industrial_medicide", recipe = {"industrial_zinc", "industrial_zinc"}, power = 400, func = function(ent) end},
	["advanced alloy"] = {result = "industrial_adv_alloy", recipe = {"industrial_metal", "industrial_metal", "industrial_metal", "industrial_gold"}, power = 800, func = function(ent) end},
	["brass"] = {result = "industrial_brass", recipe = {"industrial_metal", "industrial_zinc"}, power = 400, func = function(ent) end}

}

function plyMeta:NearestItem(item)
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 100)) do
		if (item == v:GetClass()) then
			return v
		end
	end
	return false
end

hook.Add("PlayerSay", "IndustrialMod_Crafting", function(ply, txt, isTeam)
	if (string.sub(string.lower(txt), 1, 10) == "/craftitem") then
		local item = string.sub(txt, 12)
		for k, v in pairs(recipes) do
			if (string.find(item, tostring(k))) then
				local ctable = ply:NearestItem("industrial_crafting_table")
				if ctable then
					if (ctable:GetStoredPower() >= v.power) then
						local ingredients = {}
						for _, ing in pairs(v.recipe) do
							local itm = ply:NearestItem(ing:GetClass())
							if itm then
								table.insert(ingredients, itm)
							end
						end
						if (#ingredients == #v.recipe) then
							for __, del in pairs(ingredients) do
								SafeRemoveEntity(del)
							end
							ctable:SetStoredPower(math.Clamp(ctable:GetStoredPower() - v.power, 0, ctable:GetStoredPower()))
							local ent = ents.Create(v.result)
							ent:SetPos(ctable:GetPos() + Vector(0, 0, 60))
							ent:Spawn()
							v.func(ent)
						else
							ply:ChatPrint("Not enough ingredients nearby!")
						end
					else
						ply:ChatPrint("Crafting table doesn't have enough power!")
					end
				else
					ply:ChatPrint("No crafting table nearby!")
				end
			end
		end
	end
end)
