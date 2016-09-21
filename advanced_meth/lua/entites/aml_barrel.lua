AddCSLuaFile()
AML_CLASS_POT = AML_CLASS_POT or self.ClassName
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Barrel"
ENT.Category = "Meth Cooking"
ENT.Spawnable = true
ENT.Model = "models/props_c17/metalPot001a.mdl"
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
	self:SetMixingProgress(0)
	self:SetPE(0)
	self:SetChloroform(0)
end
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "MixingProgress")
	self:NetworkVar("Int", 1, "PE")
	self:NetworkVar("Int", 2, "Chloroform")
end
function ENT:IsOnStove()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 12)) do
		if (v:GetClass() == AML_CLASS_STOVE) and v:GetHasCanister() and (v:GetCanister():GetFuel() > 0) then
			self:SetStove(v)
			return IsValid(self)
		end
	end
end
function ENT:ProcessIngredient(ent)
	local class = ent:GetClass()
	if (class == AML_CLASS_PURE_EPHEDRINE) then
		self:SetPureEph(self:GetPureEph() + 1)
		return true
	elseif (class == AML_CLASS_RED_PHOSPHORUS) then
		self:SetRedPhos(self:GetRedPhos() + 1)
		return true
	elseif (class == AML_CLASS_HYDROGEN_IODIDE) then
		self:SetHydroIodide(self:GetHydroIodide() + 1)
		return true
	elseif (class == AML_CLASS_LYE_SOLUTION) then
		self:SetLye(self:GetLye() + 1)
		return true
	elseif (class == AML_CLASS_WATER) then
		self:SetWater(self:GetWater() + 1)
		return true
	elseif (class == AML_CLASS_FLOUR) then
		self:SetFlour(self:GetFlour() + 1)
		return true
	end
	return false
end
function ENT:IngredientEffect(ent)
	SafeRemoveEntity(ent)
	self:EmitSound(Sound("ambient/levels/canals/toxic_slime_sizzle"..math.random(2, 4)..".wav"))
	self:VisualEffect()
end
if SERVER then

	function ENT:StartTouch(ent)
		if IsValid(ent) then
			if (ent:GetClass() == AML_CLASS_CHLOROFORM) then
				self:IngredientEffect(ent)
		end
	end
	function ENT:Think()
		if (self:GetMixingProgress() == AML_CONFIG_TIME_BARREL) then
			self:SetMixingProgress(0)
			self:SetPE(math.Clamp(self:GetPE() - 1, 0, self:GetPE()))
			self:SetChloroform(math.Clamp(self:GetChloroform() - 1, 0, self:GetChloroform()))
			local ephe = ents.Create(AML_CLASS_PURE_EPHEDRINE)
			ephe:SetPos(self:GetPos() + Vector(0, 0, 56))
			ephe:Spawn()
		elseif (self:GetPE() > 0) and (self:GetChloroform() > 0) then
			self:SetMixingProgress(math.Clamp(self:GetMixingProgress() + 1, 0, AML_CONFIG_TIME_BARREL))
		end
		self:NextThink(CurTime() + 1)
		return true
	end
	function ENT:VisualEffect()
		local smoke = EffectData()
		smoke:SetStart(self:GetPos())
		smoke:SetOrigin(self:GetPos() + Vector(0, 0, 40))
		smoke:SetScale(8)
		util.Effect("GlassImpact", smoke, true, true)
	end
end
if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		--[[
		local Pos = self:GetPos()
		local Ang = self:GetAngles()
		surface.SetFont("Trebuchet24")
		Ang:RotateAroundAxis(Ang:Forward(), 90)
		cam.Start3D2D(Pos + (Ang:Up() * 8) + (Ang:Right() * -2), Ang, 0.12)
			draw.RoundedBox(2, -50, -65, 100, 30, Color(140, 0, 0, 100))
			if (self:GetCookingProgress() > 0) then
				draw.RoundedBox(2, -50, -65, (100 / AML_CONFIG_COOKING_TIME) * self:GetCookingProgress(), 30, Color(0, 225, 0, 100))
			end
			draw.SimpleText("Progress", "Trebuchet24", -40, -63, Color(255, 255, 255, 255))
			draw.WordBox(2, -55, -30, "Ingredients:", "Trebuchet24", Color(0, 225, 0, 100), Color(255, 255, 255, 255))
			draw.WordBox(2, -35, 5, "Sodium", "Trebuchet24", self:GetHasSodium() and Color(0, 225, 0, 100) or Color(140, 0, 0, 100), Color(255, 255, 255, 255))
			draw.WordBox(2, -40, 40, "Chloride", "Trebuchet24", self:GetHasChloride() and Color(0, 225, 0, 100) or Color(140, 0, 0, 100), Color(255, 255, 255, 255))
		cam.End3D2D()
		]]
	end
end
