hook.Add("DoPlayerDeath", "IndustrialMod_ResetNetwork", function(ply, atk, dmg)
	if (not ply:GetNWBool("Upgrade_JetpackKeep")) then
		ply:SetNWBool("IsWearingJetpack", false)
		
		ply:SetNWInt("Upgrade_JetpackPower", 0)
	end
	if (not ply:GetNWBool("Upgrade_NanoSuitKeep")) then
		ply:SetNWBool("IsWearingNanoSuit", false)
		
		ply:SetNWInt("Upgrade_NanoSuitProtection", 0)
	end
	if (not ply:GetNWBool("Upgrade_QuantumSuitKeep")) then
		ply:SetNWBool("IsWearingQuantumSuit", false)
		
		ply:SetNWInt("Upgrade_QuantumSuitProtection", 0)
	end
	if (not ply:GetNWBool("Upgrade_LaserKeep")) then
		ply:SetNWInt("Upgrade_LaserDamage", 0)
		ply:SetNWInt("Upgrade_LaserIgnite", 0)
		ply:SetNWInt("Upgrade_LaserAOE", 0)
	end
end)

hook.Add("EntityTakeDamage", "IndustrialMod_SuitProtection", function(target, dmg)

end)
