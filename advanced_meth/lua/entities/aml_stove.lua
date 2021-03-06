AddCSLuaFile()
ENT.Base = AML_CLASS_BASE
ENT.PrintName = AML_NAME_STOVE
ENT.Category = AML_SPAWN_CATEGORY
ENT.Spawnable = AML_SPAWNABLE
ENT.AdminSpawnable = AML_SPAWNABLE_ADMIN
ENT.Model = AML_MODEL_STOVE
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
		phys:SetMass(200)
	end
end
function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "HasCanister")
	self:NetworkVar("Entity", 0, "Canister")
end
if SERVER then
	function ENT:StartTouch(ent)
		if IsValid(ent) and (ent:GetClass() == AML_CLASS_GAS) and (not self:GetHasCanister()) and (not ent:GetHasStove()) then
			if (not ent:IsReadyForStove()) then return end
			self:SetHasCanister(true)
			self:SetCanister(ent)
			ent:SetHasStove(true)
			ent:SetStove(self)
			local weld = constraint.Weld(self, ent, 0, 0, 0, true, false)
			self:EmitSound("physics/metal/metal_barrel_impact_soft"..math.random(1, 4)..".wav")
		end
	end
end