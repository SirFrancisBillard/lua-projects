AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "cityrp_base"
ENT.PrintName = "C4"
ENT.Category = "CityRP"
ENT.Spawnable = true
ENT.Model = "models/weapons/w_c4_planted.mdl"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Planted")
	self:NetworkVar("Int", 0, "Countdown")
end

if SERVER then
	function ENT:Initialize()
		self.BaseClass.Initialize()
		self:SetPlanted(false)
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if self:GetPlanted() then
				if caller.CarryingC4Defuser then
					caller:ChatPrint("You have successfully defused the bomb.")
					self:EmitSound(CityRP.Config.C4.Sounds.Defuse)
					if math.random(1, 100) <= CityRP.Config.Defuser.Values.BreakChance then
						caller:ChatPrint("Unfortunately, your defuser broke in the process.")
						caller.CarryingC4Defuser = false
					end
					SafeRemoveEntity(self)
				else
					caller:ChatPrint("You do not have a defuser.")
				end
			else
				caller:ChatPrint("You have planted the bomb.")
				self:EmitSound(CityRP.Config.C4.Sounds.Plant)
				self:SetPlanted(true)
				for i = 1, CityRP.Config.C4.Values.Timer do
					timer.Simple(i, function()
						if not IsValid(self) then return end
						self:SetCountdown(CityRP.Config.C4.Values.Timer - i)
						self:EmitSound(CityRP.Config.C4.Sounds.Beep)
					end)
				end
				timer.Simple(CityRP.Config.C4.Values.Timer + 1, function()
					if not IsValid(self) then return end
					util.BlastDamage(self, self, self:GetPos(), 2048, 200)
					self:EmitSound(CityRP.Config.C4.Sounds.Explode)
					SafeRemoveEntity(self)
				end)
			end
		end
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		local FixAngles = self:GetAngles()
		local FixRotation = Vector(0, 270, 0)
		FixAngles:RotateAroundAxis(FixAngles:Right(), FixRotation.x)
		FixAngles:RotateAroundAxis(FixAngles:Up(), FixRotation.y)
		FixAngles:RotateAroundAxis(FixAngles:Forward(), FixRotation.z)
	 	local TargetPos = self:GetPos() + (self:GetUp() * 9)
		local m, s = self:FormatTime(self:GetCountdown())
		self.Text = string.format("%02d", m) .. ":" .. string.format("%02d", s)
		cam.Start3D2D(TargetPos, FixAngles, 0.15)
			draw.SimpleText(self.Text, "Default", 31, -22, Color(255, 0, 0, 255), 1, 1)
		cam.End3D2D()
	end
	function ENT:FormatTime(seconds)
		local m = seconds % 604800 % 86400 % 3600 / 60
		local s = seconds % 604800 % 86400 % 3600 % 60
		return math.floor(m), math.floor(s)
	end
end
