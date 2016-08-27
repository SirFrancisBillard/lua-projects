AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/BriefCase001a.mdl")
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
		if caller:Health() >= caller:GetMaxHealth() then
			caller:ChatPrint("You already have "..caller:Health().." health!")
			return
		end
		caller:SetHealth(caller:GetMaxHealth())
		self:EmitSound("items/medshot4.wav")
		DoGenericUseEffect(caller)
		self:Remove()
	end
end