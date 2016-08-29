hook.Add("StartCommand", "IndustrialMod_Jetpack", function(ply, cmd)
	if ply:GetNWBool("IsWearingJetpack") and (cmd:KeyDown(IN_JUMP)) then
		ply:SetVelocity(Vector(0, 0, 25))
	end
end)

hook.Add("DoPlayerDeath", "IndustrialMod_StripJetpack", function(ply, atk, dmg)
	ply:SetNWBool("IsWearingJetpack", false)
end)
