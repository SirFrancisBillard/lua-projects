AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_wasteland/controlroom_filecabinet001a.mdl")
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
		caller:GiveAmmo(4, "pistol", true)
		caller:GiveAmmo(2, "357", true)
		caller:GiveAmmo(1, "xbowbolt", true)
		caller:GiveAmmo(1, "rpg_round", true)
		caller:GiveAmmo(6, "smg1", true)
		caller:GiveAmmo(1, "smg1_grenade", true)
		caller:GiveAmmo(1, "grenade", true)
		caller:GiveAmmo(1, "slam", true)
		caller:GiveAmmo(4, "alyxgun", true)
		caller:GiveAmmo(2, "sniperround", true)
		caller:GiveAmmo(2, "sniperpenetratedround", true)
		caller:GiveAmmo(1, "thumper", true)
		caller:GiveAmmo(2, "gravity", true)
		caller:GiveAmmo(2, "guassenergy", true)
		caller:GiveAmmo(1, "combinecannon", true)
		caller:GiveAmmo(4, "airboatgun", true)
		caller:GiveAmmo(2, "striderminigun", true)
		caller:GiveAmmo(2, "helicoptergun", true)
		caller:GiveAmmo(2, "buckshot", true)
		caller:GiveAmmo(6, "ar2", true)
		caller:GiveAmmo(1, "ar2altfire", true)
		self:EmitSound("items/ammopickup.wav")
		DoGenericUseEffect(caller)
	end
end