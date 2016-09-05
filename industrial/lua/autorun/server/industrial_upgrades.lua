hook.Add("DoPlayerDeath", "IndustrialMod_ResetNetwork", function(ply, atk, dmg)
	if (not ply:GetNWBool("Upgrade_JetpackKeep")) then
		ply:SetNWBool("IsWearingJetpack", false)
		
		ply:SetNWInt("Upgrade_JetpackPower", 0)
	end
	if (not ply:GetNWBool("Upgrade_NanoSuitKeep")) then
		ply:SetNWBool("IsWearingNanoSuit", false)
		
		ply:SetNWInt("Upgrade_NanoSuitProtection", 0)
		ply:SetNWInt("Upgrade_NanoSuitRespiration", 0)
	end
	if (not ply:GetNWBool("Upgrade_QuantumSuitKeep")) then
		ply:SetNWBool("IsWearingQuantumSuit", false)
		
		ply:SetNWInt("Upgrade_QuantumSuitProtection", 0)
		ply:SetNWInt("Upgrade_QuantumSuitRespiration", 0)
	end
	if (not ply:GetNWBool("Upgrade_LaserKeep")) then
		ply:SetNWInt("Upgrade_LaserDamage", 0)
		ply:SetNWInt("Upgrade_LaserIgnite", 0)
		ply:SetNWInt("Upgrade_LaserAOE", 0)
	end
end)

hook.Add("EntityTakeDamage", "IndustrialMod_SuitProtection", function(target, dmg)
	local atk = dmg:GetAttacker()
	if target:IsPlayer() then
		if (dmg:GetDamageType() == DMG_DROWN) then
			if target:GetNWBool("IsWearingNanoSuit", false) and (target:GetNWInt("Upgrade_NanoSuitRespiration") > 0) then
				dmg:ScaleDamage(math.max(1.0 / target:GetNWInt("Upgrade_NanoSuitRespiration", 0), 0.01))
			end
			if target:GetNWBool("IsWearingQuantumSuit", false) and (target:GetNWInt("Upgrade_QuantumSuitRespiration") > 0) then
				dmg:ScaleDamage(math.max(1.0 / target:GetNWInt("Upgrade_QuantumSuitRespiration", 0), 0.01))
			end
		else
			if target:GetNWBool("IsWearingNanoSuit", false) then
				dmg:ScaleDamage(math.max(0.4 / target:GetNWInt("Upgrade_NanoSuitProtection", 0), 0.05))
			end
			if target:GetNWBool("IsWearingQuantumSuit", false) then
				dmg:ScaleDamage(math.max(0.1 / target:GetNWInt("Upgrade_QuantumSuitProtection", 0), 0.05))
			end
		end
	end
end)

hook.Add("PlayerSay", "IndustrialMod_UpgradeStuff", function(ply, txt, team)
	local args = string.Split(string.lower(txt), " ")
	if args[1] and args[2] and args[3] then
		if (args[1] == "/upgrade") then
			if (args[2] == "nano") then

			elseif (args[3] == "quantum") then

			end
		end
	end
end)
