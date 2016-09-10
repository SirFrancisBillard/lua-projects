AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Crime Base"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/hunter/plates/plate.mdl"

function ENT:HelpText()
	return "No help text found!"
end
function ENT:Initialize()
	self:SetModel(self.Model)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
	end
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end
end