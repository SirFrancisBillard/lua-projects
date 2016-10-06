AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "cityrp_base"
ENT.PrintName = "Kevlar"
ENT.Category = "CityRP"
ENT.Spawnable = true
ENT.Model = "models/props_c17/SuitCase_Passenger_Physics.mdl"

if SERVER then
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if ply:Armor() >= 100 then
				ply:ChatPrint("You are already wearing kevlar.")
			else
				ply:ChatPrint("You have equipped kevlar.")
				ply:SetArmor(100)
			end
		end
	end
end
