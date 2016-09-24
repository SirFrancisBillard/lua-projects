AddCSLuaFile()
ENT.Base = AML_CLASS_BASE
ENT.PrintName = AML_NAME_SMALL_POT
ENT.Category = AML_SPAWN_CATEGORY
ENT.Spawnable = AML_SPAWNABLE
ENT.AdminSpawnable = AML_SPAWNABLE_ADMIN
ENT.Model = AML_MODEL_SMALL_POT
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
	self:SetMismatched(false)
	self:SetMethPurity(0)
	self:SetTemperature(0)
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Up(), 90)
	self:SetAngles(Ang)
	if CLIENT then
		self.EmitTime = CurTime()
		self.FirePlace = ParticleEmitter(self:GetPos())
	end
end
function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Mismatched")
	self:NetworkVar("Int", 0, "CookingProgress")
	self:NetworkVar("Int", 1, "Temperature")
	self:NetworkVar("Int", 2, "PotasCarbon")
	self:NetworkVar("Int", 3, "CalcHydro")
	self:NetworkVar("Int", 4, "PotasHydro")
	self:NetworkVar("Int", 5, "Water")
	self:NetworkVar("Int", 6, "Lye")
	self:NetworkVar("Int", 7, "Chlorine")
	self:NetworkVar("Int", 8, "Methane")
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
function ENT:Cough()
	if not AML_CONFIG_COUGHING then return end
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 256)) do
		if IsValid(v) and v:IsPlayer() and (math.random(1, 2) == 1) then
			v:ViewPunch(Angle(math.random(10, 30), 0, 0))
			v:EmitSound(Sound("ambient/voices/cough"..math.random(1, 4)..".wav"))
		end
	end
end
function ENT:ProcessIngredient(ent)
	local class = ent:GetClass()
	if (class == AML_CLASS_POTASSIUM_CARBONATE) then
		self:SetPotasCarbon(self:GetPotasCarbon() + 1)
		return true
	elseif (class == AML_CLASS_CALCIUM_HYDROXIDE) then
		self:SetCalcHydro(self:GetCalcHydro() + 1)
		return true
	elseif (class == AML_CLASS_WATER) then
		self:SetWater(self:GetWater() + 1)
		return true
	elseif (class == AML_CLASS_CHLORINE) then
		self:SetChlorine(self:GetChlorine() + 1)
		return true
	elseif (class == AML_CLASS_METHANE) then
		self:SetMethane(self:GetMethane() + 1)
		return true
	end
	return false
end
function ENT:IngredientEffect(ent)
	SafeRemoveEntity(ent)
	self:EmitSound(Sound("ambient/levels/canals/toxic_slime_sizzle"..math.random(2, 4)..".wav"))
	self:VisualEffect()
end
function ENT:HasAnyChemicalsForStage(stage)
	if (stage == AML_STAGE_POTASSIUM_HYDROXIDE) then
		return ((self:GetPotasCarbon() > 0) or (self:GetCalcHydro() > 0))
	elseif (stage == AML_STAGE_LYE_SOLUTION) then
		return ((self:GetPotasHydro() > 0) or (self:GetWater() > 0))
	elseif (stage == AML_STAGE_CHLOROFORM) then
		return ((self:GetChlorine() > 0) or (self:GetMethane() > 0))
	end
end
function ENT:HasAllChemicalsForStage(stage)
	if (stage == AML_STAGE_POTASSIUM_HYDROXIDE) then
		return ((self:GetPotasCarbon() > 0) and (self:GetCalcHydro() > 0))
	elseif (stage == AML_STAGE_LYE_SOLUTION) then
		return ((self:GetPotasHydro() > 0) and (self:GetWater() > 0))
	elseif (stage == AML_STAGE_CHLOROFORM) then
		return ((self:GetChlorine() > 0) and (self:GetMethane() > 0))
	end
end
function ENT:GetCurrentStage()
	if self:HasAllChemicalsForStage(AML_STAGE_POTASSIUM_HYDROXIDE) then
		return AML_STAGE_POTASSIUM_HYDROXIDE
	elseif self:HasAllChemicalsForStage(AML_STAGE_LYE_SOLUTION) then
		return AML_STAGE_LYE_SOLUTION
	elseif self:HasAllChemicalsForStage(AML_STAGE_CHLOROFORM) then
		return AML_STAGE_CHLOROFORM
	else
		return AML_STAGE_NONE
	end
end
function ENT:GetAllChemicals()
	return {
		[AML_NAME_POTASSIUM_CARBONATE] = self:GetPotasCarbon(),
		[AML_NAME_CALCIUM_HYDROXIDE] = self:GetCalcHydro(),
		[AML_NAME_POTASSIUM_HYDROXIDE] = self:PotasHydro(),
		[AML_NAME_WATER] = self:GetWater(),
		[AML_NAME_LYE_SOLUTION] = self:GetLye(),
		[AML_NAME_CHLORINE] = self:GetChlorine(),
		[AML_NAME_METHANE] = self:GetMethane(),
		[AML_NAME_CHLOROFORM] = self:GetChloroform()
	}
end
function ENT:CheckForMismatch(stage)
	local a = self.HasAnyChemicalsForStage
	return (a(AML_STAGE_POTASSIUM_HYDROXIDE) and (a(AML_STAGE_LYE_SOLUTION) or a(AML_STAGE_CHLOROFORM))) or (a(AML_STAGE_LYE_SOLUTION) and (a(AML_STAGE_POTASSIUM_HYDROXIDE) or a(AML_STAGE_CHLOROFORM))) or (a(AML_STAGE_CHLOROFORM) and (a(AML_STAGE_POTASSIUM_HYDROXIDE) or a(AML_STAGE_LYE_SOLUTION)))
end
function ENT:CanCook()
	return ((self:HasAllChemicalsForStage(AML_STAGE_POTASSIUM_HYDROXIDE) or self:HasAllChemicalsForStage(AML_STAGE_LYE_SOLUTION) or self:HasAllChemicalsForStage(AML_STAGE_CHLOROFORM)) and self:IsOnStove())
end
function ENT:DoneCooking()
	return (self:GetCookingProgress() >= AML_CONFIG_TIME_SMALL_POT)
end
if SERVER then
	function ENT:Explode()
		util.BlastDamage(self, self, self:GetPos(), 256, 128)
		SafeRemoveEntity(self)
	end
	function ENT:StartTouch(ent)
		if IsValid(ent) then
			if self:ProcessIngredient(ent) then
				self:IngredientEffect(ent)
			end
		end
	end
	function ENT:Think()
		if self:CheckForMismatch() then
			self:SetMismatched(true)
		end
		if self:DoneCooking() and (not self:GetMismatched()) and (self:GetCurrentStage() != AML_STAGE_NONE) then
			if (self:GetCurrentStage() == AML_STAGE_POTASSIUM_HYDROXIDE) then
				self:SetPotasCarbon(0)
				self:SetCalcHydro(0)
				self:SetPotasHydro(self:GetPotasHydro() + 1)
			elseif (self:GetCurrentStage() == AML_STAGE_LYE_SOLUTION) then
				self:SetPotasHydro(0)
				self:SetWater(0)
				self:SetLye(self:GetLye() + 1)
			elseif (self:GetCurrentStage() == AML_STAGE_CHLOROFORM) then
				self:SetChlorine(0)
				self:SetMethane(0)
				local stuff = ents.Create(AML_CLASS_CHLOROFORM)
				stuff:SetPos(self:GetPos() + Vector(0, 0, 12))
				stuff:Spawn()
			end
			self:SetCookingProgress(0)
		end
		if self:CanCook() and (not self:DoneCooking()) then
			self:SetCookingProgress(math.Clamp(self:GetCookingProgress() + 1, 0, AML_CONFIG_TIME_SMALL_POT))
			self:GetStove():GetCanister():SetFuel(math.Clamp(self:GetStove():GetCanister():GetFuel() - 1, 0, AML_CONFIG_FUEL_AMOUNT))
			if (math.random(1, 2) == 2) then
				self:EmitSound(Sound("ambient/levels/canals/toxic_slime_gurgle"..math.random(2, 8)..".wav"))
			end
		end
		self:NextThink(CurTime() + 1)
		return true
	end
	function ENT:Use(activator, caller)
		self:SetAngles(Angle(self:GetAngles().p, caller:GetAngles().y + 180, 0))
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
		
		local pos = self:GetPos()
		local maxs = self:LocalToWorld(self:OBBMaxs())
		local mins = self:LocalToWorld(self:OBBMins())
		local ang = self:GetAngles()
		local top
		if (maxs.z > mins.z) then
			top = maxs.z
		else
			top = mins.z
		end

		local chem = self:GetAllChemicals()

		local stuff = {}
		if (not self:GetMismatched()) then
			for k, v in SortedPairs(chem) do
				if (v > 0) then
					stuff[#stuff + 1] = k..": "..(v * 100).."mL"
				end
			end
			if (#stuff < 1) then
				stuff[#stuff + 1] = AML_MESSAGE_NO_CHEMICALS
			end
		else
			stuff[#stuff + 1] = AML_MESSAGE_MISMATCHED[2]
			stuff[#stuff + 1] = AML_MESSAGE_MISMATCHED[1]
		end
		stuff[#stuff + 1] = self.PrintName

		cam.Start3D2D(Vector(pos.x, pos.y, pos.z + (top - pos.z) - 8), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.125)
			for k, v in pairs(stuff) do
				draw.SimpleTextOutlined(v, "Trebuchet24", 0, -100 - (35 * (k - 1)), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25))
			end
		cam.End3D2D()
	end
	function ENT:Think()
		self.EmitTime = self.EmitTime or CurTime()
		if (self.EmitTime <= CurTime()) and self:CanCook() and (not self:DoneCooking()) then
			local smoke = self.FirePlace:Add("particle/smokesprites_000"..math.random(1,9), self:GetPos())
			smoke:SetVelocity(Vector(0, 0, 120))
			smoke:SetDieTime(math.Rand(1.2, 2.8))
			smoke:SetStartAlpha(math.Rand(150, 200))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(5, 12))
			smoke:SetEndSize(math.random(20, 35))
			smoke:SetRoll(math.Rand(180, 480))
			smoke:SetRollDelta(math.Rand(-3, 3))
			if (self:GetPotasHydro() > 0) then
				smoke:SetColor(AML_CONFIG_SMOKE_LYE.r, AML_CONFIG_SMOKE_LYE.g, AML_CONFIG_SMOKE_LYE.b)
			else
				smoke:SetColor(AML_CONFIG_SMOKE_REGULAR.r, AML_CONFIG_SMOKE_REGULAR.g, AML_CONFIG_SMOKE_REGULAR.b)
			end
			smoke:SetGravity(Vector(0, 0, 10))
			smoke:SetAirResistance(256)
			self.EmitTime = CurTime() + 0.1
		end
	end
end
