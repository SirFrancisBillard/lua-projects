AddCSLuaFile()
ENT.Base = AML_CLASS_BASE
ENT.PrintName = AML_NAME_GUIDE
ENT.Category = AML_SPAWN_CATEGORY
ENT.Spawnable = AML_SPAWNABLE
ENT.AdminSpawnable = AML_SPAWNABLE_ADMIN
ENT.Model = AML_MODEL_GUIDE
if SERVER then
	function ENT:Use(activator, caller)
		if IsValid(caller) and caller:IsPlayer() then
			caller:ChatPrint("Meth Cooking Guide")
			caller:ChatPrint([[I provide help to those looking to cook Methamphetamine.
				I can be used by typing the name of a chemical or item in chat while near me.
				If I recognize the chemical or item, I will provide help in what you can do with it.
				Here are some basics:
				Every session, amounts of certain chemicals are picked at random to determine the purity of Meth.
				They are picked for how much of the following chemicals should be used:
				-Red Phosphorus
				-Caustic Soda
				-Flour
				The higher the purity of Meth, the higher the price.]])
		end
	end
end