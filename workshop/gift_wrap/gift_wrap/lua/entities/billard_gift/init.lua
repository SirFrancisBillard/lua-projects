AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_halloween/halloween_gift.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetUseType(3)
end

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() then
		local output = ents.Create(self:GetOutputClass())
		if !IsValid(output) then return end
		output:SetModel(self:GetOutputModel() or "models/player/eli.mdl")
		output:SetAngles(Angle(self:GetOutputPitch(), self:GetOutputYaw(), self:GetOutputRoll()) or Angle(0, 0, 0))
		if self:GetOutputRed() or self:GetOutputGreen() or self:GetOutputBlue() then
			output:SetColor(Color(self:GetOutputRed(), self:GetOutputGreen(), self:GetOutputBlue(), 255))
		end
		if self:GetOutputMaterial() then
			output:SetMaterial(self:GetOutputMaterial())
		end
		output:SetPos(self:GetPos() + Vector(0, 0, 40))
		output:Spawn()
		DoGenericUseEffect(caller)
		self:EmitSound("ui/item_gift_wrap_unwrap.wav")
		self:Remove()
	end
end