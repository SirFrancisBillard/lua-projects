-- Classes in case they ever change

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

-- Fluid enumerations
AML_FLUID_NONE = 0
AML_FLUID_LYE_SOLUTION = 1
AML_FLUID_RED_ACID = 2
AML_FLUID_LIQUID_METH = 3

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
