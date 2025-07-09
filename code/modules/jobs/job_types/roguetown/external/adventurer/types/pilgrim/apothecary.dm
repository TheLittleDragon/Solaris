/datum/advclass/apothecary
	name = "Apothecary"
	tutorial = "While alchemy was an ostracized art in the Dusk Era - the founding of the Mage's University led to legitimization; proliferation. \
				Ultimately, apothecaries have carved their place into Rasura at large, whether the superstitious mind you or not - a detail that the \
				more \"good humored\" mages alongside you filtered into knowledge to feed your way in jest - however useful they may have incidentally \
				become in the process..."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/apothecary
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	traits_applied = list(TRAIT_RITUALIST, TRAIT_DEATHSIGHT, TRAIT_ARCANE_T1)
	cmode_music = 'sound/music/combat_bog.ogg'

/datum/outfit/job/roguetown/adventurer/apothecary/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/apothecaryhat
	mask = /obj/item/clothing/head/roguetown/roguehood/black
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/phys
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	belt = /obj/item/storage/belt/rogue/leather/black
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
						/obj/item/reagent_containers/glass/mortar = 1,
						/obj/item/pestle = 1,
						/obj/item/ritechalk = 1,
						/obj/item/candle/yellow = 2,
						)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/shapeshift/crow)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/guidance)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/aerosolize)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/stave_the_dying)
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/armor/corset
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut
		pants = /obj/item/clothing/under/roguetown/skirt/red
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.mind.adjust_spellpoints(6)
		H.change_stat("intelligence", 3)
		H.change_stat("speed", 2)
		H.change_stat("fortune", 1)
		if(H.age == AGE_OLD)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("fortune", 1)

