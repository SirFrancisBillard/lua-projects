ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Server Linker"
ENT.Category = "Billard"

ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "FoundServer")
	self:NetworkVar("Bool", 1, "FoundComputer")
end
