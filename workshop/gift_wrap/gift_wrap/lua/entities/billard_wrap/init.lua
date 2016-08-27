AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props/cs_office/Paper_towels.mdl")
	self:SetMaterial("models/debug/debugwhite")
	self:SetColor(Color(120, 255, 0, 255))
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetUseType(3)
	self:SetCanBeUsed(true)
end

local BlockedClasses = {
	["billard_gift"] = true,
	["billard_drug_market"] = true,
	["spawned_*"] = true,
	["prop_door"] = true,
	["prop_door_rotating"] = true,
	["func_*"] = true,
}

function ENT:Touch(toucher)
	if IsValid(toucher) and !toucher:IsPlayer() and !toucher:IsWorld() and self:GetCanBeUsed() and !BlockedClasses[toucher:GetClass()] then
		self:SetCanBeUsed(false)
		local gift = ents.Create("billard_gift")
		if !IsValid(gift) then return end
		gift:SetOutputModel(toucher:GetModel())
		gift:SetOutputClass(toucher:GetClass())
		gift:SetOutputPitch(toucher:GetAngles().pitch)
		gift:SetOutputYaw(toucher:GetAngles().yaw)
		gift:SetOutputRoll(toucher:GetAngles().roll)
		if toucher:GetColor() then
			gift:SetOutputRed(toucher:GetColor().r)
			gift:SetOutputGreen(toucher:GetColor().g)
			gift:SetOutputBlue(toucher:GetColor().b)
		end
		if toucher:GetMaterial() then
			gift:SetOutputMaterial(toucher:GetMaterial())
		end
		gift:SetPos(self:GetPos() + Vector(0, 0, 40))
		gift:Spawn()
		toucher:Remove()
		self:EmitSound("ui/item_gift_wrap_use.wav")
		self:Remove()
	end
end
