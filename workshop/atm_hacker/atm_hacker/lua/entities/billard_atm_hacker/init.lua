AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_lab/reciever01d.mdl")
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
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 75)) do
			if v:GetClass() == "billard_atm" then
				local randy = math.random(1, 1000000)
				caller:addMoney(randy)
				caller:ChatPrint("You have earned $"..randy.." from hacking this ATM")
				self:Remove()
			end
		end
		DoGenericUseEffect(caller)
	end
end
