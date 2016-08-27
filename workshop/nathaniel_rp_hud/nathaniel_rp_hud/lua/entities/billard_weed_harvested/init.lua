AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props/cs_office/trash_can_p5.mdl") //Once again, custom models are overrated
	self:SetColor(Color(0, 255, 0, 255))
	self:SetMaterial("models/props_c17/furniturefabric_002a")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetUserHealth(0)
	self:SetIsUsed(false)
end

function ENT:Think()
	if self:GetIsUsed() then
		while self:GetUserPerson():Health() > self:GetUserHealth() do
			self:GetUserPerson():SetHealth(self:GetUserPerson():Health() - 20)
			self:NextThink(CurTime() + 1)
		end
	end
end

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() then
		caller:ChatPrint("I'm so high right now, nothing could hurt me!")
		self:SetUserHealth(caller:Health())
		self:SetUserPerson(caller)
		caller:SetHealth(caller:Health() * 8)
		self:SetIsUsed(true)
		DoGenericUseEffect(caller)
		self:Remove()
	end
end