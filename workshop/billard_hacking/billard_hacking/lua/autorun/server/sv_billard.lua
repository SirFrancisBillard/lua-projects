function DoGenericUseEffect(ply) --Boy, I love stealin' stuff!
	if ply:IsPlayer() then
		local Wep = ply:GetActiveWeapon()
		if IsValid(Wep) then Wep:SendWeaponAnim(ACT_VM_DRAW) end
		ply:ViewPunch(Angle(1,0,0))
		ply:SetAnimation(PLAYER_ATTACK1)
	end
end