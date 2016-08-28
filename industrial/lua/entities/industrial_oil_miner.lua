AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Oil Well"
ENT.Spawnable = true
ENT.Model = "models/props_interiors/Radiator01a.mdl"
function ENT:IndustrialType()
	return "mach"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Oil wells will generate oil when given enough power. Harvested oil can be extracted from the well with the use key."
end
function ENT:GetMaxStoredPower()
	return 800
end
if SERVER then
	function ENT:OnEntityUsed()
		if (self:GetStoredPower() >= 100) then
			self:SetStoredPower(math.Clamp(self:GetStoredPower() - 100, 0, self:GetMaxStoredPower()))
			local ent = ents.Create("industrial_oil")
			ent:SetPos(self:GetPos() + Vector(0, 0, 60))
			ent:Spawn()
		end
	end
end
