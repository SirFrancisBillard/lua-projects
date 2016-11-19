math.randomseed(os.time())

things = {"planitt", "soler sisstim", "mune"}
colers = {"bloo", "gren", "yalow", "purper", "red", "orag", "bron", "blek"}

chosenThing = things[math.random(1, #things)]
ded = false

function die()
	print("u r ded")
	print("rip in pece")
	ded = true
	return
end

function xd()
	return colers[math.random(1, #colers)]
end

print("welcum 2 no mas'n sky")
print("ur ship is flyin to a " .. chosenThing)
print("ur ship has landed on the " .. chosenThing)
print("you hav got oot of ur ship")

if math.random(1, 5) == 5 then
	print("u furgot ur suit")
	die()
end

if not ded then
	print("u see the " .. chosenThing)
	print("the graund is mostly " .. xd() .. " but its also a lil " .. xd())
	print("it has " .. xd() .. " trees")
	print("it has " .. xd() .. " dinosaurs")

	print("you win")
	print("conglaturation")
end

print("thank you for playing")
print("no mas'n sky")
print("maed by vlave")
print("hopefurry we wirr rerease harf rife free in another seventeen years")
