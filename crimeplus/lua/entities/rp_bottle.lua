AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Bottle"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/props_junk/garbage_glassbottle003a.mdl"

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
	self:SetSwigs(6)
end
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Swigs")
	self:NetworkVar("String", 0, "Alcohol")
end

if SERVER then
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if (self:GetSwigs() > 0) then
				self:SetSwigs(math.Clamp(self:GetSwigs() - 1, 0, 6))
				if (self:GetAlcohol() == "Pruno") then
					caller:SetHealth(math.Clamp(caller:Health() + 2, 0, caller:GetMaxHealth()))
				end
				if (self:GetAlcohol() == "Moonshine") then
					caller:SetHealth(math.Clamp(caller:Health() + 4, 0, caller:GetMaxHealth()))
				end
				if (self:GetAlcohol() == "Rum") then
					caller:SetHealth(math.Clamp(caller:Health() + 6, 0, caller:GetMaxHealth()))
				end
				if (self:GetAlcohol() == "Vodka") then
					caller:SetHealth(math.Clamp(caller:Health() + 8, 0, caller:GetMaxHealth()))
				end
				caller:EmitSound(Sound("npc/barnacle/barnacle_gulp"..math.random(1, 2)..".wav"))
			else
				SafeRemoveEntity(self)
			end
		end
	end
end
