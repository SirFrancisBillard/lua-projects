AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Fuel Can"
ENT.Spawnable = true
ENT.Model = "models/props_junk/gascan001a.mdl"
function ENT:IndustrialType()
	return "base"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:ExtraNetworkedVars()
	self:NetworkVar("Int", 1, "FuelHealth")
end
function ENT:HelpText()
	return "Fuel can be used with jetpacks or missiles, as well as being three times better at powering combustion engines compared to oil."
end
function ENT:CanReceivePower()
	return false
end
function ENT:CanTransmitPower()
	return false
end
if SERVER then
	function ENT:ExtraInit()
		self:SetFuelHealth(35)
	end
	function ENT:OnTakeDamage(dmg)
		self:SetFuelHealth(self:GetFuelHealth() - dmg:GetDamage())
		if (self:GetFuelHealth() <= 0) then
			local boom = EffectData()
			boom:SetOrigin(self:GetPos())
			util.Effect("HelicopterMegaBomb", boom)
			SafeRemoveEntity(self)
			self:EmitSound("weapons/explode"..math.random(3, 5)..".wav")
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 64)) do
				if IsValid(v) and (v:IsPlayer() or v:IsNPC()) then
					v:Kill()
				end
			end
		end
	end
end
