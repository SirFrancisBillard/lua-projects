AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "cityrp_base"
ENT.PrintName = "Flashlight Battery"
ENT.Category = "CityRP"
ENT.Spawnable = true
ENT.Model = "models/Items/car_battery01.mdl"

ENT.Sounds = {
	Equip = Sound("items/battery_pickup.wav")
}

if SERVER then
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if caller.FlashlightBattery then
				caller:ChatPrint("You already have a flashlight battery.")
			else
				caller:ChatPrint("You have picked up a flashlight battery.")
				self:EmitSound(self.Sounds.Equip)
				caller.FlashlightBattery = true
				caller:AllowFlashlight(true)
				SafeRemoveEntity(self)
			end
		end
	end
end
