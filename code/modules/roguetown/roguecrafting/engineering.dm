/datum/crafting_recipe/roguetown/engineering
	abstract_type = /datum/crafting_recipe/roguetown/engineering

/* The original recipes from Vanderlin
/datum/slapcraft_recipe/engineering/structure/pressure_plate
	name = "pressure plate"
	steps = list(
		/datum/slapcraft_step/item/cog,
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/engineering/hammer,
		)
	result_type = /obj/structure/pressure_plate
	craftsound = 'sound/foley/Building-01.ogg'

/datum/slapcraft_recipe/engineering/structure/repeater
	name = "repeater"
	steps = list(
		/datum/slapcraft_step/item/cog,
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/use_item/engineering/hammer,
		/datum/slapcraft_step/item/stick,
		)
	result_type = /obj/structure/repeater
	craftsound = 'sound/foley/Building-01.ogg'

/datum/slapcraft_recipe/engineering/structure/activator
	name = "activator"
	steps = list(
		/datum/slapcraft_step/item/cog,
		/datum/slapcraft_step/item/cog/second,
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/use_item/engineering/hammer,
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/use_item/engineering/hammer/second,
		)
	result_type = /obj/structure/activator
	craftsound = 'sound/foley/Building-01.ogg'
*/

/datum/crafting_recipe/roguetown/engineering/pressure_plate
	name = "pressure plate"
	result = /obj/structure/pressure_plate
	reqs = list(/obj/item/roguegear = 1, /obj/item/grown/log/tree/small = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 2

/datum/crafting_recipe/roguetown/engineering/activator
	name = "activator"
	result = /obj/structure/activator
	reqs = list(/obj/item/roguegear = 1, /obj/item/grown/log/tree/small = 1, /obj/item/grown/log/tree/small = 1, /obj/item/ingot/iron = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 2


/datum/crafting_recipe/roguetown/engineering/coolingtable
	name = "Cooling Table"
	result = /obj/structure/table/cooling
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/ingot/iron = 1,
				/obj/item/roguegear = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 4


/datum/crafting_recipe/roguetown/engineering/lever
	name = "lever"
	result = /obj/structure/lever
	reqs = list(/obj/item/roguegear = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/engineering/trapdoor
	name = "floorhatch"
	result = /obj/structure/floordoor
	reqs = list(/obj/item/grown/log/tree/small = 1,
					/obj/item/roguegear = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 2

/datum/crafting_recipe/roguetown/engineering/trapdoor/TurfCheck(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return TRUE
	if(istype(T,/turf/open/lava))
		return FALSE
	return ..()

/datum/crafting_recipe/roguetown/engineering/floorgrille
	name = "floorgrille"
	result = /obj/structure/bars/grille
	reqs = list(/obj/item/ingot/iron = 1,
					/obj/item/roguegear = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3

/datum/crafting_recipe/roguetown/engineering/floorgrille/TurfCheck(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return TRUE
	if(istype(T,/turf/open/lava))
		return FALSE
	return ..()

/datum/crafting_recipe/roguetown/engineering/bars
	name = "metal bars"
	result = /obj/structure/bars
	reqs = list(/obj/item/ingot/iron = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/engineering/shopbars
	name = "shop bars"
	result = /obj/structure/bars/shop
	reqs = list(/obj/item/ingot/iron = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/engineering/passage
	name = "passage"
	result = /obj/structure/bars/passage
	reqs = list(/obj/item/ingot/iron = 1,
					/obj/item/roguegear = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 2

/datum/crafting_recipe/roguetown/engineering/passage/TurfCheck(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return FALSE
	if(istype(T,/turf/open/lava))
		return FALSE
	if(istype(T,/turf/open/water))
		return FALSE
	return ..()

/datum/crafting_recipe/roguetown/engineering/freedomchair
	name = "LIBERTAS"
	result = /obj/structure/chair/freedomchair/crafted
	reqs = list(/obj/item/ingot/blacksteel = 1, /obj/item/roguegear = 3)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 5

//pyro arrow crafting, from stonekeep
/datum/crafting_recipe/roguetown/engineering/pyrobolt
	name = "pyroclastic bolt"
	result = /obj/item/ammo_casing/caseless/rogue/bolt/pyro
	reqs = list(/obj/item/ammo_casing/caseless/rogue/bolt = 1,
				/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 1)
	req_table = TRUE
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/engineering/pyrobolt_five
	name = "pyroclastic bolt (x5)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro,
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro,
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro,
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro,
				/obj/item/ammo_casing/caseless/rogue/bolt/pyro
				)
	reqs = list(/obj/item/ammo_casing/caseless/rogue/bolt = 5,
				/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 5)
	req_table = TRUE
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/engineering/pyroarrow
	name = "pyroclastic arrow"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/pyro
	reqs = list(/obj/item/ammo_casing/caseless/rogue/arrow/iron = 1,
				/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 1)
	req_table = TRUE
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/engineering/pyroarrow_five
	name = "pyroclastic arrow (x5)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro,
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro,
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro,
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro,
				/obj/item/ammo_casing/caseless/rogue/arrow/pyro
				)
	reqs = list(/obj/item/ammo_casing/caseless/rogue/arrow/iron = 5,
				/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 5)
	req_table = TRUE
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

//gunmaking slop
/*/datum/crafting_recipe/roguetown/firingpim
	name = "Firing pin"
	reqs = list(/obj/item/ingot/iron = 1)
	result = list(/obj/item/firing_pin)
	skillcraft = /datum/skill/craft/engineering
	structurecraft = /obj/machinery/light/rogue/smelter
	craftdiff = 2
*/ 
/datum/crafting_recipe/roguetown/engineering/firearmstock
	name = "Firearm stock"
	tools = (/obj/item/rogueweapon/huntingknife)
	reqs = list(/obj/item/grown/log/tree/small = 1)
	result = list(/obj/item/weaponcrafting/stock)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 2

/datum/crafting_recipe/roguetown/engineering/firearmparts
	name = "Firearm parts"
	reqs = list(/obj/item/ingot/steel = 2)
	result = list(/obj/item/weaponcrafting/receiver)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 4

/datum/crafting_recipe/roguetown/engineering/firearmbarrel
	name = "Firearm barrel"
	reqs = list(/obj/item/ingot/iron = 2)
	result = list(/obj/item/weaponcrafting/barrel)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3

/datum/crafting_recipe/roguetown/engineering/arquebus
	name = "Arquebus"
	reqs = list(/obj/item/ingot/steel = 8, /obj/item/ingot/bronze = 2, /obj/item/weaponcrafting/barrel = 1, /obj/item/weaponcrafting/receiver = 1, /obj/item/grown/log/tree/small = 1, /obj/item/weaponcrafting/stock = 1)
	result = list(/obj/item/gun/ballistic/arquebus)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 5 //le ultimate challenge

/datum/crafting_recipe/roguetown/engineering/handgonne
	name = "Handgonne"
	reqs = list(/obj/item/ingot/iron = 4, /obj/item/weaponcrafting/barrel = 1, /obj/item/weaponcrafting/receiver = 1, /obj/item/grown/log/tree/small = 1, /obj/item/weaponcrafting/stock = 1)
	result = list(/obj/item/gun/ballistic/handgonne)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3

/datum/crafting_recipe/roguetown/engineering/arquebuspistol
	name = "Arquebus pistol"
	reqs = list(/obj/item/ingot/steel = 4, /obj/item/ingot/bronze = 1 , /obj/item/weaponcrafting/barrel = 1, /obj/item/weaponcrafting/receiver = 1, /obj/item/grown/log/tree/small = 1)
	result = list(/obj/item/gun/ballistic/arquebus_pistol)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 4

/datum/crafting_recipe/roguetown/engineering/firearmramrod
	name = "replacement ramrod"
	reqs = list(/obj/item/ingot/iron = 1)
	result = list(/obj/item/ramrod)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3
