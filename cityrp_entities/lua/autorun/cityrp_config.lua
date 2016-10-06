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
				Timer = 30
			}
		},
		Defuser = {
			Sounds = {
				Equip = Sound("items/defuser_equip.wav")
			},
			Values = {
				BreakChance = 40
			}
		},
		Molotov = {
			Sounds = {},
			Values = {}
		}
		Battery = {
			Sounds = {
				Equip = Sound("items/battery_pickup.wav")
			},
			Values = {}
		}
		SprayCan = {
			Sounds = {
				Equip = Sound("items/itempickup.wav")
			},
			Values = {}
		}
	},
	Curry = function(f, v, ...)
		local function curry1(f, v)
			return function (...)  return f(v, ...)  end
		end
		if v == nil then return f end
		return curry(curry1(f, v), ...)
	end
}
