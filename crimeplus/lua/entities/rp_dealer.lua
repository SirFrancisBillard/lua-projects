AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Drug Dealer"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/props_borealis/bluebarrel001.mdl"
ENT.DrugDealer = false

function ENT:Initialize()
	self:SetModel(self.Model)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self.DrugDealer = ents.Create("prop_ragdoll")
		self.DrugDealer:SetModel("models/player/group03/male_08.mdl")
		self.DrugDealer:SetSequence("idle_all_01")
		self.DrugDealer:SetPos(self:GetPos() - Vector(0, 0, 16))
		self.DrugDealer:Spawn()
		self:DeleteOnRemove(self.DrugDealer)
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
				caller:ChatPrint("What do you need?.")
			elseif (randy == 5) then
				caller:ChatPrint("Make it quick, I got five warrants.")
			end
		end
	end
	function ENT:Think()
		self.DrugDealer:SetSequence("idle_all_01")
		self.DrugDealer:SetModel("models/player/group03/male_08.mdl")
		self.DrugDealer:SetPos(self:GetPos() - Vector(0, 0, 16))
		self:SetColor(Color(0, 0, 0, 0))
	end
end


