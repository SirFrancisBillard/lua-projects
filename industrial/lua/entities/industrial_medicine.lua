AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Medicine"
ENT.Spawnable = true
ENT.Model = "models/hunter/blocks/cube025x025x025.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Medicine is used to heal."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
function ENT:PermaMaterial()
	return "phoenix_storms/fender_wood"
end
if SERVER then
	function ENT:OnEntityUsed(ply)
		SafeRemoveEntity(self)
		ply:SetHealth(math.Clamp(ply:Health() + 50, 0, ply:GetMaxHealth()))
	end
end
