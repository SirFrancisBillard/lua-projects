SWEP.PrintName = "Tranquilizer Pistol"
SWEP.Author = "Sir Francis Billard"
SWEP.Instructions = "Left click to tranquilize a target.\nTranquilizer darts do not damage objects."
SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.UseHands = true
SWEP.ViewModelFOV = 60
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

SWEP.SwayScale = 1
SWEP.DrawAmmo = false
SWEP.Slot = 1

SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 2
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "None"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

function SWEP:Deploy()
	self:SetHoldType("revolver")
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:CanPrimaryAttack()
	if self.Weapon:Clip1() <= 0 then
		self:EmitSound("Weapon_Pistol.Empty")
		self:SetNextPrimaryFire(CurTime() + 1)
		self:Reload()
		return false
	end
	return true
end

function SWEP:PrimaryAttack()
	if (!self:CanPrimaryAttack()) then return end
	self.Weapon:EmitSound("weapons/usp/usp1.wav")
	self:TakePrimaryAmmo(1)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:ViewPunch(Angle(-1, 0, 0))
	if self.Owner:IsPlayer() then
		self.Owner:LagCompensation(true)
	end
	if IsValid(self.Owner) and IsValid(self.Owner:GetEyeTrace().Entity) and (self.Owner:GetEyeTrace().Entity:IsPlayer() or self.Owner:GetEyeTrace().Entity:IsNPC()) then
		local bitch = self.Owner:GetEyeTrace().Entity
		local rag = ents.Create("prop_ragdoll")
		local OldPos = bitch:GetPos()
		rag:SetPos(bitch:GetPos())
		rag:SetModel(bitch:GetModel())
		rag:Spawn()
		if bitch:IsPlayer() then
			bitch:SpectateEntity(rag)
		elseif bitch:IsNPC() then
			bitch:SetPos(OldPos + Vector(0, 0, -800))
		end
		timer.Simple(5, function()
			if bitch:IsPlayer() then
				if IsValid(bitch) then
					bitch:UnSpectate()
					bitch:SetPos(OldPos + Vector(0, 0, 20))
				end
				SafeRemoveEntity(rag)
			elseif bitch:IsNPC() then
				if IsValid(bitch) then
					bitch:SetPos(OldPos + Vector(0, 0, 20))
				end
				SafeRemoveEntity(rag)
			end
		end)
	end
	if self.Owner:IsPlayer() then
		self.Owner:LagCompensation(false)
	end
	self:SetNextPrimaryFire(CurTime() + 0.1)
end
