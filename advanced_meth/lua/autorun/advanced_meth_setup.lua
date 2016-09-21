-- Ingredient enumerations
-- Pot
AML_CLASS_PURE_EPHEDRINE = "aml_pure_ephe"
AML_CLASS_RED_PHOSPHORUS = "aml_red_phos"
AML_CLASS_HYDROGEN_IODIDE = "aml_hydro_iodide"

-- Purity amounts

function ReloadMethPurityAmounts()
	AML_PURITY_AMOUNT_FLOUR = math.random(1, 4)
end

hook.Add("OnGamemodeLoaded", "AdvancedMeth_OnGamemodeLoaded", ReloadMethPurityAmounts)
