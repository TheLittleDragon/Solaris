GLOBAL_LIST_EMPTY(lord_titles)

/datum/job/roguetown/lord
	title = "Marquis"
	f_title = "Marquess"
	flag = LORD
	department_flag = NOBLEMEN
	selection_color = JCOLOR_NOBLE
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)

	spells = list(
		/obj/effect/proc_holder/spell/self/grant_title,
		/obj/effect/proc_holder/spell/self/convertrole/servant,
		/obj/effect/proc_holder/spell/self/convertrole/guard,
		/obj/effect/proc_holder/spell/self/convertrole/mercenary,
		/obj/effect/proc_holder/spell/self/convertrole/bog,
		/obj/effect/proc_holder/spell/self/grant_nobility,
	)
	outfit = /datum/outfit/job/roguetown/lord
	visuals_only_outfit = /datum/outfit/job/roguetown/lord/visuals

	display_order = JDO_LORD
	tutorial = "Rasura protects, Rasura provides. You are the ultimate authority in Sunmarch; and while you bear loyalty to those above your station in the heartland - you are the end-all for internal matters."
	whitelist_req = FALSE
	min_pq = 10
	max_pq = null
	round_contrib_points = 4
	virtue_restrictions = list(/datum/virtue/sucker/lesser_bloodsucker)
	give_bank_account = 1000
	required = TRUE
	cmode_music = 'sound/music/combat_noble.ogg'
	advclass_cat_rolls = list (CTAG_LORD = 20)

/datum/job/roguetown/exlord //just used to change the lords title
	title = "Marquis Emeritus"
	f_title = "Marquess Emeritus"
	flag = LORD
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	display_order = JDO_LORD
	give_bank_account = TRUE

/datum/outfit/job/roguetown/lord/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/crown/serpcrown
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	cloak = /obj/item/clothing/cloak/lordcloak
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	beltl = /obj/item/storage/keyring/lord
	l_hand = /obj/item/rogueweapon/lordscepter
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1)
	id = /obj/item/clothing/ring/active/nomag
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.change_stat("fortune", 5)
	if(should_wear_femme_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights/black
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/royal
		cloak = /obj/item/clothing/cloak/lordcloak/ladycloak
		wrists = /obj/item/clothing/wrists/roguetown/royalsleeves
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
	else if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights/black
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
		shoes = /obj/item/clothing/shoes/roguetown/boots
	if(H.wear_mask)
		if(istype(H.wear_mask, /obj/item/clothing/mask/rogue/eyepatch))
			qdel(H.wear_mask)
			mask = /obj/item/clothing/mask/rogue/lordmask
		if(istype(H.wear_mask, /obj/item/clothing/mask/rogue/eyepatch/left))
			qdel(H.wear_mask)
			mask = /obj/item/clothing/mask/rogue/lordmask/l

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
//	SSticker.rulermob = H

/datum/job/roguetown/lord/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	for(var/obj/structure/roguemachine/teleport_beacon/main/town_beacon in SSroguemachine.teleport_beacons)
		var/mob/living/carbon/human/H = L
		if(!(H.real_name in town_beacon.granted_list))
			town_beacon.granted_list += H.real_name
	if(L)
		SSticker.rulermob = L
		if(should_wear_femme_clothes(L))
			SSticker.rulertype = "Marquess"
		else
			SSticker.rulertype = "Marquis"
		to_chat(world, "<b><span class='notice'><span class='big'>[L.real_name] is [SSticker.rulertype] of Sunmarch.</span></span></b>")
		if(STATION_TIME_PASSED() <= 10 MINUTES) //Late to the party? Stuck with default colors, sorry!
			addtimer(CALLBACK(L, TYPE_PROC_REF(/mob, lord_color_choice)), 50)


	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/lord/classic
	name = "Traditional Lord"
	tutorial = "You are the end of the line when it comes to matters of state, you know how to handle a sword, but more than that you know how to handle matters of state above all (Default)"
	outfit = /datum/outfit/job/roguetown/lord/classic

	category_tags = list(CTAG_LORD)	

/datum/outfit/job/roguetown/lord/classic/pre_equip(mob/living/carbon/human/H)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE) // removed old  modifer for normalization purposes.
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("intelligence", 3)
		H.change_stat("endurance", 3)
		H.change_stat("speed", 1)
		H.change_stat("perception", 2)
		ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

/datum/advclass/lord/fisted
	name = "Iron Fisted Lord"
	tutorial = "Your journey to the top was far from easy or without strife. Every pit of power you've earned was carved out with your barehands. Litteraly."
	outfit = /datum/outfit/job/roguetown/lord/fisted
	
	category_tags = list(CTAG_LORD)

/datum/outfit/job/roguetown/lord/fisted/pre_equip(mob/living/carbon/human/H)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 5, TRUE) //beware the hidden SHANK
		H.change_stat("strength", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("endurance", 5)
		H.change_stat("speed", 2)
		ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)

/datum/advclass/lord/mage
	name = "Mage Overlord"
	tutorial = "Your knowledge of the arcane arts have assisted you with your ascent to the throne of the Sunmarch, while others toil on the ground you see it bent to your will. "
	outfit = /datum/outfit/job/roguetown/lord/mage
	
	category_tags = list(CTAG_LORD)

/datum/outfit/job/roguetown/lord/mage/pre_equip(mob/living/carbon/human/H)
	beltr = /obj/item/book/spellbook
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.change_stat("perception", 3)
		H.change_stat("intelligence", 5)
		H.change_stat("speed", 2)
		H.mind.adjust_spellpoints(15)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/message)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mindlink)
		ADD_TRAIT(H, TRAIT_ARCANE_T3, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_MAGIC_TUTOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_INTELLECTUAL, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SENTINELOFWITS, TRAIT_GENERIC)


/datum/outfit/job/roguetown/lord/visuals/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/crown/fakecrown //Prevents the crown of woe from happening again.

/obj/effect/proc_holder/spell/self/grant_title
	name = "Grant Title"
	desc = "Grant someone a title of honor... Or shame."
	overlay_state = "recruit_titlegrant"
	antimagic_allowed = TRUE
	recharge_time = 100
	/// Maximum range for title granting
	var/title_range = 3
	/// Maximum length for the title
	var/title_length = 42

/obj/effect/proc_holder/spell/self/grant_title/cast(list/targets, mob/user = usr)
	. = ..()
	var/granted_title = input(user, "What title do you wish to grant?", "[name]") as null|text
	granted_title = reject_bad_text(granted_title, title_length)
	if(!granted_title)
		return
	var/list/recruitment = list()
	for(var/mob/living/carbon/human/village_idiot in (get_hearers_in_view(title_range, user) - user))
		//not allowed
		if(!can_title(village_idiot))
			continue
		recruitment[village_idiot.name] = village_idiot
	if(!length(recruitment))
		to_chat(user, span_warning("There are no potential honoraries in range."))
		return
	var/inputty = input(user, "Select an honorary!", "[name]") as anything in recruitment
	if(inputty)
		var/mob/living/carbon/human/recruit = recruitment[inputty]
		if(!QDELETED(recruit) && (recruit in get_hearers_in_view(title_range, user)))
			INVOKE_ASYNC(src, PROC_REF(village_idiotify), recruit, user, granted_title)
		else
			to_chat(user, span_warning("Honorific failed!"))
	else
		to_chat(user, span_warning("Honorific cancelled."))

/obj/effect/proc_holder/spell/self/grant_title/proc/can_title(mob/living/carbon/human/recruit)
	//wtf
	if(QDELETED(recruit))
		return FALSE
	//need a mind
	if(!recruit.mind)
		return FALSE
	//need to see their damn face
	if(!recruit.get_face_name(null))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/grant_title/proc/village_idiotify(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter, granted_title)
	if(QDELETED(recruit) || QDELETED(recruiter) || !granted_title)
		return FALSE
	if(GLOB.lord_titles[recruit.real_name])
		recruiter.say("I HEREBY STRIP YOU, [uppertext(recruit.name)], OF THE TITLE OF [uppertext(GLOB.lord_titles[recruit.real_name])]!")
		GLOB.lord_titles -= recruit.real_name
		return FALSE
	recruiter.say("I HEREBY GRANT YOU, [uppertext(recruit.name)], THE TITLE OF [uppertext(granted_title)]!")
	GLOB.lord_titles[recruit.real_name] = granted_title
	return TRUE

/obj/effect/proc_holder/spell/self/grant_nobility
	name = "Grant Nobility"
	desc = "Make someone a noble, or strip them of their nobility."
	overlay_state = "recruit_titlegrant"
	antimagic_allowed = TRUE
	recharge_time = 100
	/// Maximum range for nobility granting
	var/nobility_range = 3

/obj/effect/proc_holder/spell/self/grant_nobility/cast(list/targets, mob/user = usr)
	. = ..()
	var/list/recruitment = list()
	for(var/mob/living/carbon/human/village_idiot in (get_hearers_in_view(nobility_range, user) - user))
		//not allowed
		if(!can_nobility(village_idiot))
			continue
		recruitment[village_idiot.name] = village_idiot
	if(!length(recruitment))
		to_chat(user, span_warning("There are no potential honoraries in range."))
		return
	var/inputty = input(user, "Select an honorary!", "[name]") as anything in recruitment
	if(inputty)
		var/mob/living/carbon/human/recruit = recruitment[inputty]
		if(!QDELETED(recruit) && (recruit in get_hearers_in_view(nobility_range, user)))
			INVOKE_ASYNC(src, PROC_REF(grant_nobility), recruit, user)
		else
			to_chat(user, span_warning("Honorific failed!"))
	else
		to_chat(user, span_warning("Honorific cancelled."))

/obj/effect/proc_holder/spell/self/grant_nobility/proc/can_nobility(mob/living/carbon/human/recruit)
	//wtf
	if(QDELETED(recruit))
		return FALSE
	//need a mind
	if(!recruit.mind)
		return FALSE
	//need to see their damn face
	if(!recruit.get_face_name(null))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/grant_nobility/proc/grant_nobility(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter)
	if(QDELETED(recruit) || QDELETED(recruiter))
		return FALSE
	if(HAS_TRAIT(recruit, TRAIT_NOBLE))
		if(!HAS_TRAIT(recruit,TRAIT_OUTLANDER))
			recruiter.say("I HEREBY STRIP YOU, [uppertext(recruit.name)], OF NOBILITY!!")
			REMOVE_TRAIT(recruit, TRAIT_NOBLE, TRAIT_GENERIC)
			REMOVE_TRAIT(recruit, TRAIT_NOBLE, TRAIT_VIRTUE)
			return FALSE
		else
			to_chat(recruiter, span_warning("Their nobility is not mine to strip!"))
			return FALSE
	recruiter.say("I HEREBY GRANT YOU, [uppertext(recruit.name)], NOBILITY!")
	ADD_TRAIT(recruit, TRAIT_NOBLE, TRAIT_GENERIC)
	REMOVE_TRAIT(recruit, TRAIT_OUTLANDER, ADVENTURER_TRAIT)
	return TRUE


/obj/effect/proc_holder/spell/self/convertrole/servant
	name = "Recruit Servant"
	new_role = "Servant"
	overlay_state = "recruit_servant"
	recruitment_faction = "Servants"
	recruitment_message = "Serve the crown, %RECRUIT!"
	accept_message = "FOR THE CROWN!"
	refuse_message = "I refuse."
	recharge_time = 100

/obj/effect/proc_holder/spell/self/convertrole/mercenary
	name = "Recruit Mercenary"
	new_role = "Mercenary"
	recruitment_faction = "MERCENARIES"
	recruitment_message = "Serve the Guild, %RECRUIT!"
	accept_message = "FOR THE GUILD!"
	refuse_message = "I refuse."
	recharge_time = 100

/obj/effect/proc_holder/spell/self/convertrole/bog
	name = "Recruit Warden"
	new_role = "Warden"
	recruitment_faction = "Warden"
	recruitment_message = "Serve the Wardens, %RECRUIT!"
	accept_message = "FOR THE GROVE!"
	refuse_message = "I refuse."
