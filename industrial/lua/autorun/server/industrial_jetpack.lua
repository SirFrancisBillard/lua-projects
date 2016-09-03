hook.Add("StartCommand", "IndustrialMod_Jetpack", function(ply, cmd)
	if ply:GetNWBool("IsWearingJetpack") and (cmd:KeyDown(IN_JUMP)) then
		ply:SetVelocity(Vector(0, 0, 25 + (5 * ply:GetNWInt("Upgrade_JetpackPower"))))
	end
end)
