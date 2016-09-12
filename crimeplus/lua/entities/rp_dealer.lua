AddCSLuaFile()

ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Drug Addict"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/Humans/Group03/male_08.mdl"
ENT.AutomaticFrameAdvance = true

function ENT:Initialize()
	self:SetModel(self.Model)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetNPCState(NPC_STATE_SCRIPT)
		self:SetSolid(SOLID_BBOX)
		self:SetUseType(SIMPLE_USE)
		self:SetHullType(HULL_HUMAN)
		self:DropToFloor()
		self:CapabilitiesAdd(CAP_ANIMATEDFACE || CAP_TURN_HEAD)
		self:SetMaxYawSpeed(90)
	end
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end
end

if SERVER then
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			local randy = math.random(1, 5)
			if (randy == 1) then
				caller:ChatPrint("What the fuck do you want?")
			elseif (randy == 2) then
				caller:ChatPrint("Get lost, buddy.")
			elseif (randy == 3) then
				caller:ChatPrint("We don't appreciate your kind.")
			elseif (randy == 4) then
				caller:ChatPrint("What do you need?")
			elseif (randy == 5) then
				caller:ChatPrint("Make it quick, I got five warrants.")
			end
		end
	end
end

function ENT:Think()
	self:SetSequence("idle_all_02")
end
