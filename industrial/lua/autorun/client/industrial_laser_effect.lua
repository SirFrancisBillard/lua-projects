hook.Add("PostDrawViewModel", "IndustrialMod_LaserEffect", function(vm, ply, wep)
	if (wep:GetClass() == "industrial_laser") and (ply:KeyDown(IN_ATTACK)) and (wep:GetCharge() > 0) then
		render.DrawLine(ply:EyePos(), ply:GetEyeTrace().HitPos, wep:GetLaserColor(), true)
	end
end)