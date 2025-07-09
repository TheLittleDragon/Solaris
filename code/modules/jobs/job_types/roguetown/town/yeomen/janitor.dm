/datum/job/roguetown/janitor
	title = "Janitor"
	f_title = "Janitor"
	flag = JANITOR
	department_flag = YEOMEN
	selection_color = JCOLOR_YEOMAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation) // No soap no problem. Man's gotta clean...

	allowed_races = RACES_ALL_KINDS
	tutorial = "Yours is a creed most would never imagine to take - laid logs and fundation, cobble and wall. Tasked to maintain and clean the Marquis' township, \
				you now serve as a trusted handyman around town; wherever all or none would dare tread."

	min_pq = -5
	max_pq = null

	outfit = /datum/outfit/job/roguetown/janitor
	display_order = JDO_JANITOR
	give_bank_account = 16
	round_contrib_points = 3 // You never realize how important someone keeping the place from looking like a shithole is until they're gone.

/datum/job/roguetown/janitor/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name

/*
	Philosphy: Merged version of Legendary Carpenter + Legendary Mason, forgoing combat-related stats asides from axes + traps - favoring better stats
	You are effectively playing the equivalent of a combined janitor + drone in normal SS13, except you can actually talk and interact and not be a player reference
*/
/datum/outfit/job/roguetown/janitor/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/smelting, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/roguekey/janitor
	backr = /obj/item/storage/backpack/rogue/satchel
	cloak = /obj/item/clothing/cloak/apron/waist
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	if(should_wear_masc_clothes(H))
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		pants = /obj/item/clothing/under/roguetown/tights/black
	else if(should_wear_femme_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/shirt/rags
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("intelligence", 1)
	H.change_stat("speed", 1) //5 points (weighted) 
	ADD_TRAIT(H, TRAIT_CICERONE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MAGIC_TALENT, TRAIT_GENERIC) // Arcane potential Trait, so they dont get to T2
	H.mind?.adjust_spellpoints(6)
