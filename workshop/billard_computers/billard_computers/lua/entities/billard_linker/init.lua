AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_lab/tpplug.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetUseType(3)
	self:SetFoundServer(false)
	self:SetFoundComputer(false)
end

function ENT:Touch(toucher)
	if IsValid(toucher) then
		if (toucher:GetClass() == "billard_server") and !self:GetFoundServer() then
			self:SetFoundServer(true)
		end
		if (toucher:GetClass() == "billard_computer_built") and !self:GetFoundComputer() and self:GetFoundServer() then
			toucher:SetIsLinked(true)
			self:SetFoundComputer(true)
		end
	end
end

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() then
		if self:GetFoundServer() and self:GetFoundComputer() then
			caller:ChatPrint("This server linker is linked to a server and computer")
		elseif !self:GetFoundServer() and self:GetFoundComputer() then
			caller:ChatPrint("This server linker is linked to a computer")
		elseif self:GetFoundServer() and !self:GetFoundComputer() then
			caller:ChatPrint("This server linker is linked to a server")
		elseif !self:GetFoundServer() and !self:GetFoundComputer() then
			caller:ChatPrint("This server linker is not linked to anything")
		end
		DoGenericUseEffect(caller)
	end
end