AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Oil Refinery"
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
	return "Refining oil turns it into fuel, a much more useful and efficient material."
end
function ENT:ExtraNetworkedVars()
	self:NetworkVar("Int", 1, "StoredOil")
	self:NetworkVar("Int", 2, "StoredFuel")
	self:NetworkVar("Int", 3, "ConvertCooldown")
end
if SERVER then
	function ENT:ExtraInit()
		self:SetStoredOil(0)
		self:SetStoredFuel(0)
		self:SetConvertCooldown(10)
	end
	function ENT:Touch(toucher)
		if (toucher:GetClass() == "industrial_oil") then
			SafeRemoveEntity(toucher)
			self:SetStoredOil(self:GetStoredOil() + 1)
		end
	end
	function ENT:ExtraThink()
		self:SetConvertCooldown(self:GetConvertCooldown() - 1)
		if (self:GetConvertCooldown() < 1) and (self:GetStoredOil() > 0) then
			self:SetStoredOil(self:GetStoredOil() - 1)
			self:SetStoredFuel(self:GetStoredFuel() + 1)
		end
	end
	function ENT:OnEntityUsed(ply)
		if (self:GetStoredFuel() > 0) then
			self:SetStoredFuel(self:GetStoredFuel() - 1)
			local ent = ents.Create("industrial_fuel")
			ent:SetPos(self:GetPos() + Vector(0, 0, 60))
			ent:Spawn()
		end
	end
end
