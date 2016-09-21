AddCSLuaFile()
ENT.Base = "base_gmodentity"
ENT.PrintName = "Meth Cooking Base Entity"
ENT.Category = "Meth Cooking"
ENT.Spawnable = false
ENT.Model = "models/Items/combine_rifle_ammo01.mdl"
function ENT:PermaColor()
	return false
end
function ENT:PermaMaterial()
	return false
end
function ENT:PermaScale()
	return false
end
if SERVER then
	function ENT:ExtraInit() end
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			phys:SetMass(60)
		end
		self:SetUseType(SIMPLE_USE or 3)
		if self:PermaMaterial() then
			self:SetMaterial(self:PermaMaterial())
		end
		if self:PermaColor() then
			self:PermaColor()
		end
		if (self:PermaScale() != 1.0) then
			self:SetModelScale(self:PermaScale())
		end
		self:ExtraInit()
	end
end
