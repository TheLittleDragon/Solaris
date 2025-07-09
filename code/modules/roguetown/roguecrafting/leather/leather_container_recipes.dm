/datum/crafting_recipe/roguetown/leather/container
	abstract_type = /datum/crafting_recipe/roguetown/leather/container
	category = "Container"

/datum/crafting_recipe/roguetown/leather/container/pouch
	name = "leather pouch (1 fibers, 1 leather)"
	result = list(/obj/item/storage/belt/rogue/pouch,
				/obj/item/storage/belt/rogue/pouch)
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	sellprice = 6
	craftdiff = 0

/datum/crafting_recipe/roguetown/leather/container/satchel
	name = "leather satchel (1 fibers, 2 leather)"
	result = /obj/item/storage/backpack/rogue/satchel
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	sellprice = 15

/datum/crafting_recipe/roguetown/leather/container/backpack
	name = "leather backpack (1 fibers, 2 leather)"
	result = /obj/item/storage/backpack/rogue/backpack
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	sellprice = 15

/datum/crafting_recipe/roguetown/leather/container/waterskin
	name = "waterskin (2 fibers, 1 leather)"
	result = /obj/item/reagent_containers/glass/bottle/waterskin
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 2)
	sellprice = 12

/datum/crafting_recipe/roguetown/leather/container/quiver
	name = "quiver (2 fibers, 2 leather)"
	result = /obj/item/quiver
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)
	sellprice = 30


/datum/crafting_recipe/roguetown/leather/container/ammopouch
	name = "shot pouch (4 leather, 3 fiber)"
	result = /obj/item/ammopouch
	reqs = list (/obj/item/natural/hide/cured = 4,
				/obj/item/natural/fibers = 3)

/datum/crafting_recipe/roguetown/leather/container/javelinbag
	name = "javelin bag (1 tallow, 1 rope)"
	result = /obj/item/quiver/javelin
	reqs = list(/obj/item/reagent_containers/food/snacks/tallow = 1,
				/obj/item/rope = 1)
	sellprice = 30

/datum/crafting_recipe/roguetown/leather/container/gwstrap
	name = "greatweapon strap (2 leather, 1 rope)"
	result = /obj/item/gwstrap
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/rope = 1)
	sellprice = 30

/datum/crafting_recipe/roguetown/leather/container/twstrap
	name = "bandolier (2 leather, 1 rope)"
	result = /obj/item/twstrap
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/rope = 1)
	sellprice = 30

/datum/crafting_recipe/roguetown/leather/container/belt
	name = "leather belt (2 fibers, 2 leather)"
	result = /obj/item/storage/belt/rogue/leather
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)
	sellprice = 30

/datum/crafting_recipe/roguetown/leather/container/belt/knifebelt
	name = "leather knifebelt (2 fibers, 2 leather)"
	result = /obj/item/storage/belt/rogue/leather/knifebelt
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 2)
	sellprice = 30
