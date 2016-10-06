AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "cityrp_base"
ENT.PrintName = "Spray Can"
ENT.Category = "CityRP"
ENT.Spawnable = true
ENT.Model = "models/Items/car_battery01.mdl"

ENT.Sounds = {
	Equip = Sound("items/itempickup.wav")
}

if SERVER then
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if caller.SprayCan then
				caller:ChatPrint("You already have a spray can.")
			else
				caller:ChatPrint("You have picked up a spray can.")
				self:EmitSound(self.Sounds.Equip)
				caller.SprayCan = true
				SafeRemoveEntity(self)
			end
		end
	end
	hook.Add("PlayerSpray", "CityRP_SprayCan", function(ply)
		return not ply.SprayCan
	end)
end
