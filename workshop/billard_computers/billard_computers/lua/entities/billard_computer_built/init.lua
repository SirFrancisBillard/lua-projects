AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_lab/harddrive02.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetUseType(3)
	self:SetFans(1)
	self:SetProcessors(1)
	self:SetMotherBoards(1)
	self:SetIsLinked(false)
	self:SetStoredMoney(0)
end

function ENT:Touch(toucher)
	if IsValid(toucher) then
		if (toucher:GetClass() == "billard_cpu_fan") and !(self:GetFans() >= 10) then
			toucher:Remove()
			self:SetFans(self:GetFans() + 1)
		elseif (toucher:GetClass() == "billard_cpu_processor") and !(self:GetProcessors() >= 10) then
			toucher:Remove()
			self:SetProcessors(self:GetProcessors() + 1)
		elseif (toucher:GetClass() == "billard_cpu_motherboard") and !(self:GetMotherBoards() >= 10) then
			toucher:Remove()
			self:SetMotherBoards(self:GetMotherBoards() + 1)
		end
	end
end

function ENT:Think()
	if self:GetIsLinked() then
		self:SetStoredMoney(self:GetStoredMoney() + (math.random(1, 10) * self:GetFans() * self:GetProcessors() * self:GetMotherBoards()))
	end
	self:NextThink(CurTime() + 1)
	return true
end

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() then
		if !self:GetOwner() then
			caller:ChatPrint("You have claimed this computer")
			self:SetOwner(caller)
		end
		if self:GetStoredMoney() then
			caller:ChatPrint("You have harvested $"..self:GetStoredMoney().." from the server")
			caller:addMoney(self:GetStoredMoney())
			self:SetStoredMoney(0)
		end
		DoGenericUseEffect(caller)
	end
end