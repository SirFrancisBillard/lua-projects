-------------------------------------------
-- ADVANCED METH LAB CONFIGURATION FILE ---
-------------------------------------------

-- Time config
-- The time it takes for things to cook in the pot
AML_CONFIG_TIME_POT = 30
-- The time it takes for things to cook in the small pot
AML_CONFIG_TIME_SMALL_POT = 15
-- The time it takes for things to mix in the barrel
AML_CONFIG_TIME_BARREL = 20

-- Smoke config
-- The regular color of smoke
AML_CONFIG_SMOKE_REGULAR = Color(125, 125, 125)
-- The color of smoke when cooking Red Acid
AML_CONFIG_SMOKE_RED = Color(200, 0, 0)

-- Other config
-- Do players cough when interacting with toxic chemicals?
AML_CONFIG_COUGHING = true
-- What chemicals are considered toxic?
AML_TOXIC_CHEMICALS = {
	AML_CLASS_POTASSIUM_CARBONATE = true,
	AML_CLASS_CALCIUM_HYDROXIDE = true,
	AML_CLASS_POTASSIUM_HYDROXIDE = true,
	AML_CLASS_HYDROGEN_IODIDE = true,
	AML_CLASS_CHLOROFORM = true,
	AML_CLASS_RED_PHOSPHORUS = true,
	AML_CLASS_RED_ACID = true
}
-- Some cooking stages are more sensitive to overheating
AML_SENSITIVE_STAGES = {
	AML_STAGE_CHLOROFORM = true,
	AML_STAGE_RED_ACID = true,
	AML_STAGE_LIQUID_METH = true
}
-- Some fluids are unstable and can explode if not neutralized in time
AML_UNSTABLE_FLUIDS = {
	AML_FLUID_RED_ACID = true
}
