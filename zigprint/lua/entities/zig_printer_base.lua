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
	local was_error = false
	if (self:GetInk() < 1) then
		errors["no_ink"] = "Printer requires ink!"
		was_error = true
	end
	if (self:GetBatteries() < 1) then
		errors["no_battery"] = "Printer requires a battery!"
		was_error = true
	end
	if was_error then
		return errors
	else
		return {"No errors."}
	end
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
			if self:CanPrint() then
				self:SetPrintingProgress(math.Clamp(self:GetPrintingProgress() + 1, 0, self.RealPrintTime))
				self:StartSound()
			end
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

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		local Pos = self:GetPos()
		local Ang = self:GetAngles()

		surface.SetFont("Trebuchet24")

		Ang:RotateAroundAxis(Ang:Up(), 90)

		local PrinterWidth = 130
		local BorderWidth = 20
		local BorderColor = Color(255, 0, 0)
		local BackgroundColor = Color(255, 100, 100)
		local TextColor = Color(255, 255, 255)

		local SingleSingle = -PrinterWidth + BorderWidth
		local SingleDouble = -PrinterWidth + (BorderWidth * 2)
		local DoubleSingle = (-PrinterWidth * 2) + BorderWidth
		local DoubleDouble = (-PrinterWidth * 2) + (BorderWidth * 2)

		local prog = Lerp(self:GetPrintingProgress() / self.Print.Time , 0, 100)

		cam.Start3D2D(Pos + Ang:Up() * 11.5, Ang, 0.11)
			draw.RoundedBox(2, -PrinterWidth, -PrinterWidth, PrinterWidth * 2, PrinterWidth * 2, BorderColor)
			draw.RoundedBox(2, -PrinterWidth + BorderWidth, -PrinterWidth + BorderWidth, (PrinterWidth * 2) - (BorderWidth * 2), (PrinterWidth * 2) - (BorderWidth * 2), BackgroundColor)
			draw.WordBox(2, SingleDouble, SingleDouble + (40 * 0), "Money: $"..string.Comma(self:GetStoredMoney()), "Trebuchet24", BorderColor, TextColor)
			draw.WordBox(2, SingleDouble, SingleDouble + (40 * 1), "Progress: "..prog.."%", "Trebuchet24", BorderColor, TextColor)
		cam.End3D2D()
	end
end
