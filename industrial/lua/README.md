# Industrialism in Garry's Mod
This is a bit interesting. I tried making a machine-focused mod for an RP server but never finished it. All I really have to show is the entity base code and the HUD hint code. The entity base is the closest I ever got to something functional, in both meanings of the word functional.

## Modding this mod
This mod is fairly easy to create new items for. Here is a list of functions and useful data to create custom entities. Obviously, Lua knowledge is almost required if you want to do anything other than make a simple generator or battery.
There are 4 types of entities in this mod.
- Base (base)
- Generator (gen)
- Battery (bat)
- Machine (mach)

The entity type makes the entity and entities around it behave differently when they acquire power. Base will not be able to receive or send power. Generators will send power to batteries and machines. Batteries will send power to other batteries and machines.

There is also entity data, which is very different than entity type. Currently, there are three functions that can optionally return entity data. Returning false will disable the entity from using that data.
- Refinery Data (ENT:RefineryData())
- Engine Data (ENT:EngineData())
- Miner Data (ENT:MinerData())

### Refinery Data
Refineries take certain entities and turn them into others, like oil into fuel or fueled minerals into uranium.
The function returns 6 values, in this order:
- 1. bool - Is this entity a refinery? If not, no other values need be returned.
- 2. table - A table containing all materials to refine.
- 3. int - How many different materials are needed from the table to refine into a product. If set to 1, any material in the Mats table will be converted 1:1 to a product. If set to 2, the first and second items in the materials table are required to make 1 product. If set to 3 (max), one of each three of the items in the materials table are required to make 1 product.
- 4. string - The product made after the refining process.
- 5. int - The time taken to refine items, must have adequate power to do so.
- 6. int - Power used per second of refining. Items will pause in their refining process if not enough power is given.

Example:
```javascript
function ENT:RefineryData()
	return true, {"industrial_metal", "industrial_oil", "industrial_zinc"}, 3, "industrial_gold", 20, 50
end
```
Result:
This entity is a refinery that will take 20 seconds to turn 1 metal, oil, and zinc into 1 gold if given 50 power per second.

### Engine Data
Engines use different types of fuel to produce power. They require said fuel to produce power, and will not do anything when not powered. Adding fuel only increases the amount of time the engine will run, with no effect on the engine's speed.
This function returns 3 values, in this order:
- 1. bool - Is this entity an engine? If not, no other values need be returned.
- 2. table - A table of items that can be used as fuel
- 3. table - A table of how long fuels of matching keys to the fuel table will make the engine run for (in seconds).

Example:
```javascript
function ENT:EngineData()
	return true, {"industrial_fuel", "industrial_gold"}, {10, 50}
end
```
Result:
This entity is an engine that is powered for 10 seconds by fuel and 50 seconds by gold.

### Miner Data
Miners use power to generate varying amounts of materials over time. Miners will halt their current mining progress if they do not have sufficient power.
This function returns 5 vales, in this order:
- 1. bool - Is this entity a miner? If not, no other values need be returned.
- 2. table - A table of one or more items that can be mined by this miner.
- 3. bool - Whether or not items are chosen at random from the item table. If disabled, the first item from the table will be selected.
- 4. int - The time in seconds needed to mine one item.
- 5. int - The power needed to complete one second of mining.

Example:
```javascript
function ENT:MinerData()
	return true, {"industrial_uranium", "industrial_gold"}, true, 60, 20
end
```
Result:
This entity is a miner that has a 50/50 chance of mining either uranium or gold. It requires 20 power per second for 20 seconds in order to mine an item.
