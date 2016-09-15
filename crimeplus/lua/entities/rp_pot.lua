AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Pot"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/props_c17/metalPot001a.mdl"

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
	self:SetCookingProgress(0)
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Up(), 90)
	self:SetAngles(Ang)
end
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "CookingProgress")
	self:NetworkVar("Bool", 0, "HasSodium")
	self:NetworkVar("Bool", 1, "HasChloride")
	self:NetworkVar("Entity", 0, "Stove")
end
function ENT:IsOnStove()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 12)) do
		if (v:GetClass() == "rp_stove") and v:GetHasCanister() and (v:GetCanister():GetFuel() > 0) then
			self:SetStove(v)
			return true
		end
	end
end
function ENT:CanCook()
	return (self:GetHasSodium() and self:GetHasChloride() and self:IsOnStove())
end
function ENT:DoneCooking()
	return (self:GetCookingProgress() >= 100)
end

if SERVER then
	function ENT:StartTouch(ent)
		if IsValid(ent) then
			if (ent:GetClass() == "rp_sodium") and (not self:GetHasSodium()) then
				SafeRemoveEntity(ent)
				self:SetHasSodium(true)
				self:EmitSound("ambient/water/drip"..math.random(1, 4)..".wav")
			end
			if (ent:GetClass() == "rp_chloride") and (not self:GetHasChloride()) then
				SafeRemoveEntity(ent)
				self:SetHasChloride(true)
				self:EmitSound("ambient/water/drip"..math.random(1, 4)..".wav")
			end
		end
	end
	function ENT:Think()
		if self:CanCook() and (not self:DoneCooking()) then
			self:SetCookingProgress(math.Clamp(self:GetCookingProgress() + 1, 0, 100))
			self:GetStove():GetCanister():SetFuel(math.Clamp(self:GetStove():GetCanister():GetFuel() - 1, 0, 200))
		end
		self:NextThink(CurTime() + 1)
		return true
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			if self:DoneCooking() then
				self:SetCookingProgress(0)
				self:SetHasSodium(false)
				self:SetHasChloride(false)
				local meth = ents.Create("rp_meth")
				meth:SetPos(self:GetPos() + Vector(0, 0, 30))
				meth:Spawn()
			end
		end
	end
end

// CLEITN

if CLIENT then
	function ENT:Draw()
		self:DrawModel()

		local Pos = self:GetPos()
		local Ang = self:GetAngles()

		surface.SetFont("Trebuchet24")

		Ang:RotateAroundAxis(Ang:Forward(), 90)

		cam.Start3D2D(Pos + (Ang:Up() * 8) + (Ang:Right() * -2), Ang, 0.12)
			draw.RoundedBox(2, -50, -65, 100, 30, Color(140, 0, 0, 100))
			if (self:GetCookingProgress() > 0) then
				draw.RoundedBox(2, -50, -65, self:GetCookingProgress(), 30, Color(0, 225, 0, 100))
			end
			draw.SimpleText("Progress", "Trebuchet24", -40, -63, Color(255, 255, 255, 255))
			draw.WordBox(2, -55, -30, "Ingredients:", "Trebuchet24", Color(0, 225, 0, 100), Color(255, 255, 255, 255))
			draw.WordBox(2, -35, 5, "Sodium", "Trebuchet24", self:GetHasSodium() and Color(0, 225, 0, 100) or Color(140, 0, 0, 100), Color(255, 255, 255, 255))
			draw.WordBox(2, -40, 40, "Chloride", "Trebuchet24", self:GetHasChloride() and Color(0, 225, 0, 100) or Color(140, 0, 0, 100), Color(255, 255, 255, 255))
		cam.End3D2D()
	end
end
