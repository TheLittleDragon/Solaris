/datum/virtue/combat/magical_potential
	name = "Arcane Potential"
	desc = "Either by natural talent or limited formal training, I posess a modicum sum of Arcane knowledge, which aids me on my day to day chores."
	custom_text = "+1 to Arcane, Up to Legendary. if they don't have any Arcane prior, they get 6 spell points and access to Tier 1 spells. If they do, they get +1 Intelligence. "
	added_skills = list(list(/datum/skill/magic/arcane, 1, 6))

/datum/virtue/combat/magical_potential/apply_to_human(mob/living/carbon/human/recipient)
	if (!recipient.mind?.has_spell(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation))
		recipient.mind?.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	if (!is_arcane(recipient)) // we can do this because apply_to is always called first
		ADD_TRAIT(recipient, TRAIT_MAGIC_TALENT, TRAIT_GENERIC)
		recipient.mind?.adjust_spellpoints(6)
	else
		recipient.change_stat("intelligence", 1)

/datum/virtue/combat/devotee
	name = "Devotee"
	desc = "Though not officially of the Church, my relationship with my chosen Patron is strong enough to grant me the most minor of their blessings. I've also kept a psycross of my deity."
	custom_text = "Combat classes receive a weaker version of this virtue -- they do not get the first tier of miracles."
	added_skills = list(list(/datum/skill/magic/holy, 1, 6))

/datum/virtue/combat/devotee/apply_to_human(mob/living/carbon/human/recipient)
	if (!recipient.mind)
		return
	if (!is_divine(recipient))
		// only give non-devotionists orison... and t0 for some reason (this is probably a bad idea)
		var/datum/devotion/new_faith = new /datum/devotion(recipient, recipient.patron)
		var/datum/patron/our_patron = new_faith.patron
		new_faith.max_devotion = CLERIC_REQ_1 - 20
		new_faith.max_progression = CLERIC_REQ_1 - 20
		recipient.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
		recipient.mind?.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/orison)
		if (!is_combat_class(recipient))
			recipient.mind?.AddSpell(new our_patron.t0)
	else
		// for devotionists, bump up their maximum 1 tier and give them a TINY amount of passive devo gain
		var/datum/devotion/our_faith = recipient.devotion
		our_faith.passive_devotion_gain += 0.15
		switch (our_faith.max_devotion)
			if (CLERIC_REQ_0)
				our_faith.max_devotion = CLERIC_REQ_1
			if (CLERIC_REQ_1)
				our_faith.max_devotion = CLERIC_REQ_2
			if (CLERIC_REQ_2)
				our_faith.max_devotion = CLERIC_REQ_3
			if (CLERIC_REQ_3)
				our_faith.max_devotion = CLERIC_REQ_4
		switch (our_faith.max_progression)
			if (CLERIC_REQ_0)
				our_faith.max_progression = CLERIC_REQ_1
			if (CLERIC_REQ_1)
				our_faith.max_progression = CLERIC_REQ_2
			if (CLERIC_REQ_2)
				our_faith.max_progression = CLERIC_REQ_3
			if (CLERIC_REQ_3)
				our_faith.max_progression = CLERIC_REQ_4
			if (CLERIC_REQ_4)
				our_faith.passive_devotion_gain += 1
	switch(recipient.patron?.type)
		if(/datum/patron/lording_three/aeternus)
			recipient.mind?.special_items["Aeternus Psycross"] = /obj/item/clothing/neck/roguetown/psicross/aeternus
		if(/datum/patron/peoples_pantheon/cinella)
			recipient.mind?.special_items["Cinella Psycross"] = /obj/item/clothing/neck/roguetown/psicross/cinella
		if(/datum/patron/three_sisters/tamari)
			recipient.mind?.special_items["Tamari Psycross"] = /obj/item/clothing/neck/roguetown/psicross/tamari
		if(/datum/patron/lording_three/tsoridys)
			recipient.mind?.special_items["Tsoridys Psycross"] = /obj/item/clothing/neck/roguetown/psicross/tsoridys
		if(/datum/patron/peoples_pantheon/varielle) 
			recipient.mind?.special_items["Varielle Psycross"] = /obj/item/clothing/neck/roguetown/psicross/varielle
		if(/datum/patron/lording_three/zira)
			recipient.mind?.special_items["Zira Psycross"] = /obj/item/clothing/neck/roguetown/psicross/zira
		if(/datum/patron/peoples_pantheon/carthus)
			recipient.mind?.special_items["Carthus Psycross"] =/obj/item/clothing/neck/roguetown/psicross/carthus
		if(/datum/patron/three_sisters/nunos)
			recipient.mind?.special_items["Nunos Psycross"] = /obj/item/clothing/neck/roguetown/psicross/nunos

/datum/virtue/combat/duelist
	name = "Duelist Apprentice"
	desc = "I have trained under a duelist of considerable skill, and always have my trusty rapier close at hand."
	custom_text = "+1 to Swords and Knives, Up to Journeyman, Minimum Apprentice."
	added_stashed_items = list("Rapier" = /obj/item/rogueweapon/sword/rapier)

/datum/virtue/combat/duelist/apply_to_human(mob/living/carbon/human/recipient)
	if(recipient.mind?.get_skill_level(/datum/skill/combat/swords) < SKILL_LEVEL_APPRENTICE)
		recipient.mind?.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_APPRENTICE, silent = TRUE)
	else
		added_skills = list(list(/datum/skill/combat/swords, 1, 3))
	if(recipient.mind?.get_skill_level(/datum/skill/combat/knives) < SKILL_LEVEL_APPRENTICE)
		recipient.mind?.adjust_skillrank_up_to(/datum/skill/combat/knives, SKILL_LEVEL_APPRENTICE, silent = TRUE)
	else	
		added_skills = list(list(/datum/skill/combat/knives, 1, 3))

/datum/virtue/combat/executioner
	name = "Executioner Apprentice"
	desc = "I have trained under a skilled executioner, and always have my trusty exeuctioner's axe close at hand."
	custom_text = "+1 to Axes and Whips/Flails, Up to Journeyman, Minimum Apprentice."
	added_stashed_items = list("Battleaxe" = /obj/item/rogueweapon/stoneaxe/battle)

/datum/virtue/combat/executioner/apply_to_human(mob/living/carbon/human/recipient)
	if(recipient.mind?.get_skill_level(/datum/skill/combat/whipsflails) < SKILL_LEVEL_APPRENTICE)
		recipient.mind?.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, SKILL_LEVEL_APPRENTICE, silent = TRUE)
	else
		added_skills = list(list(/datum/skill/combat/whipsflails, 1, 3))
	if(recipient.mind?.get_skill_level(/datum/skill/combat/axes) < SKILL_LEVEL_APPRENTICE)
		recipient.mind?.adjust_skillrank_up_to(/datum/skill/combat/axes, SKILL_LEVEL_APPRENTICE, silent = TRUE)
	else
		added_skills = list(list(/datum/skill/combat/axes, 1, 3))

/datum/virtue/combat/militia
	name = "Militiaman Apprentice"
	desc = "I have trained under a skilled militiaman, and always have my trusty billhook close at hand."
	custom_text = "+1 to Maces and Polearms, Up to Journeyman, Minimum Apprentice."
	added_stashed_items = list("Billhook" = /obj/item/rogueweapon/spear/billhook)

/datum/virtue/combat/militia/apply_to_human(mob/living/carbon/human/recipient)
	if(recipient.mind?.get_skill_level(/datum/skill/combat/polearms) < SKILL_LEVEL_APPRENTICE)
		recipient.mind?.adjust_skillrank_up_to(/datum/skill/combat/polearms, SKILL_LEVEL_APPRENTICE, silent = TRUE)
	else
		added_skills = list(list(/datum/skill/combat/polearms, 1, 3))
	if(recipient.mind?.get_skill_level(/datum/skill/combat/maces) < SKILL_LEVEL_APPRENTICE)
		recipient.mind?.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_APPRENTICE, silent = TRUE)
	else
		added_skills = list(list(/datum/skill/combat/maces, 1, 3))

/datum/virtue/combat/brawler
	name = "Brawler Apprentice"
	desc = "I have trained under a skilled brawler, and have some experience fighting with my fists."
	custom_text = "+1 to Unarmed and Wrestling, Up to Journeyman, Minimum Apprentice."
	added_stashed_items = list("Katar" = /obj/item/rogueweapon/katar)
	
/datum/virtue/combat/brawler/apply_to_human(mob/living/carbon/human/recipient)
	if(recipient.mind?.get_skill_level(/datum/skill/combat/unarmed) < SKILL_LEVEL_APPRENTICE)
		recipient.mind?.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_APPRENTICE, silent = TRUE)
	else
		added_skills = list(list(/datum/skill/combat/unarmed, 1, 3))
	if(recipient.mind?.get_skill_level(/datum/skill/combat/wrestling) < SKILL_LEVEL_APPRENTICE)
		recipient.mind?.adjust_skillrank_up_to(/datum/skill/combat/wrestling, SKILL_LEVEL_APPRENTICE, silent = TRUE)
	else
		added_skills = list(list(/datum/skill/combat/wrestling, 1, 3))


/datum/virtue/combat/bowman
	name = "Toxophilite"
	desc = "I have studied underneath a bowman of considerable skill, and always have my trusty bow and a quiver of arrows close at hand."
	custom_text = "+1 to Bows, Up to Legendary, Minimum Apprentice"
	added_stashed_items = list("Recurve Bow" = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve,
								"Quiver (Arrows)" = /obj/item/quiver/arrows
	)

/datum/virtue/combat/bowman/apply_to_human(mob/living/carbon/human/recipient)
	if(recipient.mind?.get_skill_level(/datum/skill/combat/bows) < SKILL_LEVEL_APPRENTICE)
		recipient.mind?.adjust_skillrank_up_to(/datum/skill/combat/bows, SKILL_LEVEL_APPRENTICE, silent = TRUE)
	else
		added_skills = list(list(/datum/skill/combat/bows, 1, 6))
		
/*/datum/virtue/combat/tavern_brawler
	name = "Tavern Brawler"
	desc = "I've never met a problem my fists couldn't solve."
	added_traits = list(TRAIT_CIVILIZEDBARBARIAN)*/

/datum/virtue/combat/guarded
	name = "Guarded"
	desc = "I have long kept my true capabilities and vices a secret. Sometimes being deceptively weak can save one's life."
	added_traits = list(TRAIT_DECEIVING_MEEKNESS)

/*/datum/virtue/combat/impervious
	name = "Impervious"
	desc = "I've spent years shoring up my weakspots, and have become difficult to wound with critical blows."
	added_traits = list(TRAIT_CRITICAL_RESISTANCE)*/

/datum/virtue/combat/rotcured
	name = "Rotcured"
	desc = "I was once afflicted with the accursed rot, and was cured. It has left me changed: my limbs are weaker, but I feel no pain and have no need to breathe..."
	custom_text = "Colors your body a distinct, sickly green."
	// below is functionally equivalent to dying and being resurrected via aeternus T4 - yep, this is what it gives you.
	added_traits = list(TRAIT_EASYDISMEMBER, TRAIT_NOPAIN, TRAIT_NOPAINSTUN, TRAIT_NOBREATH, TRAIT_TOXIMMUNE, TRAIT_ZOMBIE_IMMUNE, TRAIT_ROTMAN)

/datum/virtue/combat/rotcured/apply_to_human(mob/living/carbon/human/recipient)
	recipient.update_body() // applies the rot skin tone stuff

/datum/virtue/combat/dualwielder
	name = "Dual Wielder"
	desc = "I've been graced with the knowledge of how to wield two weapons at once."
	added_traits = list(TRAIT_DUALWIELDER)

/datum/virtue/combat/sharp
	name = "Sentinel of Wits"
	desc = "Whether it's by having an annoying sibling that kept prodding me with a stick, or years of study and observation, I've become adept at both parrying and dodging stronger opponents, by learning their moves and studying them."
	added_traits = list(TRAIT_SENTINELOFWITS)
