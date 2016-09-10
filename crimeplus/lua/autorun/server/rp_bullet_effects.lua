if (not ConVarExists("crimeplus_bullet_effects")) then
	CreateConVar("crimeplus_bullet_effects", 0)
end

hook.Add("EntityFireBullets", "CrimePlus_CoolBulletEffects", function(ent, data)
	if (not GetConVar("crimeplus_bullet_effects"):GetBool()) then return end
	data.Callback = function(atk, tr, dmg)
		for k, v in pairs(ents.FindInSphere(tr.HitPos, 80)) do
			if IsValid(v) and v:IsPlayer() then
				v:ViewPunch(Angle(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)))
				v:EmitSound("weapons/fx/rics/ric"..math.random(1, 5)..".wav")
			end
		end
	end
	return true	
end)
