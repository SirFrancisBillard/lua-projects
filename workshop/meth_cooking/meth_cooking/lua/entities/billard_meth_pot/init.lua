AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/metalPot001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetUseType(3)
	self:SetHasChloride(false)
	self:SetHasSodium(false)
end

function ENT:Touch(toucher)
	if IsValid(toucher) then
		if toucher:GetClass() == "billard_chem_chloride" and !self:GetHasChloride() then
			self:SetHasChloride(true)
			self:EmitSound("fizz.wav")
			toucher:Remove()
		elseif toucher:GetClass() == "billard_chem_sodium" and !self:GetHasSodium() then
			self:SetHasSodium(true)
			self:EmitSound("fizz.wav")
			toucher:Remove()
		end
	end
end

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() then
		if self:GetHasChloride() and self:GetHasSodium() then
			caller:ChatPrint("Your meth has been cooked")
			local meth = ents.Create("billard_meth")
			meth:SetPos(self:GetPos() + Vector(0, 0, 20))
			meth:Spawn()
			self:SetHasChloride(false)
			self:SetHasSodium(false)
		elseif self:GetHasChloride() then
			caller:ChatPrint("You need to put Sodium in the pot!")
		elseif self:GetHasSodium() then
			caller:ChatPrint("You need to put Chloride in the pot!")
		else
			caller:ChatPrint("You need to put Chloride and Sodium in the pot!")
		end
		DoGenericUseEffect(caller)
	end
end