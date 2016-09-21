AddCSLuaFile()
AML_CLASS_METH = self.ClassName
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Pot"
ENT.Category = "Meth Cooking"
ENT.Spawnable = true
ENT.Model = "models/props_c17/metalPot001a.mdl"
local StageForChem = {
	[AML_CLASS_PURE_EPHEDRINE] = AML_STAGE_RED_ACID,
	[AML_CLASS_RED_PHOSPHORUS] = AML_STAGE_RED_ACID,
	[AML_CLASS_HYDROGEN_IODIDE] = AML_STAGE_RED_ACID,
	[AML_FLUID_RED_ACID] = AML_STAGE_LIQUID_METH,
	[AML_CLASS_LYE_SOLUTION] = AML_STAGE_LIQUID_METH,
	[AML_FLUID_LIQUID_METH] = AML_STAGE_CRYSTAL_METH,
	[AML_CLASS_WATER] = AML_STAGE_CRYSTAL_METH,
	[AML_CLASS_FLOUR] = AML_STAGE_CRYSTAL_METH,
}
local ChemFunc = {
	[AML_CLASS_PURE_EPHEDRINE] = self:SetPureEph,
	[AML_CLASS_RED_PHOSPHORUS] = AML_STAGE_RED_ACID,
	[AML_CLASS_HYDROGEN_IODIDE] = AML_STAGE_RED_ACID,
	[AML_FLUID_RED_ACID] = AML_STAGE_LIQUID_METH,
	[AML_CLASS_LYE_SOLUTION] = AML_STAGE_LIQUID_METH,
	[AML_FLUID_LIQUID_METH] = AML_STAGE_CRYSTAL_METH,
	[AML_CLASS_WATER] = AML_STAGE_CRYSTAL_METH,
	[AML_CLASS_FLOUR] = AML_STAGE_CRYSTAL_METH,
}
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
	self:SetCookingProgress(0)
	self:SetStage(AML_STAGE_NONE)
	self:SetChemicalMismatch(false)
	self:SetMethPurity(0)
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Up(), 90)
	self:SetAngles(Ang)
	if CLIENT then
		self.EmitTime = CurTime()
		self.FirePlace = ParticleEmitter(self:GetPos())
	end
end
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "CookingProgress")
	self:NetworkVar("Int", 1, "Stage")
	self:NetworkVar("Int", 2, "RedPhos")
	self:NetworkVar("Int", 3, "PureEph")
	self:NetworkVar("Int", 4, "RedAcid")
	self:NetworkVar("Int", 5, "Lye")
	self:NetworkVar("Int", 6, "LiquidMeth")
	self:NetworkVar("Int", 7, "Flour")
	self:NetworkVar("Int", 8, "Water")
	self:NetworkVar("Int", 9, "MethPurity")
	self:NetworkVar("Entity", 0, "Stove")
end
function ENT:IsOnStove()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 12)) do
		if (v:GetClass() == AML_CLASS_STOVE) and v:GetHasCanister() and (v:GetCanister():GetFuel() > 0) then
			self:SetStove(v)
			return IsValid(self)
		end
	end
end
function ENT:CheckForMismatch(stage)
	if (self:GetStage() != stage) and (self:GetStage() != AML_STAGE_NONE) then
		self:SetChemicalMismatch(true)
		return true
	elseif (self:GetStage() == AML_STAGE_NONE) then
		self:SetStage()
	end
	return false
end
function ENT:ProcessIngredient(ent)
	local class = ent:GetClass()
	if (class == AML_CLASS_PURE_EPHEDRINE) then
		if not self:CheckForMismatch(AML_STAGE_RED_ACID) then
			self:SetIngredient1(self:GetIngredient1() + 1)
		end
	elseif
end
function ENT:IngredientEffect(ent)
	SafeRemoveEntity(ent)
	self:EmitSound(Sound("ambient/levels/canals/toxic_slime_sizzle"..math.random(2, 4)..".wav"))
	self:VisualEffect()
end
function ENT:AdjustForRecipe()

end
function ENT:CanCook()
	local can
	if (self:GetStage() == AML_STAGE_RED_ACID) then
		can = (self:GetPureEph() and self:GetRedPhos() and self:GetHydroIodide())
	elseif	(self:GetStage() == AML_STAGE_LIQUID_METH) then
		can = (self:GetRedAcid() and self:GetLye())
	elseif (self:GetStage() == AML_STAGE_CRYSTAL_METH) then
		can = (self:GetLiquidMeth() and self:GetFlour() and self:GetWater())
	end
	return (can and self:IsOnStove())
end
function ENT:DoneCooking()
	return (self:GetCookingProgress() >= 100) and
end
if SERVER then
	function ENT:StartTouch(ent)
		if IsValid(ent) then
			if (ent:GetClass() == "rp_sodium") and (not self:GetHasSodium()) then
				SafeRemoveEntity(ent)
				self:SetHasSodium(true)
				self:EmitSound(Sound("ambient/levels/canals/toxic_slime_sizzle"..math.random(2, 4)..".wav"))
				self:VisualEffect()
			end
			if (ent:GetClass() == "rp_chloride") and (not self:GetHasChloride()) then
				self:SetHasChloride(true)
				self:IngredientEffect(ent)
			end
		end
	end
	function ENT:Think()
		if self:CanCook() and (not self:DoneCooking()) then
			self:SetCookingProgress(math.Clamp(self:GetCookingProgress() + 1, 0, self:GetTotalCookingTime()))
			self:GetStove():GetCanister():SetFuel(math.Clamp(self:GetStove():GetCanister():GetFuel() - 1, 0, AML_CONFIG_FUEL_AMOUNT))
			if (math.random(1, 2) == 2) then
				self:EmitSound(Sound("ambient/levels/canals/toxic_slime_gurgle"..math.random(2, 8)..".wav"))
			end
		end
		self:NextThink(CurTime() + 1)
		return true
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if self:DoneCooking() and (self:GetStage() == AML_STAGE_METH) then
				self:SetCookingProgress(0)
				self:SetHasSodium(false)
				self:SetHasChloride(false)
				local meth = ents.Create(AML_)
				meth:SetPos(self:GetPos() + Vector(0, 0, 30))
				meth:Spawn()
				self:EmitSound(Sound("ambient/levels/canals/toxic_slime_sizzle"..math.random(2, 4)..".wav"))
			end
		end
	end
	function ENT:VisualEffect()
		local smoke = EffectData()
		smoke:SetStart(self:GetPos())
		smoke:SetOrigin(self:GetPos() + Vector(0, 0, 8))
		smoke:SetScale(8)
		util.Effect("GlassImpact", smoke, true, true)
	end
end
if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		local Pos = self:GetPos()
		local Ang = self:GetAngles()
		surface.SetFont("Trebuchet24")
		Ang:RotateAroundAxis(Ang:Forward(), 90)
		cam.Start3D2D(Pos + (Ang:Up() * 8) + (Ang:Right() * -2), Ang, 0.12)
			draw.RoundedBox(2, -50, -65, 100, 30, Color(140, 0, 0, 100))
			if (self:GetCookingProgress() > 0) then
				draw.RoundedBox(2, -50, -65, self:GetCookingProgress(), 30, Color(0, 225, 0, 100))
			end
			draw.SimpleText("Progress", "Trebuchet24", -40, -63, Color(255, 255, 255, 255))
			draw.WordBox(2, -55, -30, "Ingredients:", "Trebuchet24", Color(0, 225, 0, 100), Color(255, 255, 255, 255))
			draw.WordBox(2, -35, 5, "Sodium", "Trebuchet24", self:GetHasSodium() and Color(0, 225, 0, 100) or Color(140, 0, 0, 100), Color(255, 255, 255, 255))
			draw.WordBox(2, -40, 40, "Chloride", "Trebuchet24", self:GetHasChloride() and Color(0, 225, 0, 100) or Color(140, 0, 0, 100), Color(255, 255, 255, 255))
		cam.End3D2D()
	end
	function ENT:Think()
		if (self.EmitTime <= CurTime()) and self:CanCook() and (not self:DoneCooking()) then
			local smoke = self.FirePlace:Add("particle/smokesprites_000"..math.random(1,9), self:GetPos())
			smoke:SetVelocity(Vector(0, 0, 150))
			smoke:SetDieTime(math.Rand(0.6, 2.3))
			smoke:SetStartAlpha(math.Rand(150, 200))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(5, 15))
			smoke:SetEndSize(math.random(20, 35))
			smoke:SetRoll(math.Rand(180, 480))
			smoke:SetRollDelta(math.Rand(-3, 3))
			smoke:SetColor(125, 125, 125)
			smoke:SetGravity(Vector(0, 0, 10))
			smoke:SetAirResistance(256)
			self.EmitTime = CurTime() + 0.1
		end
	end
end