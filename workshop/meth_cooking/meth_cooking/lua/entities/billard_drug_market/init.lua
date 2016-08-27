AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_interiors/VendingMachineSoda01a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetUseType(3)
	self:SetMethPrice(400000)
	self:SetCokePrice(200000)
	self:SetWeedPrice(60000)
	self:SetHeroinPrice(100000)
end

function ENT:Think()

end

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() then
		caller:ChatPrint("Bring me drugs and I will pay cash!")
		DoGenericUseEffect(caller)
	end
end