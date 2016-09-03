AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Advanced Solar Panel"
ENT.Spawnable = true
ENT.Model = "models/props_phx/construct/metal_plate1.mdl"
function ENT:IndustrialType()
	return "gen"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:HelpText()
	return "Advanced solar panels generate much more power than their normal counterparts."
end
function ENT:PowerTransmitRate()
	return 160
end
function ENT:PowerGenerationRate()
	return 80
endfunction ENT:CanGeneratePower()
	return self:CanSeeSky()
end
