AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "Bandages"
ENT.Category = "Medical Supplies"

ENT.Spawnable = true
ENT.AdminOnly = false

ENT.Model = "models/props/cs_office/paper_towels.mdl"

game.AddAmmoType({name = "bandages"})

if CLIENT then
	language.Add("bandages_ammo", "Bandages")
end

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() then
		if caller:HasWeapon("weapon_bandages") then
			caller:GiveAmmo(1, "bandages")
		else
			caller:Give("weapon_bandages")
		end
		SafeRemoveEntity(self)
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
