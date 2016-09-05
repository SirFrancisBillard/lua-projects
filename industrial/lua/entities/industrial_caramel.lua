AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Caramel"
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
	return "It's caramel. I was running out of ideas."
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
		ply:SetHealth(math.Clamp(ply:Health() + 20, 0, ply:GetMaxHealth()))
	end
end
