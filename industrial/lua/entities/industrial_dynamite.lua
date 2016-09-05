AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Dynamite"
ENT.Spawnable = true
ENT.Model = "models/dav0r/tnt/tnt.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Dynamite goes boom when you ignite it."
end
function ENT:ExtraNetworkedVars()
	self:NetworkVar("Int", 10, "ExplodeTimer")
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
if SERVER then
	function ENT:OnEntityUsed(ply)

	end
end
