SWEP.Category = "Billard"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "Hacking Gun"
SWEP.Base = "weapon_base"
SWEP.Purpose = "Select entities to hack"
SWEP.Instructions = "Left click to select entity to hack and right click to select a hacking device"

SWEP.HoldType = "ar2"
SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.UseHands = true

SWEP.DrawAmmo = false

function SWEP:SetupDataTables()
	self:NetworkVar( "Entity", 0, "LinkedEntity" )
	self:NetworkVar( "Entity", 1, "LinkedHacker" )
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self:SetLinkedEntity(nil)
	self:SetLinkedHacker(nil)
end

function SWEP:Reload()
	self:SetLinkedEntity(nil)
	self:SetLinkedHacker(nil)
	if IsValid(self.Owner) then
		self.Owner:ChatPrint("Cleared linked entity and linked device")
		DoGenericUseEffect(self.Owner)
	end
end

function SWEP:PrimaryAttack()
	if IsValid(self.Owner) then
		local tr = self.Owner:GetEyeTrace()
		if IsValid(tr.Entity) and !tr.Entity:IsPlayer() and !tr.Entity:IsWorld() then
			self:SetLinkedEntity(tr.Entity)
			self.Owner:ChatPrint("You have selected a(n) "..tr.Entity:GetClass().." to hack")
			DoGenericUseEffect(self.Owner)
		end
	end
end

function SWEP:SecondaryAttack()
	if IsValid(self.Owner) then
		local tr = self.Owner:GetEyeTrace()
		if IsValid(tr.Entity) and !tr.Entity:IsPlayer() and !tr.Entity:IsWorld() then
			self:SetLinkedHacker(tr.Entity)
			self.Owner:ChatPrint("You have selected a(n) "..tr.Entity:GetClass().." to use as a hacker")
			DoGenericUseEffect(self.Owner)
		end
	end
end
