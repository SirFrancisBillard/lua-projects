
hook.Add("DoPlayerDeath", "StopBleedingOnDeath", function(ply, atk, dmg)
	ply:SetNWInt("Bleed", 0)
	ply:SetNWEntity("BleedAttacker", ply)
	ply:SetNWEntity("BleedInflictor", ply)
end)

hook.Add("EntityTakeDamage", "MakePlayerBleed", function(ply, dmg)
	if IsValid(ply) and ply:IsPlayer() and ply:Alive() and dmg:IsBulletDamage() then
		ply:SetNWInt("Bleed", ply:GetNWInt("Bleed", 0) + math.max(1, math.Round(dmg:GetDamage() / 10)))
		ply:SetNWEntity("BleedAttacker", dmg:GetAttacker())
		ply:SetNWEntity("BleedInflictor", dmg:GetInflictor())
	end
end)
