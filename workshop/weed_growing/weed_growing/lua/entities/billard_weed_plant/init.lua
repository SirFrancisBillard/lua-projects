AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_lab/cactus.mdl") //Because who needs custom models, amirite?
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetUseType(3)
	self:SetGrowth(0)
	self:SetIsFinishedGrowing(false)
end

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() then
		if !self:GetOwner() then
			caller:ChatPrint("You have claimed this weed pot")
			self:SetOwner(caller)
		end
		if self:GetIsFinishedGrowing() then
			local baggie = ents.Create("billard_weed_harvested")
			baggie:SetPos(self:GetPos() + Vector(0, 0, 20))
			baggie:Spawn()
			local clone = ents.Create("billard_weed_plant") --We have to dupe ourselves due to a stupid glitch
			clone:SetPos(self:GetPos())
			clone:Spawn()
			clone:SetAngles(self:GetAngles())
			self:Remove()
		else
			caller:ChatPrint("Weed is "..self:GetGrowth().." percent grown")
		end
		DoGenericUseEffect(caller)
	end
end