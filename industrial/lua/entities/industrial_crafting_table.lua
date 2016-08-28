AddCSLuaFile()

ENT.Base = "industrial_base"
ENT.PrintName = "Crafting Table"
ENT.Spawnable = true
ENT.Model = "models/props_interiors/Radiator01a.mdl"
function ENT:IndustrialType()
	return "mach"
	// valid types and their uses
	// base - does nothing
	// gen - generates power
	// bat - stores power
	// mach - uses power
end
function ENT:Recipes()
	return {
	jetpack = {result = "industrial_jetpack", recipe = {"industrial_metal_refined", "industrial_booster"}},
	laser = {result = "industrial_laser", recipe = {"industrial_metal_refined"}},
}
end
function ENT:HelpText()
	return "Crafting tables are used to forge items like jetpacks and laser guns using materials and power."
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
if CLIENT then
