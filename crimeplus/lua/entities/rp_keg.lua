AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Keg"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/props_c17/woodbarrel001.mdl"

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
	self:NetworkVar("Int", 0, "FermentingProgress")
	self:NetworkVar("String", 0, "Alcohol")
	self:NetworkVar("Bool", 0, "IsFermenting")
end
function ENT:CanFerment()
	return (self:GetAlcohol() != "None")
end
function ENT:DoneFermenting()
	return (self:GetFermentingProgress() >= 100)
end

if SERVER then
	function ENT:StartTouch(ent)
		if IsValid(ent) then
			if (ent:GetClass() == "rp_orange") and (not self:GetIsFermenting()) then
				SafeRemoveEntity(ent)
				self:SetIsFermenting(true)
				self:SetAlcohol("Pruno")
			end
			if (ent:GetClass() == "rp_banana") and (not self:GetIsFermenting()) then
				SafeRemoveEntity(ent)
				self:SetIsFermenting(true)
				self:SetAlcohol("Rum")
			end
			if (ent:GetClass() == "rp_potato") and (not self:GetIsFermenting()) then
				SafeRemoveEntity(ent)
				self:SetIsFermenting(true)
				self:SetAlcohol("Vodka")
			end
			if (ent:GetClass() == "rp_melon") and (not self:GetIsFermenting()) then
				SafeRemoveEntity(ent)
				self:SetIsFermenting(true)
				self:SetAlcohol("Moonshine")
			end
		end
	end
	function ENT:Think()
		if self:CanFerment() and (not self:DoneFermenting()) then
			self:SetFermentingProgress(math.Clamp(self:GetFermentingProgress() + 1, 0, 100))
		end
		self:NextThink(CurTime() + 1)
		return true
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if self:DoneFermenting() then
				self:SetIsFermenting(false)
				self:SetFermentingProgress(0)
				local logic = ents.Create("rp_sixpack")
				logic:SetPos(self:GetPos() + Vector(0, 0, 30))
				logic:Spawn()
				logic:SetAlcohol(self:GetAlcohol())
				self:SetAlcohol("None")
			end
		end
	end
end