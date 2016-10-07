-- CityRP Entities configuration file

CityRP = {
	Config = {
		C4 = {
			Sounds = {
				Beep = Sound("weapons/c4/c4_beep1.wav"),
				Plant = Sound("weapons/c4/c4_plant.wav"),
				Defuse = Sound("weapons/c4/c4_disarm.wav"),
				Explode = Sound("phx/explode00.wav")
			},
			Values = {
				Timer = 30,
				Radius = 512,
				Damage = 200,
				KnockDownDoors = true
			}
		},
		Defuser = {
			Sounds = {
				Equip = Sound("items/itempickup.wav")
			},
			Values = {
				BreakChance = 40
			}
		},
		Molotov = {
			Sounds = {
				Break = Sound("physics/glass/glass_impact_bullet4.wav")
			},
			Values = {
				IgniteTime = 5,
				RequiredSpeed = 300,
				Radius = 256,
				Timer = 1
			}
		},
		Kevlar = {
			Sounds = {
				Equip = Sound("items/itempickup.wav")
			},
			Values = {}
		},
		Battery = {
			Sounds = {
				Equip = Sound("items/battery_pickup.wav")
			},
			Values = {}
		},
		SprayCan = {
			Sounds = {
				Equip = Sound("items/itempickup.wav")
			},
			Values = {}
		}
	},
	Curry = function(f, v, ...)
		local function curry1()
			return function (...)  return f(v, ...)  end
		end
		if v == nil then return f end
		return curry(curry1(), ...)
	end
}
