plyMeta = FindMetaTable("Player")

function plyMeta:GetTokens()
	return self:GetNWInt("Industrial_Tokens", 0)
end

function plyMeta:SetTokens(amt)
	return self:SetNWInt("Industrial_Tokens", amt)
end

function plyMeta:AddTokens(amt)
	return self:SetNWInt("Industrial_Tokens", self:GetNWInt("Industrial_Tokens", 0) + 1)
end

function plyMeta:SubtractTokens(amt)
	return self:SetNWInt("Industrial_Tokens", math.Clamp(self:GetNWInt("Industrial_Tokens", 0) - 1, 0, self:GetNWInt("Industrial_Tokens", 0)))
end

function plyMeta:HasTokens(amt)
	return (self:GetNWInt("Industrial_Tokens", 0) >= amt)
end

function plyMeta:BuyUpgradeIfAvailable(item, upg)
	if (self:GetTokens() < 1) then
		return "Not enough tokens"
	end
	if (string.lower(item) == "jetpack") then
		if ply:GetNWBool("IsWearingJetpack", false) then
			
		end
	end
	if (string.lower(item) == "laser") then
		if (IsValid(self:GetActiveWeapon()) and (self:GetActiveWeapon():GetClass() == "industrial_laser")) then
			if (upg == "damage") then
				self:GetActiveWeapon():SetDoDamage(self:GetActiveWeapon():GetDoDamage() + 5)
				self:SubtractTokens(1)
				return "Laser damage upgraded"
			end
		else
			return "Please equip item to upgrade"
		end
	end
	if (string.lower(item) == "nano") then
		
	end
	if (string.lower(item) == "quantum") then
		
	end
	return "Unknown item or upgrade"
end

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
			ply:BuyUpgradeIfAvailable(args[2], args[3])
		end
	end
end)
