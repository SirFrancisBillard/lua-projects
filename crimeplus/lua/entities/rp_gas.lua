AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Gas"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/props_junk/propane_tank001a.mdl"

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
		phys:SetMass(40)
	end
	self:SetFuel(200)
end
function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "HasStove")
	self:NetworkVar("Entity", 0, "Stove")
	self:NetworkVar("Int", 0, "Fuel")
end

if SERVER then
	function ENT:Think()
		local phys = self:GetPhysicsObject()
		if self:GetHasStove() and IsValid(phys) then
			phys:SetMass(1)
		elseif IsValid(phys) then
			phys:SetMass(40)
		end
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() and self:GetHasStove() then
			self:SetHasStove(false)
			self:GetStove():SetHasCanister(false)
			constraint.RemoveAll(self)
			self:EmitSound("physics/metal/metal_barrel_impact_soft"..math.random(1, 4)..".wav")
		end
		if IsValid(caller) and caller:IsPlayer() and (self:GetFuel() <= 0) and (not self:GetHasStove()) then
			SafeRemoveEntity(self)
		end
	end
end
