AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Crafting Table"
ENT.Spawnable = true6
ENT.Model = "models/props/CS_militia/wood_table.mdl"
function ENT:IndustrialType()
	return "mach"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:Recipes()
	return 0
end
function ENT:HelpText()
	return "Crafting tables are used to forge items like jetpacks and laser guns using materials and power."
end
function ENT:GetMaxStoredPower()
	return 10000
end
function ENT:ExtraNetworkedVars()
	self:NetworkVar("Entity", 0, "Crafter")
end
if SERVER then
	function ENT:ExtraThink() end
	function ENT:OnEntityUsed(ply)
		if (ply:IsPlayer()) then
			self:SetCrafter(ply)
		end
	end
end
