AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Barrel"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/props_borealis/bluebarrel001.mdl"

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
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "MixingProgress")
	self:NetworkVar("Bool", 0, "IsMixing")
	self:NetworkVar("Bool", 1, "HasLeaves")
	self:NetworkVar("Bool", 2, "HasCaustic")
end
function ENT:CanMix()
	return (self:GetHasLeaves() and self:GetHasCaustic())
end
function ENT:DoneMixing()
	return (self:GetMixingProgress() >= 100)
end

if SERVER then
	function ENT:StartTouch(ent)
		if IsValid(ent) then
			if (ent:GetClass() == "rp_leaves") and (not self:GetHasLeaves()) then
				SafeRemoveEntity(ent)
				self:SetHasLeaves(true)
			end
			if (ent:GetClass() == "rp_caustic") and (not self:GetHasCaustic()) then
				SafeRemoveEntity(ent)
				self:SetHasCaustic(true)
			end
		end
	end
	function ENT:Think()
		if self:CanMix() and (not self:DoneMixing()) then
			self:SetMixingProgress(math.Clamp(self:GetMixingProgress() + 1, 0, 100))
		end
		self:NextThink(CurTime() + 1)
		return true
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if self:DoneMixing() then
				self:SetMixingProgress(0)
				self:SetHasLeaves(false)
				self:SetHasCaustic(false)
				local coke = ents.Create("rp_cocaine")
				coke:SetPos(self:GetPos() + Vector(0, 0, 30))
				coke:Spawn()
			end
		end
	end
end
