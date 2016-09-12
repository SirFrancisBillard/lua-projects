AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Drug Addict"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/Humans/Group01/male_08.mdl"

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
			local randy = math.random(1, 5)
			if (randy == 1) then
				caller:ChatPrint("HELP GET THESE BEES OUT OF MY TEETH!")
			elseif (randy == 2) then
				caller:ChatPrint("I AM IN THE WRONG LINE AT K-MART")
			elseif (randy == 3) then
				caller:ChatPrint("WHAT ARE YOU DOING WITH THAT RHINOCEROUS")
			elseif (randy == 4) then
				caller:ChatPrint("NOT THE PURPLE")
			elseif (randy == 5) then
				caller:ChatPrint("WHY DO BANANAS HAVE TENTACLES")
			else
			self:EmitSound("vo/npc/male01/help01.wav")
		end
	end
end
