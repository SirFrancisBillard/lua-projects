ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Meth Pot"
ENT.Category = "Billard"

ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "HasChloride")
	self:NetworkVar("Bool", 1, "HasSodium")
end
