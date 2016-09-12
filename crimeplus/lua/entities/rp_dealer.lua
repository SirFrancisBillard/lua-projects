AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Drug Addict"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/player/group03/male_08.mdl"

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
	end
end

if SERVER then
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			local randy = math.random(1, 2)
			if (randy == 1) then
				caller:ChatPrint("What the fuck do you want?")
			elseif (randy == 2) then
				caller:ChatPrint("Get lost, buddy.")
			end
		end
	end
end

function ENT:Think()
	self:SetSequence("idle_all_02")
end
