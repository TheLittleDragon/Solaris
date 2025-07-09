/datum/job/roguetown/wapprentice
	title = "Apprentice Magician"
	flag = MAGEAPPRENTICE
	department_flag = MAGES_UNIVERSITY
	selection_color = JCOLOR_MAGES
	faction = "Station"
	total_positions = 3
	spawn_positions = 4

	allowed_races = RACES_ALL_KINDS
	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	advclass_cat_rolls = list(CTAG_WAPPRENTICE = 20)

	tutorial = "You're a learning mage in the Mage's University, doing your best to practice and learn the craft of \
				Kasmidian's threads upon earth. Your own has been difficult - uncertain path and unclear future throughout, \
				yet you press through. You will be worthy - one day of days."

	outfit = /datum/outfit/job/roguetown/wapprentice

	display_order = JDO_MAGEAPPRENTICE
	give_bank_account = TRUE

	min_pq = 0
	max_pq = null
	round_contrib_points = 2
	cmode_music = 'sound/music/combat_bandit_mage.ogg'

/datum/outfit/job/roguetown/wapprentice
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights/random
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/mages_university
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/woodstaff/amethyst
	shoes = /obj/item/clothing/shoes/roguetown/gladiator // FANCY SANDALS
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor

/datum/job/roguetown/wapprentice/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		
/datum/advclass/wapprentice/associate
	name = "Associtate Magician"
	tutorial = "You've studied hard and found some semblance of path in Kasmidian's realm. The years have been \
				hard, they've been gruelling - but you've managed well enough. All the hours studying late into \
				the night have cut at you, though, and physical tasks seem all-the-harder than they used to..."
	outfit = /datum/outfit/job/roguetown/wapprentice/associate
		
	category_tags = list(CTAG_WAPPRENTICE)
	
/datum/outfit/job/roguetown/wapprentice/associate/pre_equip(mob/living/carbon/human/H)
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
	head = /obj/item/clothing/head/roguetown/roguehood/mage
	backpack_contents = list(/obj/item/roguegem/amethyst = 1, /obj/item/spellbook_unfinished/pre_arcane = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind.adjust_spellpoints(21)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
		ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_ARCANE_T3, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_MAGIC_TUTOR, TRAIT_GENERIC)
		H.change_stat("intelligence", 3)
		H.change_stat("speed", 1)
		H.change_stat("perception", 1)
		
/datum/advclass/wapprentice/apprentice
	name = "Apprentice Magician"
	tutorial = /datum/job/roguetown/wapprentice::tutorial
	outfit = /datum/outfit/job/roguetown/wapprentice/apprentice
	
	category_tags = list(CTAG_WAPPRENTICE)
	
/datum/outfit/job/roguetown/wapprentice/apprentice/pre_equip(mob/living/carbon/human/H)
	backpack_contents = list(/obj/item/roguegem/amethyst = 1, /obj/item/natural/hide = 1, /obj/item/paper/scroll = 6)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_spellpoints(12)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/create_campfire)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/guided_bolt)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/message)
		H.mind.AddSpell(/obj/effect/proc_holder/spell/self/light)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/featherfall)
		ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_ARCANE_T2, TRAIT_GENERIC)
		H.change_stat("intelligence", 3)
		H.change_stat("speed", 1)
		H.change_stat("fortune", 1)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
