SWEP.PrintName = "Billard Base SWEP"
SWEP.Category = "Billard Base"
SWEP.Base = "weapon_base"
SWEP.Purpose = "Purpose"
SWEP.Instructions = "Instructions"
SWEP.Contact = "Contact"
SWEP.Author = "Author"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"
SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.UseHands = true

SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true
SWEP.Slot = 0
SWEP.SlotPos = 10

SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.ShootSound = "Weapon_AR2.Single"
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Damage = 20
SWEP.Primary.Cone = 0.002
SWEP.Primary.Recoil = 0.1
SWEP.Primary.Delay = 0.5
SWEP.Primary.NumShots = 1
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = "Buckshot"
SWEP.Secondary.ShootSound = "Weapon_AR2.Single"
SWEP.Secondary.ClipSize = 8
SWEP.Secondary.DefaultClip = 8
SWEP.Secondary.Damage = 10
SWEP.Secondary.Cone = 0.02
SWEP.Secondary.Recoil = 0.5
SWEP.Secondary.Delay = 1
SWEP.Secondary.NumShots = 8
SWEP.Secondary.Automatic = false

SWEP.OnPrimaryHitFunc = function(attacker, victim)
	victim:Ignite(4)
 end
SWEP.OnSecondaryHitFunc = function(attacker, victim)
	victim:SetVelocity(Vector(0, 0, 100))
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()

end

function SWEP:PrimaryAttack()
	if (!self:CanPrimaryAttack()) then return end
	self.Weapon:EmitSound(self.Primary.ShootSound)
	self:ShootBullet(self.Primary.Damage, self.Primary.NumShots, self.Primary.Cone)
	self:TakePrimaryAmmo(1)
	self.Owner:ViewPunch(Angle(math.random(self.Primary.Recoil * -1, self.Primary.Recoil), 0, 0 ))
end
