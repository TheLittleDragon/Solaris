/datum/job/roguetown/magician
	title = "Court Magician"
	flag = WIZARD
	department_flag = COURTIERS
	selection_color = JCOLOR_COURTIER
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	display_order = JDO_MAGICIAN
	tutorial = "Your creed is one dedicated to the conquering of the arcane arts and the constant thrill of knowledge. \
		Hand-picked from your peers in the University, you were made comfortable; given lavish accomodations and luxurious study. \
		In return, you have proven time and time again as justicar and trusted advisor to the court of Sunmarch - and balance the \
		court's will in the favor of the University as you do so."
	outfit = /datum/outfit/job/roguetown/magician
	whitelist_req = TRUE
	give_bank_account = 23
	min_pq = 3 // Less potential for abuse than their head mage counterpart, but still kinda big
	max_pq = null
	round_contrib_points = 2
	cmode_music = 'sound/music/combat_bandit_mage.ogg'

/datum/job/roguetown/magician/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name

/datum/outfit/job/roguetown/magician/pre_equip(mob/living/carbon/human/H)
	..()
	cloak = /obj/item/clothing/cloak/half
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/white
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/mage
	beltl = /obj/item/book/spellbook
	id = /obj/item/scomstone/bad
	r_hand = /obj/item/rogueweapon/woodstaff/diamond
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/reagent_containers/glass/bottle/rogue/poison,/obj/item/reagent_containers/glass/bottle/rogue/healthpot, /obj/item/storage/belt/rogue/pouch/coins/mid)
	ADD_TRAIT(H, TRAIT_SEEPRICES, "[type]")
	ADD_TRAIT(H, TRAIT_ARCANE_T3, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MAGIC_TUTOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INTELLECTUAL, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("constitution", -1)
		H.change_stat("perception", 1)
		H.change_stat("endurance", 1)
		H.change_stat("intelligence", 4)
		H.mind.adjust_spellpoints(15)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/message)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mindlink)
		ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			if(ishumannorthern(H))
				belt = /obj/item/storage/belt/rogue/leather/plaquegold
				cloak = null
				head = /obj/item/clothing/head/roguetown/wizhat
				armor = /obj/item/clothing/suit/roguetown/shirt/robe/wizard

