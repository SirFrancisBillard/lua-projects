AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_junk/rock001a.mdl")
	self:SetColor(Color(0,255,255,255))
	self:SetMaterial("models/debug/debugwhite")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetUseType(3)
end

function ENT:Think()

end

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 75)) do
			if v:GetClass() == "billard_drug_market" then
				caller:addMoney(v:GetMethPrice())
				caller:ChatPrint("You have sold meth for $"..v:GetMethPrice().."")
				DoGenericUseEffect(caller)
				self:Remove()
			end
		end
	end
end