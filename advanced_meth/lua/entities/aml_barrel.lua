AddCSLuaFile()
ENT.Base = AML_CLASS_BASE
ENT.PrintName = AML_NAME_BARREL
ENT.Category = AML_SPAWN_CATEGORY
ENT.Spawnable = AML_SPAWNABLE
ENT.AdminSpawnable = AML_SPAWNABLE_ADMIN
ENT.Model = AML_MODEL_BARREL
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
function ENT:IngredientEffect(ent)
	SafeRemoveEntity(ent)
	self:EmitSound(Sound("ambient/levels/canals/toxic_slime_sizzle"..math.random(2, 4)..".wav"))
	self:VisualEffect()
end
function ENT:GetAllChemicals()
	return {
		[AML_NAME_PSEUDO_EPHEDRINE] = self:GetPE(),
		[AML_NAME_CHLOROFORM] = self:GetChloroform()
	}
end
if SERVER then
	function ENT:StartTouch(ent)
		if IsValid(ent) then
			if (ent:GetClass() == AML_CLASS_CHLOROFORM) then
				self:IngredientEffect(ent)
				self:SetChloroform(self:GetChloroform() + 1)
			end
			if (ent:GetClass() == AML_CLASS_PSEUDO_EPHEDRINE) then
				self:IngredientEffect(ent)
				self:SetPE(self:GetPE() + 1)
			end
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
		for k, v in SortedPairs(chem) do
			if (v > 0) then
				stuff[#stuff + 1] = k..": "..(v * 100).."mL"
			end
		end
		if (#stuff < 1) then
			stuff[#stuff + 1] = AML_MESSAGE_NO_CHEMICALS
		end

		stuff[#stuff + 1] = self.PrintName

		cam.Start3D2D(Vector(pos.x, pos.y, pos.z + (top - pos.z) - 8), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.125)
			for k, v in pairs(stuff) do
				draw.SimpleTextOutlined(v, "Trebuchet24", 0, -100 - (35 * (k - 1)), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25))
			end
		cam.End3D2D()
	end
end