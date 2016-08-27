ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Built Computer"
ENT.Category = "Billard"

ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Fans")
	self:NetworkVar("Int", 1, "Processors")
	self:NetworkVar("Int", 2, "MotherBoards")
	self:NetworkVar("Int", 3, "StoredMoney")
	self:NetworkVar("Bool", 0, "IsLinked")
end
