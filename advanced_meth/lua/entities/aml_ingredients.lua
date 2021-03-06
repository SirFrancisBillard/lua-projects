AddCSLuaFile()

AML_INGREDIENTS = {
	[AML_CLASS_PSEUDO_EPHEDRINE] = {ent = {Base = AML_CLASS_BASE_INGREDIENT, Category = AML_SPAWN_CATEGORY, Spawnable = AML_SPAWNABLE, AdminSpawnable = AML_SPAWNABLE_ADMIN, PrintName = AML_NAME_PSEUDO_EPHEDRINE, Model = AML_MODEL_PSEUDO_EPHEDRINE, TextColor = Color(150, 75, 0)}},
	[AML_CLASS_PURE_EPHEDRINE] = {ent = {Base = AML_CLASS_BASE_INGREDIENT, Category = AML_SPAWN_CATEGORY, Spawnable = AML_SPAWNABLE, AdminSpawnable = AML_SPAWNABLE_ADMIN, PrintName = AML_NAME_PURE_EPHEDRINE, Model = AML_MODEL_PURE_EPHEDRINE, TextColor = Color(200, 200, 255)}},
	[AML_CLASS_RED_PHOSPHORUS] = {ent = {Base = AML_CLASS_BASE_INGREDIENT, Category = AML_SPAWN_CATEGORY, Spawnable = AML_SPAWNABLE, AdminSpawnable = AML_SPAWNABLE_ADMIN, PrintName = AML_NAME_RED_PHOSPHORUS, Model = AML_MODEL_RED_PHOSPHORUS, TextColor = Color(255, 0, 0), PermaColor = Color(255, 0, 0)}},
	[AML_CLASS_HYDROGEN_IODIDE] = {ent = {Base = AML_CLASS_BASE_INGREDIENT, Category = AML_SPAWN_CATEGORY, Spawnable = AML_SPAWNABLE, AdminSpawnable = AML_SPAWNABLE_ADMIN, PrintName = AML_NAME_HYDROGEN_IODIDE, Model = AML_MODEL_HYDROGEN_IODIDE, TextColor = Color(255, 255, 0)}},
	[AML_CLASS_CHLOROFORM] = {ent = {Base = AML_CLASS_BASE_INGREDIENT, Category = AML_SPAWN_CATEGORY, Spawnable = AML_SPAWNABLE, AdminSpawnable = AML_SPAWNABLE_ADMIN, PrintName = AML_NAME_CHLOROFORM, Model = AML_MODEL_CHLOROFORM, TextColor = Color(255, 200, 255)}},
	[AML_CLASS_CHLORINE] = {ent = {Base = AML_CLASS_BASE_INGREDIENT, Category = AML_SPAWN_CATEGORY, Spawnable = AML_SPAWNABLE, AdminSpawnable = AML_SPAWNABLE_ADMIN, PrintName = AML_NAME_CHLORINE, Model = AML_MODEL_CHLORINE, TextColor = Color(200, 200, 255)}},
	[AML_CLASS_METHANE] = {ent = {Base = AML_CLASS_BASE_INGREDIENT, Category = AML_SPAWN_CATEGORY, Spawnable = AML_SPAWNABLE, AdminSpawnable = AML_SPAWNABLE_ADMIN, PrintName = AML_NAME_METHANE, Model = AML_MODEL_METHANE, TextColor = Color(200, 255, 200)}},
	[AML_CLASS_POTASSIUM_HYDROXIDE] = {ent = {Base = AML_CLASS_BASE_INGREDIENT, Category = AML_SPAWN_CATEGORY, Spawnable = AML_SPAWNABLE, AdminSpawnable = AML_SPAWNABLE_ADMIN, PrintName = AML_NAME_POTASSIUM_HYDROXIDE, Model = AML_MODEL_POTASSIUM_HYDROXIDE, TextColor = Color(255, 255, 150)}},
	[AML_CLASS_POTASSIUM_CARBONATE] = {ent = {Base = AML_CLASS_BASE_INGREDIENT, Category = AML_SPAWN_CATEGORY, Spawnable = AML_SPAWNABLE, AdminSpawnable = AML_SPAWNABLE_ADMIN, PrintName = AML_NAME_POTASSIUM_CARBONATE, Model = AML_MODEL_POTASSIUM_CARBONATE, TextColor = Color(200, 200, 255)}},
	[AML_CLASS_CALCIUM_HYDROXIDE] = {ent = {Base = AML_CLASS_BASE_INGREDIENT, Category = AML_SPAWN_CATEGORY, Spawnable = AML_SPAWNABLE, AdminSpawnable = AML_SPAWNABLE_ADMIN, PrintName = AML_NAME_CALCIUM_HYDROXIDE, Model = AML_MODEL_CALCIUM_HYDROXIDE, TextColor = Color(200, 255, 150)}},
	[AML_CLASS_WATER] = {ent = {Base = AML_CLASS_BASE_INGREDIENT, Category = AML_SPAWN_CATEGORY, Spawnable = AML_SPAWNABLE, AdminSpawnable = AML_SPAWNABLE_ADMIN, PrintName = AML_NAME_WATER, Model = AML_MODEL_WATER, TextColor = Color(0, 255, 255)}},
	[AML_CLASS_FLOUR] = {ent = {Base = AML_CLASS_BASE_INGREDIENT, Category = AML_SPAWN_CATEGORY, Spawnable = AML_SPAWNABLE, AdminSpawnable = AML_SPAWNABLE_ADMIN, PrintName = AML_NAME_FLOUR, Model = AML_MODEL_FLOUR, TextColor = Color(255, 200, 150)}},
}

DEFINE_BASECLASS(AML_CLASS_BASE_INGREDIENT)

print(AML_PREFIX.."Registering ingredient entites...")

for k, v in SortedPairs(AML_INGREDIENTS) do
	scripted_ents.Register(v.ent, k)
	print(AML_PREFIX.."Registered ingredient: "..k)
end

print(AML_PREFIX.."Ingredient entities registered!")