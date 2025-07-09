/datum/job/roguetown/bogguardsman
	title = "Warden"
	flag = BOGGUARD
	department_flag = GARRISON
	selection_color = JCOLOR_SOLDIER
	faction = "Station"
	total_positions = 6
	spawn_positions = 4
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Forest protectors who serve the crown protecting the shifting forests south of Sunmarch, you volunteered up with the wardens--a group of ranger types who keep a vigil over the untamed wilds."
	display_order = JDO_BOGGUARD
	whitelist_req = TRUE
	outfit = /datum/outfit/job/roguetown/bogguardsman
	advclass_cat_rolls = list (CTAG_WARDEN = 20)
	give_bank_account = 16
	min_pq = 4
	max_pq = null
	round_contrib_points = 2
	virtue_restrictions = list(/datum/virtue/sucker/lesser_bloodsucker)
	cmode_music = 'sound/music/combat_bog.ogg'


/datum/job/roguetown/bogguardsman/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
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

//in general, every warden subclass needs at least the following: 4 wrestling, 2 unarmed, 3 axe, 4 tracking, 3 athletics, 4 climbing, 2 Bows, and 3 swimming. Additionally, 2 farming, 2 tanning, 2 crafting, and 1 medicine to assist in their self-sufficiency. Their armor can be built themselves.

/datum/advclass/bogguardsman/forestguard
	name = "Forest Guard"
	tutorial = "The Forest Guard’s number come from the great forester houses all across Rasura. Deep in woods across the land and beyond generations have trained in the thankless art of policing woods from brigands and monsters. Footmen for a different age where the forests bend, evolve and grow. Yours is the hand that will help many an adventurer to their feet."
	outfit = /datum/outfit/job/roguetown/bogguardsman/forestguard
	category_tags = list(CTAG_WARDEN)


/datum/outfit/job/roguetown/bogguardsman/forestguard/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = /obj/item/clothing/head/roguetown/helmet/bascinet/antler
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/warden
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/woad
	neck = /obj/item/clothing/neck/roguetown/coif
	gloves = /obj/item/clothing/gloves/roguetown/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	pants = /obj/item/clothing/under/roguetown/trou/leather
	id = /obj/item/scomstone/bad/garrison
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	beltl = /obj/item/storage/keyring/guard
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut/wardenpick
	backr = /obj/item/storage/backpack/rogue/satchel
	r_hand = /obj/item/rogueweapon/spear
	backpack_contents = list(/obj/item/rogueweapon/surgery/cautery/purging, /obj/item/needle = 1, /obj/item/flashlight/flare/torch/lantern = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE) //Melee subclass and also garrison cannot have <4 wrestling/unarmed or we default to lethality
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE) //Axes are a part of the Warden identity. This is the melee suclass. It should have a focus on the axe.
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) //Traversal is a necessary part of the warden kit 
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE) //Wardens NEEED tracking to function in finding bodies and outlaws alike 
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 2)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
		H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHSIGHT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_WOODSMAN, TRAIT_GENERIC) // Longstrider where active, +3 per, +1 speed
	ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)

/datum/advclass/bogguardsman/stalker
	name = "Stalker"
	tutorial = "Fleet of foot wielding arrow and dirk, the Stalkers are the Warden’s scouts and farseers. You were once a wanderer and unknown. Now you are found. The Warden’s give you a place to hone your skills of stealthcraft and ranging on enemies far more respectable to fight than most. Your feet guide the paths of those who have wandered too far into the wylds. "
	outfit = /datum/outfit/job/roguetown/bogguardsman/stalker
	category_tags = list(CTAG_WARDEN)


/datum/outfit/job/roguetown/bogguardsman/stalker/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/warden
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/woad
	neck = /obj/item/clothing/neck/roguetown/coif
	gloves = /obj/item/clothing/gloves/roguetown/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
	pants = /obj/item/clothing/under/roguetown/trou/leather
	id = /obj/item/scomstone/bad/garrison
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	beltl = /obj/item/storage/keyring/guard
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/quiver/arrows
	backr = /obj/item/rogueweapon/stoneaxe/woodcut/wardenpick
	backl = /obj/item/storage/backpack/rogue/satchel
	r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	backpack_contents = list(/obj/item/rogueweapon/surgery/cautery/purging, /obj/item/needle = 1, /obj/item/flashlight/flare/torch/lantern = 1, /obj/item/rogueweapon/huntingknife/idagger/navaja = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE) //Garrison cannot have <4 wrestling/unarmed or we default to lethality. allowing 3 at least to push the ranged identity.
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) //Traversal is a necessary part of the warden kit 
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE) //Wardens NEEED tracking to function in finding bodies and outlaws alike 
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.change_stat("perception", 2)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 2)
		H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHSIGHT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_WOODSMAN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)

/datum/advclass/bogguardsman/speaker
	name = "Woad Speaker"
	tutorial = "You've had the power to truly commune with the natural world from a young age. Caught between worlds, your esoteric methods rarely escape scrutiny. Guide the lost and damned alike to salvation. They are Woad Speakers. They speak for the trees."
	outfit = /datum/outfit/job/roguetown/bogguardsman/speaker
	category_tags = list(CTAG_WARDEN)


/datum/outfit/job/roguetown/bogguardsman/speaker/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = /obj/item/clothing/head/roguetown/helmet/leather/saiga
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/warden
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/woad
	neck = /obj/item/clothing/neck/roguetown/coif
	gloves = /obj/item/clothing/gloves/roguetown/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	pants = /obj/item/clothing/under/roguetown/trou/leather
	id = /obj/item/scomstone/bad/garrison
	shoes = /obj/item/clothing/shoes/roguetown/sandals
	beltl = /obj/item/storage/keyring/guard
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut/wardenpick
	backl = /obj/item/storage/backpack/rogue/satchel
	l_hand = /obj/item/rogueweapon/shield/wood
	backpack_contents = list(/obj/item/rogueweapon/surgery/cautery/purging = 1, /obj/item/flashlight/flare/torch/lantern = 1, /obj/item/needle = 1, /obj/item/ritechalk = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE) //Garrison cannot have <4 wrestling or we default to lethality
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) //Traversal is a necessary part of the warden kit
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)  
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE) //Wardens NEEED tracking to function in finding bodies and outlaws alike 
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 2)
		H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_WOODSMAN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHSIGHT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC) //needs ritualist if it's gonna get ritechalk
	ADD_TRAIT(H, TRAIT_ARCANE_T1, TRAIT_GENERIC)
	H.mind.adjust_spellpoints(6)

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/guidance)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/stave_the_dying)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/acidsplash)

//Warden Squire
/datum/advclass/bogguardsman/sproutling
	name = "Sproutling"
	tutorial = "By choice, exile, or just happenstance, you have become an apprentice to the Wardens. While you have not yet earned your woadcloak, you have undergone the old rites to hear the wilds's murmurs. Follow your fellow Wardens into the woad and beyond."
	outfit = /datum/outfit/job/roguetown/bogguardsman/sproutling
	category_tags = list(CTAG_WARDEN)


/datum/outfit/job/roguetown/bogguardsman/sproutling/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/warden
	cloak = /obj/item/clothing/cloak/wardencloak //no blue cloak for the apprentice, you gotta earn it.
	neck = /obj/item/clothing/neck/roguetown/coif
	gloves = /obj/item/clothing/gloves/roguetown/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	pants = /obj/item/clothing/under/roguetown/trou/leather
	id = /obj/item/scomstone/bad/garrison
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	beltl = /obj/item/storage/keyring/guard
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/hammer
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/stoneaxe/woodcut/wardenpick
	r_hand = /obj/item/rogueweapon/spear
	backpack_contents = list(/obj/item/rogueweapon/surgery/cautery/purging, /obj/item/flashlight/flare/torch/lantern = 1, /obj/item/needle = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE) //Melee subclass and also garrison cannot have <4 wrestling/unarmed or we default to lethality, in this case it's a squire so 2.
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE) //Axes are a part of the Warden identity.
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE) //Traversal is a necessary part of the warden kit 
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE) //Wardens NEEED tracking to function in finding bodies and outlaws alike 
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 1)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
		H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHSIGHT, TRAIT_GENERIC)	
	ADD_TRAIT(H, TRAIT_SQUIRE_REPAIR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_WOODSMAN, TRAIT_GENERIC) // Longstrider where active, +3 per, +1 speed
	ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)
