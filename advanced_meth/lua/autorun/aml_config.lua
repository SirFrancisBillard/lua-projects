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
-- The color of smoke when cooking Lye
AML_CONFIG_SMOKE_LYE = Color(225, 255, 225)
-- The color of smoke when cooking Crystal Meth
AML_CONFIG_SMOKE_METH = Color(100, 100, 200)

-- Meth config
-- Does meth need a dealer to be sold?
AML_CONFIG_NEED_DEALER = false
-- What is the base price of meth?
AML_CONFIG_METH_PRICE = 60000

-- Other config
-- How much fuel should gas canisters hold?
AML_CONFIG_FUEL_AMOUNT = 200
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

-- General data
AML_NAME_LONG = "Advanced Meth Lab"
AML_NAME_SHORT = "AML"
AML_VERSION = 0.6
AML_AUTHOR = "Sir Francis Billard"
AML_PREFIX = "[AML] "

-- Spawning data
AML_SPAWN_CATEGORY = "Advanced Meth Lab"
AML_SPAWNABLE = true
AML_SPAWNABLE_ADMIN = false

-- Base classes
AML_CLASS_BASE = "aml_base"
AML_CLASS_BASE_INGREDIENT = "aml_base_ingredient"

-- Ingredient classes
AML_CLASS_PSEUDO_EPHEDRINE = "aml_pseudo_ephe"
AML_CLASS_PURE_EPHEDRINE = "aml_pure_ephe"
AML_CLASS_RED_PHOSPHORUS = "aml_red_phos"
AML_CLASS_HYDROGEN_IODIDE = "aml_hydro_iodide"
AML_CLASS_CHLOROFORM = "aml_chloroform"
AML_CLASS_CHLORINE = "aml_chlorine"
AML_CLASS_METHANE = "aml_methane"
AML_CLASS_POTASSIUM_HYDROXIDE = "aml_potas_hydro"
AML_CLASS_POTASSIUM_CARBONATE = "aml_potas_carbon"
AML_CLASS_CALCIUM_HYDROXIDE = "aml_calc_hydro"
AML_CLASS_WATER = "aml_water"
AML_CLASS_FLOUR = "aml_flour"

-- Item classes
AML_CLASS_POT = "aml_pot"
AML_CLASS_STOVE = "aml_stove"
AML_CLASS_SMALL_POT = "aml_small_pot"
AML_CLASS_GAS = "aml_gas"
AML_CLASS_FLASK = "aml_flask"
AML_CLASS_BARREL = "aml_barrel"

-- Meth class
AML_CLASS_CRYSTAL_METH = "aml_meth"

-- Ingredient names
AML_NAME_PSEUDO_EPHEDRINE = "Pseudo Ephedrine"
AML_NAME_PURE_EPHEDRINE = "Pure Ephedrine"
AML_NAME_RED_PHOSPHORUS = "Red Phosphorus"
AML_NAME_HYDROGEN_IODIDE = "Hydrogen Iodide"
AML_NAME_CHLOROFORM = "Chloroform"
AML_NAME_CHLORINE = "Chlorine"
AML_NAME_METHANE = "Methane"
AML_NAME_POTASSIUM_HYDROXIDE = "Potassium Hydroxide"
AML_NAME_POTASSIUM_CARBONATE = "Potassium Carbonate"
AML_NAME_CALCIUM_HYDROXIDE = "Calcium Hydroxide"
AML_NAME_WATER = "Water"
AML_NAME_FLOUR = "Flour"

-- Item names
AML_NAME_POT = "Pot"
AML_NAME_STOVE = "Stove"
AML_NAME_SMALL_POT = "Small Pot"
AML_NAME_GAS = "Gas Canister"
AML_NAME_FLASK = "Flask"
AML_NAME_BARREL = "Mixing Barrel"

-- Meth name
AML_NAME_CRYSTAL_METH = "Methamphetamine"

-- Backwards compatability for fluids in stoves
AML_NAME_LYE_SOLUTION = "Caustic Soda"
AML_NAME_RED_ACID = "Intermediate Acid"
AML_NAME_LIQUID_METH = "Liquid Methamphetamine"

-- Ingredient models
AML_MODEL_PSEUDO_EPHEDRINE = "models/props_junk/garbage_glassbottle002a.mdl"
AML_MODEL_PURE_EPHEDRINE = "models/props_lab/jar01b.mdl"
AML_MODEL_RED_PHOSPHORUS = "models/props_debris/concrete_chunk05g.mdl"
AML_MODEL_HYDROGEN_IODIDE = "models/props_c17/canister01a.mdl"
AML_MODEL_CHLOROFORM = "models/props_junk/garbage_plasticbottle001a.mdl"
AML_MODEL_CHLORINE = "models/props_junk/garbage_plasticbottle002a.mdl"
AML_MODEL_METHANE = "models/props_junk/PropaneCanister001a.mdl"
AML_MODEL_POTASSIUM_HYDROXIDE = "models/props_junk/garbage_milkcarton001a.mdl"
AML_MODEL_POTASSIUM_CARBONATE = "models/props_junk/garbage_metalcan001a.mdl"
AML_MODEL_CALCIUM_HYDROXIDE = "models/props_junk/garbage_milkcarton002a.mdl"
AML_MODEL_WATER = "models/props_junk/garbage_plasticbottle003a.mdl"
AML_MODEL_FLOUR = "models/props_junk/garbage_bag001a.mdl"

-- Item models
AML_MODEL_POT = "models/props_c17/metalPot001a.mdl"
AML_MODEL_STOVE = "models/props_c17/furnitureStove001a.mdl"
AML_MODEL_SMALL_POT = "models/props_interiors/pot02a.mdl"
AML_MODEL_GAS = "models/props_junk/propane_tank001a.mdl"
AML_MODEL_FLASK = "models/props_junk/glassjug01.mdl"
AML_MODEL_BARREL = "models/props_borealis/bluebarrel001.mdl"

-- Meth model
AML_MODEL_CRYSTAL_METH = "models/props_debris/concrete_chunk05g.mdl"

-- Fluid enumerations
AML_FLUID_NONE = 0
AML_FLUID_LYE_SOLUTION = 1
AML_FLUID_RED_ACID = 2
AML_FLUID_LIQUID_METH = 3

-- Fluid colors
AML_FLUID_COLOR_LYE_SOLUTION = Color(200, 255, 200)
AML_FLUID_COLOR_RED_ACID = Color(255, 0, 0)
AML_FLUID_LIQUID_METH = Color(0, 255, 255)

-- Stage enumerations
AML_STAGE_NONE = 0
AML_STAGE_RED_ACID = 1
AML_STAGE_LIQUID_METH = 2
AML_STAGE_CRYSTAL_METH = 3
AML_STAGE_PURE_EPHEDRINE = 4
AML_STAGE_POTASSIUM_HYDROXIDE = 5
AML_STAGE_LYE_SOLUTION = 6
AML_STAGE_CHLOROFORM = 7

-- Messages of impurity
AML_MESSAGE_IMPURE_FLOUR_MORE = "The Meth did not bind enough in the crystalization process."
AML_MESSAGE_IMPURE_FLOUR_LESS = "The Meth is too diluted with fillers."
AML_MESSAGE_IMPURE_RED_PHOSPHORUS_MORE = "The Meth is too weak and not satisfactory to addiction."
AML_MESSAGE_IMPURE_RED_PHOSPHORUS_LESS = "The Meth is too strong and can be toxic for use."
AML_MESSAGE_IMPURE_LYE_SOLUTION_MORE = "The Meth is too acidic."
AML_MESSAGE_IMPURE_LYE_SOLUTION_LESS = "The Meth is too basic."

-- Predefine for reasons
AML_PURITY_AMOUNT_FLOUR = math.random(1, 5)
AML_PURITY_AMOUNT_RED_PHOSPHORUS = math.random(1, 7)
AML_PURITY_AMOUNT_LYE_SOLUTION = math.random(1, 3)

-- Purity amounts
function ReloadMethPurityAmounts()
	AML_PURITY_AMOUNT_FLOUR = math.random(1, 5)
	AML_PURITY_AMOUNT_RED_PHOSPHORUS = math.random(1, 7)
	AML_PURITY_AMOUNT_LYE_SOLUTION = math.random(1, 3)
end

-- Have different values every time gamemode loads
hook.Add("OnGamemodeLoaded", "AdvancedMeth_OnGamemodeLoaded", ReloadMethPurityAmounts)
