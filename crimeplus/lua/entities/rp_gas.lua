AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Gas"
ENT.Category = "Crime+"
ENT.Spawnable = true
ENT.Model = "models/props_junk/propane_tank001a.mdl"

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
		phys:SetMass(40)
	end
	self:SetFuel(200)
	self:SetLastStove(CurTime())
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Up(), 90)
	self:SetAngles(Ang)
end
function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "HasStove")
	self:NetworkVar("Entity", 0, "Stove")
	self:NetworkVar("Float", 0, "LastStove")
	self:NetworkVar("Int", 0, "Fuel")
end
function ENT:IsReadyForStove()
	return ((CurTime() - self:GetLastStove()) > 2)
end

if SERVER then
	function ENT:Think()
		local phys = self:GetPhysicsObject()
		if self:GetHasStove() and IsValid(phys) then
			phys:SetMass(1)
		elseif IsValid(phys) then
			phys:SetMass(40)
		end
	end
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() and (self:GetFuel() <= 0) and (not self:GetHasStove()) then
			SafeRemoveEntity(self)
		end
		if IsValid(caller) and caller:IsPlayer() and self:GetHasStove() then
			self:SetHasStove(false)
			self:GetStove():SetHasCanister(false)
			constraint.RemoveAll(self)
			self:EmitSound("physics/metal/metal_barrel_impact_soft"..math.random(1, 4)..".wav")
			self:SetLastStove(CurTime())
		end
	end
	function ENT:OnRemove()
		if (not self:GetHasStove()) then return end
		self:SetHasStove(false)
		self:GetStove():SetHasCanister(false)
		constraint.RemoveAll(self)
		self:EmitSound("physics/metal/metal_barrel_impact_soft"..math.random(1, 4)..".wav")
		self:SetLastStove(CurTime())
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()

		local Pos = self:GetPos()
		local Ang = self:GetAngles()

		surface.SetFont("Trebuchet24")

		Ang:RotateAroundAxis(Ang:Forward(), 90)

		cam.Start3D2D(Pos + (Ang:Up() * 8) + (Ang:Right() * -2), Ang, 0.12)
			draw.RoundedBox(2, -50, -65, 100, 30, Color(140, 0, 0, 100))
			if (self:GetFuel() > 0) then
				draw.RoundedBox(2, -50, -65, self:GetFuel(), 30, Color(0, 225, 0, 100))
			end
		cam.End3D2D()
	end
end
