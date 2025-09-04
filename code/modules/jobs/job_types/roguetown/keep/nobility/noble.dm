/// Generic noble role, for the time being - replacing prince/princess.
/datum/job/roguetown/nobleman
	title = "Nobleman"
	f_title = "Noblewoman"
	flag = NOBLEMAN
	department_flag = NOBLEMEN
	selection_color = JCOLOR_NOBLE
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = RACES_ALL_KINDS
	advclass_cat_rolls = list(CTAG_NOBLEMAN = 20)

	tutorial = "Rasurian politics demand the rotation of several noblemen throughout their counties and marches; and you are no exception - commanding respect and high praise whereever you go for your presence in the court alone. Sunmarch is no different, now that you've settled in..."

	display_order = JDO_NOBLEMAN
	give_bank_account = 30
	noble_income = 20
	min_pq = 1
	max_pq = null
	round_contrib_points = 3
	cmode_music = 'sound/music/combat_noble.ogg'

/datum/job/roguetown/nobleman/after_spawn(mob/living/L, mob/M, latejoin)
	. = ..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name
	if(ishuman(L))
		var/mob/living/carbon/human/Q = L
		Q.advsetup = 1
		Q.invisibility = INVISIBILITY_MAXIMUM
		Q.become_blind("advsetup")

/datum/advclass/nobleman/daring
	name = "Boastful Count"
	tutorial = "Long ago you were, allegedly, pivotal in a minor skirmish. You have since never let the rest of the court forget about your daring exploits and valiant first-hand command methods."
	outfit = /datum/outfit/job/roguetown/heir/daring
	category_tags = list(CTAG_NOBLEMAN)

/datum/outfit/job/roguetown/heir/daring/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/circlet
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	pants = /obj/item/clothing/under/roguetown/tights
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
	shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/sword/sabre
	beltr = /obj/item/storage/keyring/heir
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	backr = /obj/item/storage/backpack/rogue/satchel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 1)
		H.change_stat("constitution", 1)
		H.change_stat("speed", 1)
		H.change_stat("fortune", 1)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)

/datum/advclass/nobleman/bookworm
	name = "Scholar Baron"
	tutorial = "Instead of focusing on expanding your holdings you worked to expand your knowledge. Esoteric lore and trivia bubble from your mind freely, thanks to the ample free time afforded by your blood."
	outfit = /datum/outfit/job/roguetown/heir/bookworm
	category_tags = list(CTAG_NOBLEMAN)

/datum/outfit/job/roguetown/heir/bookworm/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCANE_T2, TRAIT_GENERIC)
	if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights/random
		armor = /obj/item/clothing/suit/roguetown/armor/longcoat
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/nobleman
	if(should_wear_femme_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/noblewoman
	head = /obj/item/clothing/head/roguetown/circlet
	belt = /obj/item/storage/belt/rogue/leather/cloth/lady
	beltr = /obj/item/storage/keyring/heir
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel/special
	backr = /obj/item/storage/backpack/rogue/satchel
	shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	mask = /obj/item/clothing/mask/rogue/spectacles
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	backpack_contents = list(/obj/item/book/spellbook)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind.adjust_spellpoints(6)
		ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_INTELLECTUAL, TRAIT_GENERIC)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/message)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/guided_bolt)
	H.change_stat("strength", -1)
	H.change_stat("intelligence", 3)
	H.change_stat("speed", 1)
	H.change_stat("constitution", -1)
	H.change_stat("fortune", 1)

/datum/advclass/nobleman/aristocrat
	name = "Voivode Aspirant"
	tutorial = "Your meagre holdings and adeptness at negotiation has managed you a seat at the sunmarch. It matters not where in Rasura you come from, what matters now is the start of your ambitions."
	outfit = /datum/outfit/job/roguetown/heir/aristocrat
	category_tags = list(CTAG_NOBLEMAN)

/datum/outfit/job/roguetown/heir/aristocrat/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC) // Pillow princesses (gender neutral)
	head = /obj/item/clothing/head/roguetown/circlet
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/keyring/heir
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backr = /obj/item/storage/backpack/rogue/satchel
	if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/nobleman
		belt = /obj/item/storage/belt/rogue/leather
		shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	if(should_wear_femme_clothes(H))
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		head = /obj/item/clothing/head/roguetown/hennin
		armor = /obj/item/clothing/suit/roguetown/armor/silkcoat
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/noblewoman
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/random
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.change_stat("perception", 2)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 2)
		H.change_stat("fortune", 1)
		H.change_stat("speed", 1)
