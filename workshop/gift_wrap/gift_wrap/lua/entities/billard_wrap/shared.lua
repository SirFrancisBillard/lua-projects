ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Gift Wrap"
ENT.Category = "Billard"

ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "CanBeUsed")
end
