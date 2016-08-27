ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Wrapped Gift"
ENT.Category = "Billard"

ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "OutputModel")
	self:NetworkVar("String", 1, "OutputClass")
	self:NetworkVar("String", 2, "OutputMaterial")
	self:NetworkVar("Int", 0, "OutputRed")
	self:NetworkVar("Int", 1, "OutputGreen")
	self:NetworkVar("Int", 2, "OutputBlue")
	self:NetworkVar("Int", 3, "OutputPitch")
	self:NetworkVar("Int", 4, "OutputYaw")
	self:NetworkVar("Int", 5, "OutputRoll")
end
