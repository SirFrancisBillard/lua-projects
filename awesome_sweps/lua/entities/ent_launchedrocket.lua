AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Launched Rocket"

ENT.Spawnable = false
ENT.Model = "models/weapons/w_missile_closed.mdl"

local SplashDamage = 20
local DirectDamage = 40
local SplodeRadius = 250

local color_white = color_white or Color(255, 255, 255)
local color_red = Color(255, 0, 0)

local SpriteMat = Material("sprites/light_glow02_add")

if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysWake()

		util.SpriteTrail(self, 0, color_white, false, 12, 1, 0.8, 0.1, "trails/smoke.vmt")

		self.DirectHit = false
		self.Noise = CreateSound(self, "weapons/rpg/rocket1.wav")

		self:SetGravity(0)
	end

	function ENT:Detonate()
		local boom = EffectData()
		boom:SetOrigin(self:GetPos())
		util.Effect("Explosion", boom)

		util.BlastDamage(self, self.Owner, self:GetPos(), SplodeRadius, self.DirectHit and DirectDamage or SplashDamage)

		self:Remove()
	end

	function ENT:PhysicsCollide(data, phys)
		self:Detonate()
	end

	function ENT:Touch(ent)
		if IsValid(ent) and (ent:IsPlayer() or ent:IsNPC()) then
			self.DirectHit = true
			self:Detonate()
		end
	end
else -- CLIENT
	function ENT:Draw()
		render.SetMaterial(SpriteMat)
		render.DrawSprite(self:GetPos(), 24, 24, self:GetOwner() == LocalPlayer() and color_white or color_red)

		self:DrawModel()
	end
end
