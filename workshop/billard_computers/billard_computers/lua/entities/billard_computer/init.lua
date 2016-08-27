AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_lab/harddrive01.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetUseType(3)
	self:SetHasFan(false)
	self:SetHasProcessor(false)
	self:SetHasMotherBoard(false)
end

function ENT:Touch(toucher)
	if IsValid(toucher) then
		if (toucher:GetClass() == "billard_cpu_fan") and !self:GetHasFan() then
			toucher:Remove()
			self:SetHasFan(true)
		elseif (toucher:GetClass() == "billard_cpu_processor") and !self:GetHasProcessor() then
			toucher:Remove()
			self:SetHasProcessor(true)
		elseif (toucher:GetClass() == "billard_cpu_motherboard") and !self:GetHasMotherBoard() then
			toucher:Remove()
			self:SetHasMotherBoard(true)
		end
	end
end

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() then
		if !self:GetOwner() then
			caller:ChatPrint("You have claimed this computer")
			self:SetOwner(caller)
		end
		if self:GetHasFan() and self:GetHasProcessor() and self:GetHasMotherBoard() then
			local cpu = ents.Create("billard_computer_built")
			cpu:SetPos(self:GetPos() + Vector(0, 0, 10))
			cpu:SetFans(1)
			cpu:SetProcessors(1)
			cpu:SetMotherBoards(1)
			cpu:Spawn()
			caller:ChatPrint("Your computer has been built")
			caller:ChatPrint("You can upgrade your computer's specs by adding more parts")
			self:Remove()
		else
			caller:ChatPrint("Required compontents:")
			if !self:GetHasFan() then
				caller:ChatPrint("Fan")
			end
			if !self:GetHasProcessor() then
				caller:ChatPrint("Processor")
			end
			if !self:GetHasMotherBoard() then
				caller:ChatPrint("Motherboard")
			end
		end
		DoGenericUseEffect(caller)
	end
end