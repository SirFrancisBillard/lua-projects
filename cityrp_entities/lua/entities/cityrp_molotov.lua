AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "cityrp_base"
ENT.PrintName = "Molotov Cocktail"
ENT.Category = "CityRP"
ENT.Spawnable = true
ENT.Model = "models/props_junk/garbage_glassbottle003a.mdl"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "CanBlow")
end

if SERVER then
	function ENT:Initialize()
		self.BaseClass.Initialize(self)
		self:SetCanBlow(false)
		timer.Simple(CityRP.Config.Molotov.Values.Timer, function()
			if not IsValid(self) then return end
			self:SetCanBlow(true)
		end)
	end
	function ENT:PhysicsCollide(data, phys)
		if data.Speed > CityRP.Config.Molotov.Values.RequiredSpeed and self:GetCanBlow() then
			local boom = EffectData()
			boom:SetOrigin(self:GetPos())
			util.Effect("HelicopterMegaBomb", boom)
			self:EmitSound(CityRP.Config.Molotov.Sounds.Break)
			for k, v in pairs(ents.FindInSphere(self:GetPos(), CityRP.Config.Molotov.Values.Radius)) do
				if IsValid(v) then
					v:Ignite(CityRP.Config.Molotov.Values.IgniteTime)
				end
			end
			SafeRemoveEntity(self)
		end
	end
end
