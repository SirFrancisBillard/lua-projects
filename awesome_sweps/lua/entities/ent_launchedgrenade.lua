AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Launched Grenade"

ENT.Spawnable = false
ENT.Model = "models/props_junk/watermelon01.mdl"

local DamageDirect = 80
local DamageRoller = 40
local SplodeRadius = 100
local SplodeTime = 3

local color_white = color_white or Color(255, 255, 255)
local color_red = Color(255, 0, O)

if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInitSphere(6, "metal")
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:PhysWake()

		util.SpriteTrail(self, 0, color_white, false, 4, 1, 0.5, 0.1, "trails/smoke.vmt")

		self.Roller = false
		self.ExplodeTime = false
	end

	function ENT:Detonate()
		local boom = EffectData()
		boom:SetOrigin(self:GetPos())
		util.Effect("Explosion", boom)

		util.BlastDamage(self, self.Owner, self:GetPos(), SplodeRadius, self.Roller and DamageRoller or DamageDirect)

		self:Remove()
	end

	function ENT:PhysicsCollide(data, phys)
		if data.HitEntity:IsWorld() and not self.Roller then
			self.Roller = true
			self.ExplodeTime = CurTime() + 3
		end

		if data.Speed > 50 then
			self:EmitSound(Sound("HEGrenade.Bounce"))
		end
	end

	function ENT:Think()
		if self.ExplodeTime and self.ExplodeTime < CurTime() then
			self:Detonate()
		end
	end

	function ENT:StartTouch(ent)
		if IsValid(ent) and (ent:IsPlayer() or ent:IsNPC()) then
			self:Detonate()
		end
	end
else -- CLIENT
	function ENT:Draw()
		render.SetMaterial("sprite idk")
		render.DrawSprite(self:GetPos(), 18, 18, self:GetOwner() == LocalPlayer() and color_white or color_red)
		self:DrawModel()
	end
end
