AddCSLuaFile()
ENT.Base = AML_CLASS_BASE
ENT.PrintName = AML_NAME_FLASK
ENT.Category = AML_SPAWN_CATEGORY
ENT.Spawnable = AML_SPAWNABLE
ENT.AdminSpawnable = AML_SPAWNABLE_ADMIN
ENT.Model = AML_MODEL_FLASK
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Fluid")
end
if SERVER then
	function ENT:Think()
		if (self:GetFluid() == AML_FLUID_NONE) then
			self:SetColor(Color(25, 25, 25))
		elseif (self:GetFluid() == AML_FLUID_LYE_SOLUTION) then
			self:SetColor(Color(25, 25, 25))
		elseif (self:GetFluid() == AML_FLUID_RED_ACID) then
			self:SetColor(Color(255, 0, 0))
		elseif (self:GetFluid() == AML_FLUID_LIQUID_METH) then
			self:SetColor(Color(25, 25, 25))
		end
		self:SetNextThink(CurTime() + 0.2)
		return true
	end
	function ENT:StartTouch(ent)
		if (self:GetFluid() == AML_FLUID_NONE) then
			if (ent:GetClass() == AML_CLASS_POT) then
				if (ent:GetRedAcid() > 0) then
					ent:SetRedAcid(math.Clamp(ent:GetRedAcid() - 1, 0, ent:GetRedAcid()))
					self:SetFluid(AML_FLUID_RED_ACID)
				elseif (ent:GetLiquidMeth() > 0) then
					ent:SetLiquidMeth(math.Clamp(ent:GetLiquidMeth() - 1, 0, ent:GetLiquidMeth()))
					self:SetFluid(AML_FLUID_LIQUID_METH)
				end
			elseif (ent:GetClass() == AML_CLASS_SMALL_POT) then
				if (ent:GetLye() > 0) then
					ent:SetLye(math.Clamp(ent:GetLye() - 1, 0, ent:GetLye()))
					self:SetFluid(AML_FLUID_LYE_SOLUTION)
				end
			end
		else
			if (self:GetFluid() == AML_FLUID_LYE_SOLUTION) and ((ent:GetClass() == AML_CLASS_SMALL_POT) or (ent:GetClass() == AML_CLASS_POT)) then
				ent:SetLye(ent:GetLye() + 1)
			elseif (self:GetFluid() == AML_FLUID_RED_ACID) and (ent:GetClass() == AML_CLASS_POT) then
				ent:SetRedAcid(ent:GetRedAcid() + 1)
			elseif (self:GetFluid() == AML_FLUID_LIQUID_METH) and (ent:GetClass() == AML_CLASS_POT) then
				ent:SetLiquidMeth(ent:GetLiquidMeth() + 1)
			end
		end
	end
end