/datum/job/roguetown/artificer
	title = "Artificer"
	flag = ARTIFICER
	department_flag = MAGES_UNIVERSITY
	selection_color = JCOLOR_MAGES
	faction = "Station"
	total_positions = 3
	spawn_positions = 2

	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)

	tutorial = "Hidden in the depths are ancient mechanical secrets, something your creed has taken it upon themselves to studying and understanding. \
				To some these mechanical wonders may seem like magic, but you know their inner workings as well as you do stone, down to the last cog."

	outfit = /datum/outfit/job/roguetown/artificer
	display_order = JDO_ARTIFICER
	give_bank_account = 8
	min_pq = 0
	max_pq = null
	round_contrib_points = 2

/datum/job/roguetown/artificer/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name

/datum/outfit/job/roguetown/artificer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 5, TRUE) // bring in line with the other yeomen
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 5, TRUE) // bring in line with the other yeomen
		H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE) //added to help with early round grind and so they can assist in making tools if needed.
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/smelting, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)

	head = /obj/item/clothing/head/roguetown/articap
	armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket
	cloak = /obj/item/clothing/cloak/apron/waist/brown
	gloves = /obj/item/clothing/gloves/roguetown/blacksmith
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/artificer
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/storage/keyring/artificer
	mask = /obj/item/clothing/mask/rogue/spectacles/golden
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(
						/obj/item/rogueweapon/hammer/claw = 1,
						/obj/item/lockpickring/mundane = 1,
						/obj/item/clothing/cloak/apron/blacksmith = 1,
						/obj/item/contraption/linker = 1
						)
	H.change_stat("strength", 1)
	H.change_stat("intelligence", 3) //Nerd
	H.change_stat("endurance", 2) //Innate mining should have some gains
	H.change_stat("constitution", 1)
	ADD_TRAIT(H, TRAIT_MAGIC_TALENT, TRAIT_GENERIC) // Arcane potential Trait, so they dont get to T2
	H.mind?.adjust_spellpoints(6)
