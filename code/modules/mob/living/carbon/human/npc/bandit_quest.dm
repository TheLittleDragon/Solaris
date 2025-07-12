GLOBAL_LIST_INIT(banditquest_aggro, world.file2list("strings/rt/searaideraggrolines.txt"))

/mob/living/carbon/human/species/human/bandit_quest
	aggressive=1
	mode = NPC_AI_IDLE
	faction = list("quest_ target")
	ambushable = FALSE
	dodgetime = 30
	flee_in_pain = TRUE
	possible_rmb_intents = list()
	var/is_silent = FALSE /// Determines whether or not we will scream our funny lines at people.

/mob/living/carbon/human/species/human/bandit_quest/ambush
	aggressive=1
	wander = TRUE

/mob/living/carbon/human/species/human/bandit_quest/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(!is_silent && target != newtarg)
			say(pick(GLOB.banditquest_aggro))
			linepoint(target)

/mob/living/carbon/human/species/human/bandit_quest/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()

/mob/living/carbon/human/species/human/bandit_quest/Initialize(mob/living/L)
	. = ..()
	var/list/allowed_species = list(/datum/species/human/northern,/datum/species/elf/wood,/datum/species/human/halfelf,/datum/species/dwarf/gnome,/datum/species/dwarf/mountain)
	var/datum/species/chosen_species
	chosen_species = pick(allowed_species)
	set_species(chosen_species)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)
	is_silent = TRUE

/mob/living/carbon/human/species/human/bandit_quest/after_creation()
	..()
	job = "Pillager"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	real_name = pick("Thug","Outlaw","Brigand","Blackguard","Knave","Wretch")
	gender = pick(MALE, FEMALE)
	var/hairf = pick(list(/datum/sprite_accessory/hair/head/himecut, 
						/datum/sprite_accessory/hair/head/countryponytailalt, 
						/datum/sprite_accessory/hair/head/stacy, 
						/datum/sprite_accessory/hair/head/kusanagi_alt))
	var/hairm = pick(list(/datum/sprite_accessory/hair/head/ponytailwitcher, 
						/datum/sprite_accessory/hair/head/dave, 
						/datum/sprite_accessory/hair/head/emo, 
						/datum/sprite_accessory/hair/head/sabitsuki))
	var/hairc =  pick(list("#ad1818","#a39c3d","#7a440f","#3f2516","#ab5d0f"))
	var/eyec = pick(list("#29b136","#3d51be","#8b6215","#72863c"))
	var/obj/item/organ/eyes/mob_eyes
	var/datum/bodypart_feature/hair/head/new_hair = new()
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	mob_eyes = src.getorgan(ORGAN_SLOT_EYES)
	if(mob_eyes)
		mob_eyes.eye_color = (eyec)
	if(gender == FEMALE)
		new_hair.set_accessory_type(hairf, hairc, src)
	else
		new_hair.set_accessory_type(hairm, hairc, src)

	head.add_bodypart_feature(new_hair)

	if(prob(70))
		equipOutfit(new /datum/outfit/job/roguetown/human/species/human/bandit_quest)
	else
		equipOutfit(new /datum/outfit/job/roguetown/human/species/human/bandit_quest_heavy)

	update_hair()
	update_body()


/mob/living/carbon/human/species/human/bandit_quest/npc_idle()
	if(m_intent == MOVE_INTENT_SNEAK)
		return
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc,pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src,pick(GLOB.cardinals)))
	if(!wander && prob(10))
		face_atom(get_step(src,pick(GLOB.cardinals)))

/mob/living/carbon/human/species/human/bandit_quest/handle_combat()
	if(mode == NPC_AI_HUNT)
		if(prob(20))
			emote(pick("warcry","rage"))
			if(prob(10))
				say(pick("For Glory!","Just you wait!","Die!","Die already!","Can't wait to see what you have!","I live for this part!"))
				linepoint(target)
	if(mode == NPC_AI_FLEE)
		if(prob(20))
			emote(pick("whimper","scream"))
			if(prob(10))
				say(pick("I can't die here!","Fuck this!","This ain't worth it!","Yikes!","Blasted heroes!"))
	. = ..()

/datum/outfit/job/roguetown/human/species/human/bandit_quest/pre_equip(mob/living/carbon/human/H)
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	if(H.gender == FEMALE && prob(22)) //if the bikini ever updates to works on men, remove the gender check only
		armor = /obj/item/clothing/suit/roguetown/armor/leather/bikini
	pants = /obj/item/clothing/under/roguetown/trou/leather
	cloak = pick(list(/obj/item/clothing/cloak/raincloak,/obj/item/clothing/cloak/raincloak/red,/obj/item/clothing/cloak/raincloak/green))
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(20))
		wrists = /obj/item/clothing/wrists/roguetown/bracers
	mask = /obj/item/clothing/mask/rogue/facemask
	if(prob(50))
		mask = /obj/item/clothing/mask/rogue/ragmask/black
	if(prob(40))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	neck = /obj/item/clothing/neck/roguetown/leather
	if(prob(50))
		neck = /obj/item/clothing/neck/roguetown/gorget
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	shoes = /obj/item/clothing/shoes/roguetown/boots
	H.STASTR = rand(10,12)
	H.STASPD = rand(10,12)
	H.STACON = rand(12,14)
	H.STAEND = rand(12,14)
	H.STAPER = rand(10,12)
	H.STAINT = rand(8,10) //dump stat
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword/iron
		l_hand = /obj/item/rogueweapon/shield/wood
	else
		r_hand = /obj/item/rogueweapon/huntingknife/idagger

/datum/outfit/job/roguetown/human/species/human/bandit_quest_heavy/pre_equip(mob/living/carbon/human/H)
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	if(H.gender == FEMALE && prob(22)) //if the bikini ever updates to works on men, remove the gender check only
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/bikini
	pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	cloak = pick(list(/obj/item/clothing/cloak/raincloak,/obj/item/clothing/cloak/raincloak/red,/obj/item/clothing/cloak/raincloak/green))
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	mask = /obj/item/clothing/mask/rogue/facemask
	if(prob(50))
		mask = /obj/item/clothing/mask/rogue/ragmask/black
	if(prob(60))
		head = /obj/item/clothing/head/roguetown/helmet/skullcap
	neck = /obj/item/clothing/neck/roguetown/leather
	if(prob(50))
		neck = /obj/item/clothing/neck/roguetown/gorget
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	shoes = /obj/item/clothing/shoes/roguetown/boots
	H.STASTR = rand(11,13)
	H.STASPD = rand(10,12)
	H.STACON = rand(12,14)
	H.STAEND = rand(12,14)
	H.STAPER = rand(10,12)
	H.STAINT = rand(8,10) //dump stat
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword/iron
		l_hand = /obj/item/rogueweapon/shield/wood
	else
		r_hand = /obj/item/rogueweapon/halberd/bardiche


	
	

