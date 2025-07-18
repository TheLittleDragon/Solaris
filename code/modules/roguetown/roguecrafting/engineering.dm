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

/datum/repeatable_crafting_recipe/engineering/water_pipe
	name = "fluid transport pipe"
	requirements = list(
		/obj/item/ingot/bronze = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list(span_notice("starts to hammer"), span_notice("start to hammer"), 'sound/items/bsmith2.ogg'),
	)
	attacked_atom = /obj/item/ingot/bronze
	starting_atom= /obj/item/weapon/hammer
	output = /obj/item/rotation_contraption/water_pipe
	output_amount = 12
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE
/datum/repeatable_crafting_recipe/engineering/boiler
	name = "boiler"
	requirements = list(
		/obj/item/ingot/copper = 3,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list(span_notice("starts to hammer"), span_notice("start to hammer"), 'sound/items/bsmith2.ogg'),
	)
	attacked_atom = /obj/item/ingot/copper
	starting_atom= /obj/item/weapon/hammer
	output = /obj/item/rotation_contraption/boiler
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE
/datum/repeatable_crafting_recipe/engineering/pump
	name = "liquid pump"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/ingot/bronze = 2,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
		/obj/item/weapon/hammer = list(span_notice("starts to hammer"), span_notice("start to hammer"), 'sound/items/bsmith2.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/rotation_contraption/pump
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE
/datum/repeatable_crafting_recipe/engineering/water_vent
	name = "fluid vent"
	requirements = list(
		/obj/item/ingot/bronze = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list(span_notice("starts to hammer"), span_notice("start to hammer"), 'sound/items/bsmith2.ogg'),
	)
	attacked_atom = /obj/item/ingot/bronze
	starting_atom= /obj/item/weapon/hammer
	output = /obj/item/rotation_contraption/water_vent
	output_amount = 2
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE
/datum/repeatable_crafting_recipe/engineering/steam_recharger
	name = "steam recharger"
	requirements = list(
		/obj/item/ingot/bronze = 2,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list(span_notice("starts to hammer"), span_notice("start to hammer"), 'sound/items/bsmith2.ogg'),
	)
	attacked_atom = /obj/item/ingot/bronze
	starting_atom= /obj/item/weapon/hammer
	output = /obj/item/rotation_contraption/steam_recharger
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE
/datum/repeatable_crafting_recipe/engineering/breaching_charge
	name = "breaching charge"
	requirements = list(
		/obj/item/reagent_containers/powder/blastpowder = 2,
		/obj/item/natural/fibers = 1,
		/obj/item/natural/cloth = 1,
	)
	attacked_atom = /obj/item/natural/cloth
	starting_atom = /obj/item/reagent_containers/powder/blastpowder
	output = /obj/item/breach_charge
	craft_time = 5 SECONDS
*/

/datum/crafting_recipe/roguetown/engineering/pressure_plate
	name = "pressure plate"
	category = "Engineering"
	result = /obj/structure/pressure_plate
	reqs = list(/obj/item/roguegear = 1, /obj/item/grown/log/tree/small = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 2

/datum/crafting_recipe/roguetown/engineering/activator
	name = "activator"
	category = "Engineering"
	result = /obj/structure/activator
	reqs = list(/obj/item/roguegear = 1, /obj/item/grown/log/tree/small = 1, /obj/item/grown/log/tree/small = 1, /obj/item/ingot/iron = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 2


/datum/crafting_recipe/roguetown/engineering/coolingtable
	name = "Cooling Table"
	category = "Engineering"
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
	category = "Engineering"
	result = /obj/structure/lever
	reqs = list(/obj/item/roguegear = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/engineering/trapdoor
	name = "floorhatch"
	category = "Engineering"
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
	category = "Engineering"
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
	category = "Engineering"
	result = /obj/structure/bars
	reqs = list(/obj/item/ingot/iron = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/engineering/shopbars
	name = "shop bars"
	category = "Engineering"
	result = /obj/structure/bars/shop
	reqs = list(/obj/item/ingot/iron = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/engineering/passage
	name = "passage"
	category = "Engineering"
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
	category = "Engineering"
	result = /obj/structure/chair/freedomchair/crafted
	reqs = list(/obj/item/ingot/blacksteel = 1, /obj/item/roguegear = 3)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 5

//pyro arrow crafting, from stonekeep
/datum/crafting_recipe/roguetown/engineering/pyrobolt
	name = "pyroclastic bolt"
	category = "Ammo"
	result = /obj/item/ammo_casing/caseless/rogue/bolt/pyro
	reqs = list(/obj/item/ammo_casing/caseless/rogue/bolt = 1,
				/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 1)
	req_table = TRUE
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/engineering/pyrobolt_five
	name = "pyroclastic bolt (x5)"
	category = "Ammo"
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
	category = "Ammo"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/pyro
	reqs = list(/obj/item/ammo_casing/caseless/rogue/arrow/iron = 1,
				/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 1)
	req_table = TRUE
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/engineering/pyroarrow_five
	name = "pyroclastic arrow (x5)"
	category = "Ammo"
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
	category = "Firearms"
	tools = (/obj/item/rogueweapon/huntingknife)
	reqs = list(/obj/item/grown/log/tree/small = 1)
	result = list(/obj/item/weaponcrafting/stock)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 2

/datum/crafting_recipe/roguetown/engineering/firearmparts
	name = "Firearm parts"
	category = "Firearms"
	reqs = list(/obj/item/ingot/steel = 2)
	result = list(/obj/item/weaponcrafting/receiver)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 4

/datum/crafting_recipe/roguetown/engineering/firearmbarrel
	name = "Firearm barrel"
	category = "Firearms"
	reqs = list(/obj/item/ingot/iron = 2)
	result = list(/obj/item/weaponcrafting/barrel)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3

/datum/crafting_recipe/roguetown/engineering/arquebus
	name = "Arquebus"
	category = "Firearms"
	reqs = list(/obj/item/ingot/steel = 8, /obj/item/ingot/bronze = 2, /obj/item/weaponcrafting/barrel = 1, /obj/item/weaponcrafting/receiver = 1, /obj/item/grown/log/tree/small = 1, /obj/item/weaponcrafting/stock = 1)
	result = list(/obj/item/gun/ballistic/arquebus)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 5 //le ultimate challenge

/datum/crafting_recipe/roguetown/engineering/handgonne
	name = "Handgonne"
	category = "Firearms"
	reqs = list(/obj/item/ingot/iron = 4, /obj/item/weaponcrafting/barrel = 1, /obj/item/weaponcrafting/receiver = 1, /obj/item/grown/log/tree/small = 1, /obj/item/weaponcrafting/stock = 1)
	result = list(/obj/item/gun/ballistic/handgonne)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3

/datum/crafting_recipe/roguetown/engineering/arquebuspistol
	name = "Arquebus pistol"
	category = "Firearms"
	reqs = list(/obj/item/ingot/steel = 4, /obj/item/ingot/bronze = 1 , /obj/item/weaponcrafting/barrel = 1, /obj/item/weaponcrafting/receiver = 1, /obj/item/grown/log/tree/small = 1)
	result = list(/obj/item/gun/ballistic/arquebus_pistol)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 4

/datum/crafting_recipe/roguetown/engineering/firearmramrod
	name = "replacement ramrod"
	category = "Firearms"
	reqs = list(/obj/item/ingot/iron = 1)
	result = list(/obj/item/ramrod)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3

//rotational and minecart parts
/datum/crafting_recipe/roguetown/engineering/shaft
	name = "wooden shaft(4x)"
	category = "Rotational"
	result = list(/obj/item/rotation_contraption/shaft,
				  /obj/item/rotation_contraption/shaft,
				  /obj/item/rotation_contraption/shaft,
				  /obj/item/rotation_contraption/shaft)
	reqs = list(/obj/item/grown/log/tree/small = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	tools = list(/obj/item/rogueweapon/huntingknife = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/engineering/stickshaft
	name = "wooden shaft"
	category = "Rotational"
	result = list(/obj/item/rotation_contraption/shaft)
	reqs = list(/obj/item/grown/log/tree/stick = 2)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	tools = list(/obj/item/rogueweapon/huntingknife = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/engineering/cog
	name = "wooden cogwheel(2x)"
	category = "Rotational"
	result = list(/obj/item/rotation_contraption/cog,
				  /obj/item/rotation_contraption/cog)
	reqs = list(/obj/item/grown/log/tree/small = 1, /obj/item/ingot/bronze = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	tools = list(/obj/item/rogueweapon/huntingknife = 1)
	craftdiff = 3


/datum/crafting_recipe/roguetown/engineering/waterwheel
	name = "wooden waterwheel"
	category = "Rotational"
	result = /obj/item/rotation_contraption/waterwheel
	reqs = list(/obj/item/grown/log/tree/small = 2)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	tools = list(/obj/item/rogueweapon/huntingknife = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/engineering/large_cog
	name = "large wooden cogwheel"
	category = "Rotational"
	result = /obj/item/rotation_contraption/large_cog
	reqs = list(/obj/item/grown/log/tree/small = 1, /obj/item/ingot/bronze = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	tools = list(/obj/item/rogueweapon/huntingknife = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/structure/gearbox
	name = "gearbox"
	category = "Rotational"
	result = /obj/item/rotation_contraption/horizontal
	reqs = list(/obj/item/grown/log/tree/small = 2, /obj/item/natural/stone = 2)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3

/datum/crafting_recipe/roguetown/structure/vertical_gearbox
	name = "vertical gearbox"
	category = "Rotational"
	result = /obj/item/rotation_contraption/vertical
	reqs = list(/obj/item/grown/log/tree/small = 2, /obj/item/natural/stone = 2)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3

/datum/crafting_recipe/roguetown/engineering/rails
	name = "minecart rails (5x)"
	category = "Minecarts"
	result = list(/obj/item/rotation_contraption/minecart_rail,
				  /obj/item/rotation_contraption/minecart_rail,
				  /obj/item/rotation_contraption/minecart_rail,
				  /obj/item/rotation_contraption/minecart_rail,
				  /obj/item/rotation_contraption/minecart_rail)
	reqs = list(/obj/item/grown/log/tree/small = 1, /obj/item/ingot/iron = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3

/datum/crafting_recipe/roguetown/engineering/railbreak
	name = "minecart rail break (5x)"
	category = "Minecarts"
	result = list(/obj/item/rotation_contraption/minecart_rail/railbreak,
				  /obj/item/rotation_contraption/minecart_rail/railbreak,
				  /obj/item/rotation_contraption/minecart_rail/railbreak,
				  /obj/item/rotation_contraption/minecart_rail/railbreak,
				  /obj/item/rotation_contraption/minecart_rail/railbreak)
	reqs = list(/obj/item/grown/log/tree/small = 1, /obj/item/ingot/iron = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3


/datum/crafting_recipe/roguetown/engineering/minecart
	name = "minecart"
	category = "Minecarts"
	result = /obj/structure/closet/crate/miningcar
	reqs = list(/obj/item/grown/log/tree/small = 1, /obj/item/ingot/iron = 1)
	verbage_simple = "engineer"
	verbage = "engineers"
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3
