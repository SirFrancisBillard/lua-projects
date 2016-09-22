AddCSLuaFile()
ENT.Base = AML_CLASS_BASE
ENT.PrintName = AML_NAME_CRYSTAL_METH
ENT.Category = AML_SPAWN_CATEGORY
ENT.Spawnable = AML_SPAWNABLE
ENT.AdminSpawnable = AML_SPAWNABLE_ADMIN
ENT.Model = AML_MODEL_CRYSTAL_METH
functionENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Purity")
	self:NetworkVar("Int", 1, "UsedRedPhos")
	self:NetworkVar("Int", 2, "UsedLye")
	self:NetworkVar("Int", 3, "UsedFlour")
end
if SERVER then
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
		
		end
	end
end
