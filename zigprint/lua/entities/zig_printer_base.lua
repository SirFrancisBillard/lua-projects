AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "ZigPrint Base"
ENT.Category = "ZigPrint"
ENT.Spawnable = true
ENT.Model = "models/props_c17/consolebox01a.mdl"

ENT.Print = {}
ENT.Print.Max = {}
ENT.Print.Amount = 250
ENT.Print.Time = 60
ENT.Print.Max.Ink = 10
ENT.Print.Max.Batteries = 10

function ENT:Initialize()
	self:SetModel(self.Model)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
	end
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end
	self:StartSound()
	self:SetStoredMoney(0)
	self:SetPrintingProgress(0)
	self:SetInk(0)
	self:SetBatteries(0)
end
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "StoredMoney")
	self:NetworkVar("Int", 1, "PrintingProgress")
	self:NetworkVar("Int", 2, "Ink")
	self:NetworkVar("Int", 3, "Batteries")
end
function ENT:StartSound()
	self.Noise = CreateSound(self, Sound("ambient/levels/labs/equipment_printer_loop1.wav"))
	self.Noise:SetSoundLevel(45)
	self.Noise:PlayEx(1, 50)
end
function ENT:CanPrint()
	return (self:GetInk() > 0) and (self:GetBatteries() > 0)
end
function ENT:OnRemove()
	if self.Noise then
		self.Noise:Stop()
	end
end
function ENT:PrinterErrors()
	local errors = {}
	if (self:GetInk() < 1) then
		errors["no_ink"] = "Printer requires ink!"
	end
	if (self:GetBatteries() < 1) then
		errors["no_battery"] = "Printer requires a battery!"
	end
	return errors
end

if SERVER then
	function ENT:StartTouch(ent)
		if IsValid(ent) then
			if (ent:GetClass() == "zig_ink") and (self:GetInk() < self.Print.Max.Ink) then
				SafeRemoveEntity(ent)
				self:SetInk(math.Clamp(self:GetInk() + 1, 0, self.Print.Max.Ink))
				self:EmitSound("ambient/water/drip"..math.random(1, 4)..".wav")
			end
			if (ent:GetClass() == "zig_battery") and (self:GetBatteries() < self.Print.Max.Batteries) then
				SafeRemoveEntity(ent)
				self:SetBatteries(math.Clamp(self:GetBatteries() + 1, 0, self.Print.Max.Batteries))
				self:EmitSound("items/battery_pickup.wav")
			end
		end
	end
	function ENT:Think()
		if self:CanPrint() then
			self.RealPrintTime = self.Print.Time - (5 * self:GetBatteries())
			self.RealPrintAmount = self.Print.Amount + (10 * self:GetInk())
			if (self.RealPrintTime < 1) then
				self.RealPrintTime = 1
			end
			if (self:GetPrintingProgress() == self.RealPrintTime) then
				self:SetPrintingProgress(0)
				self:SetStoredMoney(math.Clamp(self:GetStoredMoney() + self.RealPrintAmount, 0, 2000000000))
			end
			self:SetPrintingProgress(math.Clamp(self:GetPrintingProgress() + 1, 0, self.Print.Time))
			self:StartSound()
		end
		self:NextThink(CurTime() + 1)
		return true
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if (self:GetStoredMoney() > 0) then
				caller:addMoney(self:GetStoredMoney())
				self:SetStoredMoney(0)
			end
		end
	end
end
