function DoGenericUseEffect(ply) --Boy, I love stealin' stuff!
	if ply:IsPlayer() then
		local Wep = ply:GetActiveWeapon()
		if IsValid(Wep) then Wep:SendWeaponAnim(ACT_VM_DRAW) end
		ply:ViewPunch(Angle(1,0,0))
		ply:SetAnimation(PLAYER_ATTACK1)
	end
end

--[[
Perk List

Defensive (Take less damage)
feather - 60% less fall damage taken
gills - no drown damage 
painkillers - 20% less damage takentaken
kevlar - 40% less bullet damage taken
adrenaline - You live on low health when killed
ceramic - Completely block 1 bullet
tough - 10 damage subtracted on every hit
benzo (benzodiazepine) - no impact damage taken
heavy - You take no knockback
helmet - 90% chance to deflect headshots

Offensive (Deal more damage)
gunslinger - 30% more bullet damage dealt
pissed - 20% more damage dealt when health < 25%
leech - 20% of damage done is returned as health
sting - 5 damage added on every hit

Passive
lightfeet - Footsteps make no sound

Other Ideas (Delete this section of the comment)
unblur - Unblurs vision by removing all PP effects
]]

local meta = FindMetaTable("Player")

function meta:HasBPerk(perkname)
	return tobool(self:GetPData("bperks_"..perkname, 0))
end

function meta:GiveBPerk(perkname)
	self:SetPData("bperks_"..perkname, 1)
end

function meta:TakeBPerk(perkname)
	self:SetPData("bperks_"..perkname, 0)
end

hook.Add("EntityTakeDamage", "BPerks_EntityTakeDamage", function(target, dmg)
	if IsValid(target) and target:IsPlayer() then
		local atk = dmg:GetAttacker()
		local amt = dmg:GetDamage()
		
		--Defensive
		
		if target:HasBPerk("feather") and dmg:IsFallDamage() then
			dmg:ScaleDamage(0.4)
		end
		
		if target:HasBPerk("gills") and (dmg:GetDamageType() == DMG_DROWN) then
			dmg:ScaleDamage(0)
		end
		
		if target:HasBPerk("painkillers") then
			dmg:ScaleDamage(0.8)
		end
		
		if target:HasBPerk("kevlar") and dmg:IsBulletDamage() then
			dmg:ScaleDamage(0.6)
		end
		
		if target:HasBPerk("adrenaline") and (target:Health() - dmg:GetDamage() < 1) then
			target:SetHealth(math.random(5, 10))
			dmg:SetDamage(1)
			target:ChatPrint("The adrenaline keeps you alive...")
		end
		
		if target:HasBPerk("ceramic") and dmg:IsBulletDamage() then
			dmg:ScaleDamage(0)
			dmg:SetDamage(0)
			target:ChatPrint("Your ceramic plate has broken!")
			target:TakeBPerk("ceramic")
		end
		
		if target:HasBPerk("tough") then
			dmg:SetDamage(math.Clamp(dmg:GetDamage() - 10, 0, 1000000))
		end
		
		if target:HasBPerk("benzo") and (dmg:GetDamageType() == DMG_CRUSH) or (dmg:GetDamageType() == DMG_VEHICLE) then
			dmg:ScaleDamage(0)
		end
		
		if target:HasBPerk("heavy") then
			dmg:SetDamageForce(Vector(0, 0, 0))
		end
		
		--Offensive
		
		if atk:HasBPerk("gunslinger") and dmg:IsBulletDamage() then
			dmg:ScaleDamage(1.3)
		end
		
		if atk:HasBPerk("pissed") and (atk:Health() < (atk:GetMaxHealth() / 4)) then
			dmg:ScaleDamage(1.2)
		end
		
		if atk:HasBPerk("leech") then
			atk:SetHealth(math.Clamp(math.Clamp((dmg:GetDamage() * 0.2), 0, 10), 0, atk:GetMaxHealth()))
		end
		
		if atk:HasBPerk("sting") and (dmg:GetDamage() > 0) then
			dmg:SetDamage(dmg:GetDamage() + 5)
		end
		
	end
end)

hook.Add("ScalePlayerDamage", "BPerks_ScalePlayerDamage", function(ply, hg, dmg)
	if ply:HasBPerk("helmet") and (hg == HITGROUP_HEAD) and (math.random(1, 10) > 2) then
		dmg:ScaleDamage(0)
		dmg:SetDamage(0)
		ply:ChatPrint("Your helmet has deflected a headshot!")
	end
end)

hook.Add("PlayerFootstep", "BPerks_PlayerFootstep", function(ply, pos, foot, sound, volume, filter)
	if ply:HasBPerk("lightfeet") then
		return true
	end
end)
