/datum/job/roguetown/head_mage
	title = "Head Mage"
	flag = HEAD_MAGE
	department_flag = MAGES_UNIVERSITY
	selection_color = JCOLOR_MAGES
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation)

	tutorial = "You are the highest-ranking member of the local branch of the Mage's University, having honed your skills for years upon years \
				in every field of study that even berefts Kasmidian's realm - and yet in spite of your stature, in spite of the micromanaging and \
				consulting with your understudy in the Court Magician - you have so much more to learn, still."

	outfit = /datum/outfit/job/roguetown/head_mage
	display_order = JDO_HEAD_MAGE
	give_bank_account = 47
	min_pq = 4 // Head of the damn "department", High potential for abuse, lovepotion/killersice/greater fireball is not for the faint of heart
	max_pq = null
	round_contrib_points = 3
	cmode_music = 'sound/music/combat_bandit_mage.ogg'

/datum/job/roguetown/head_mage/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name

/datum/outfit/job/roguetown/head_mage/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/talkstone
	cloak = /obj/item/clothing/cloak/black_cloak
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltr = /obj/item/storage/keyring/head_mage
	beltl = /obj/item/book/spellbook
	r_hand = /obj/item/rogueweapon/woodstaff/riddle_of_steel/head_mage
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/rich)
	ADD_TRAIT(H, TRAIT_SEEPRICES, "[type]")
	ADD_TRAIT(H, TRAIT_INTELLECTUAL, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCANE_T4, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MAGIC_TUTOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCANE_GATES, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("constitution", -1)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 4)
		H.mind.adjust_spellpoints(33)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
