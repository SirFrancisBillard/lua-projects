ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Harvested Weed"
ENT.Category = "Billard"

ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "UserHealth")
	self:NetworkVar("Bool", 0, "IsUsed")
	self:NetworkVar("Entity", 0, "UserPerson")
end