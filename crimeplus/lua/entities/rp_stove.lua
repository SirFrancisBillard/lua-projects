AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Stove"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/props_c17/furnitureStove001a.mdl"

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
		phys:SetMass(80)
	end
end
function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "HasCanister")
	self:NetworkVar("Entity", 0, "Canister")
end

if SERVER then
	function ENT:StartTouch(ent)
		if IsValid(ent) and (ent:GetClass() == "rp_gas") and (not self:GetHasCanister()) and (not ent:GetHasStove()) then
			self:SetHasCanister(true)
			self:SetCanister(ent)
			ent:SetHasStove(true)
			ent:SetStove(self)
			ent:SetPos(self:GetPos() + Vector(30, 12, 0))
			local weld = constraint.Weld(self, ent, 0, 0, 0, true, false)
		end
	end
end
