ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Computer"
ENT.Category = "Billard"

ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "HasFan")
	self:NetworkVar("Bool", 1, "HasProcessor")
	self:NetworkVar("Bool", 2, "HasMotherBoard")
end
