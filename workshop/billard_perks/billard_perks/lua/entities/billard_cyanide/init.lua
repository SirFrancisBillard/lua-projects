AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Items/combine_rifle_ammo01.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetUseType(3)
end

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() then
		self:EmitSound("player/pl_drown"..math.random(1, 3))
		caller:Kill()
		self:Remove()
	end
end