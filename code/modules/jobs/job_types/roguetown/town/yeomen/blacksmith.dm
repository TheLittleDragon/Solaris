/datum/job/roguetown/blacksmith
	title = "Blacksmith"
	flag = BLACKSMITH
	department_flag = YEOMEN
	selection_color = JCOLOR_YEOMAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_ALL_KINDS

	tutorial = "You've studied for many decades under quite a number of master smiths. Whether it's cookware or tools of war, you're unmatched at the art of bending metal to your will."

	outfit = /datum/outfit/job/roguetown/blacksmith
	display_order = JDO_BLACKSMITH
	give_bank_account = 11
	min_pq = 0
	max_pq = null
	round_contrib_points = 3

/datum/job/roguetown/blacksmith/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name

/datum/outfit/job/roguetown/blacksmith/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/hatfur
	gloves = /obj/item/clothing/gloves/roguetown/blacksmith
	ADD_TRAIT(H, TRAIT_TRAINED_SMITH, TRAIT_GENERIC)
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 3, TRUE) // You do what you gotta do when times are tough.
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/smelting, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) //Have you TRIED to hit an anvil for hours?
		//removed the old trait related to be more inline with others
	if(should_wear_femme_clothes(H))
		pants = /obj/item/clothing/under/roguetown/trou
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		backr = /obj/item/storage/backpack/rogue/satchel
		backpack_contents = list(/obj/item/rogueweapon/hammer/iron = 1, /obj/item/rogueweapon/tongs = 1)
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		cloak = /obj/item/clothing/cloak/apron/blacksmith
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltr = /obj/item/roguekey/blacksmith
	else if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/trou
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		backr = /obj/item/storage/backpack/rogue/satchel
		backpack_contents = list(/obj/item/rogueweapon/hammer/iron = 1, /obj/item/rogueweapon/tongs = 1)
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltr = /obj/item/roguekey/blacksmith
		cloak = /obj/item/clothing/cloak/apron/blacksmith

	H.change_stat("strength", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
