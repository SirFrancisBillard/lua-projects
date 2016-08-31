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
The function returns 6 values:
- IsRef - Is this entity a refinery? If not, no other values need be returned.
- Mats - A table containing all materials to refine.
- MatAmt - How many different materials are needed from the table to refine into a product. If set to 1, any material in the Mats table will be converted 1:1 to a product. If set to 2, the first and second items in the Mats table are required to make 1 product. If set to 3 (max), one of each three of the items in the Mats table are required to make 1 product.
- Prod - The product made after the refining process.
- Tim - The time taken to refine items, must have adequate power to do so.
- Pow - Power used per second of refining. Items will pause in their refining process if not enough power is given.
