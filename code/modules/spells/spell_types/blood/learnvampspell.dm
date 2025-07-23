//copying spell learning, but for vampires
/obj/effect/proc_holder/spell/self/learnvampspell
	name = "Attempt to learn a new vampire spell or perk"
	desc = "Weave a new spell"
	school = "vampirism"
	overlay_state = "book1"
	chargedrain = 0
	chargetime = 0

/obj/effect/proc_holder/spell/self/learnvampspell/cast(list/targets, mob/user = usr)
	. = ..()

	//what level vampire are we
	var/user_vamp_tier = user.mind.get_skill_level(/datum/skill/magic/vampirism)
	var/mob/living/carbon/human/BSdrinker = user
	 
	//Hard coding the list
	var/list/choices = list()
	var/list/vamp_choices = list()

	if(BSdrinker?.bs_spawn == 1)
		//lesser perk list since they are fledglings
		vamp_choices  += GLOB.learnable_fledgling_perks
		//lesser spell list since they are fledglings
		vamp_choices  += GLOB.learnable_fledgling_spells
	else
		//we define the perks under vamp_perk_list.dm
		vamp_choices  += GLOB.learnable_vamp_perks
		//we define the perks under vamp_spell_list.dm
		vamp_choices  += GLOB.learnable_vamp_spells


	//this limits the list to options that match our vampirism skill and should remove traits we already have
	for(var/i = 1, i <= vamp_choices.len, i++)
		var/obj/effect/proc_holder/spell/vamp_item = vamp_choices[i]
		if((!(isnull(vamp_item.goodtrait))&&(HAS_TRAIT(user,vamp_item.goodtrait)))||(vamp_item.spell_tier > user_vamp_tier))
			continue
		choices["[vamp_item.name]: [vamp_item.cost]"] = vamp_item
		

	//Shows the user how many skill points they have left
	var/choice = input("Choose a spell or perk, points left: [user.mind.vamp_points - user.mind.used_vamp_points]") as null|anything in choices
	var/obj/effect/proc_holder/spell/item = choices[choice]
	if(!item)
		return     // user canceled;
	if(isnull(item.badtrait))
		if(alert(user, "[item.name] ([item.cost]) - [item.desc]", "[item.name]", "Learn", "Cancel") == "Cancel") //gives a preview of the spell's description to let people know what a spell does
			return
	if(!isnull(item.badtrait))
		if(alert(user, "[item.name] ([item.cost]) - [item.desc] but you will get [item.badtraitname] - [item.badtraitdesc]", "[item.name]", "Learn", "Cancel") == "Cancel") //gives a preview of the spell's description to let people know what a spell does
			return
	if(item.cost > user.mind.vamp_points - user.mind.used_vamp_points)
		to_chat(user,span_warning("You do not have enough experience to learn this spell or perk."))
		return		// not enough spell points
	else
		if ((item.name == "--Perks--") || (item.name == "--Spells--"))
			return
		for(var/obj/effect/proc_holder/spell/knownspell in user.mind.spell_list)
			if(knownspell.type == item.type)
				to_chat(user,span_warning("You already know this one!"))
				return	//already know the spell
		if(!(isnull(item.goodtrait))&&(HAS_TRAIT(user,item.goodtrait)))
			to_chat(user,span_warning("You already have this trait!"))
			return	//already have that trait, though it shouldn't be listed

		//custom restrictions
		if (HAS_TRAIT(user,TRAIT_SUN_WEAKNESS) && item.goodtrait == TRAIT_SUN_RESIST)
			to_chat(user,span_warning("You have a weakness and can not resist this"))
			return	//prevent players from resisting their weakness
		if (HAS_TRAIT(user,TRAIT_SILVER_WEAKNESS) && item.goodtrait == TRAIT_SILVER_RESIST)
			to_chat(user,span_warning("You have a weakness and can not resist this"))
			return	//prevent players from resisting their weakness
		if (HAS_TRAIT(user,TRAIT_HOLY_WEAKNESS) && item.goodtrait == TRAIT_HOLY_RESIST)
			to_chat(user,span_warning("You have a weakness and can not resist this"))
			return	//prevent players from resisting their weakness
		if (HAS_TRAIT(user,TRAIT_HIGH_METABOLISM) && item.goodtrait == TRAIT_LOW_METABOLISM)
			to_chat(user,span_warning("You can not lower your thirst"))
			return	//a high metabolism can't be lowered to a low metabolism
		if (HAS_TRAIT(user,TRAIT_SUN_RESIST) && item.badtrait == TRAIT_SUN_WEAKNESS)
			to_chat(user,span_warning("You have a resistance and can not take on a weakness to this"))
			return	//prevent players from resisting their weakness
		if (HAS_TRAIT(user,TRAIT_SILVER_RESIST) && item.badtrait == TRAIT_SILVER_WEAKNESS)
			to_chat(user,span_warning("You have a resistance and can not take on a weakness to this"))
			return	//prevent players from resisting their weakness
		if (HAS_TRAIT(user,TRAIT_HOLY_RESIST) && item.badtrait == TRAIT_HOLY_WEAKNESS)
			to_chat(user,span_warning("You have a resistance and can not take on a weakness to this"))
			return	//prevent players from resisting their weakness
		if (HAS_TRAIT(user,TRAIT_LOW_METABOLISM) && item.badtrait == TRAIT_HIGH_METABOLISM)
			to_chat(user,span_warning("You have a low metabolism and can't take this on"))
			return	//a low metabolism can't be raised to a high metabolism

		//thrall spell limiter
		if ((BSdrinker.bs_thrall > 0)&&(item.name in list ("Recruit Thrall",)))
			to_chat(BSdrinker,span_warning("You've already recruited one or more thralls already"))
			return	//you can't buy the spell a second time

		//Heal limiters, we only allow one trait or spell to heal
		if (HAS_TRAIT(user,TRAIT_VAMP_HEAL_LIMIT) && (item.name in list("Passive Regeneration", 
																		"Vampiric Regeneration",)))
			to_chat(user,span_warning("You have an ability to heal with already"))
			return	//we can't give users more than one way to heal

		user.mind.used_vamp_points += item.cost
		
		//if (!isnull(item.badtrait))
			//here we assign a bad trait
			//ADD_TRAIT(user, item.badtrait, TRAIT_GENERIC)

		if (isnull(item.goodtrait))
			//if the goodtraid is null, we assume its a spell
			var/obj/effect/proc_holder/spell/new_spell = new item
			new_spell.refundable = FALSE
			user.mind.AddSpell(new_spell)
			ADD_TRAIT(user, item.badtrait, TRAIT_GENERIC)
		else
			//there's something in the good trait, so we assume its a perk
			ADD_TRAIT(user, item.goodtrait, TRAIT_GENERIC)
			ADD_TRAIT(user, item.badtrait, TRAIT_GENERIC)

		
			
		/* This is for custom traits if you need more than one for a particularly powerful perk or if a player exceeds a certain number of vampire points, for further balancing
		if (item.goodtrait == "")
			//here we assign a custom bad trait
			ADD_TRAIT(user, !BADTRAIT!, "TRAIT_GENERIC")
		if (user.mind.vamp_points > )
			//here we assign a custom bad trait
			ADD_TRAIT(user, !BADTRAIT!, "TRAIT_GENERIC")
		*/
		//added to limit us to one healing ability
		/*
		if (item.name in list("Passive Regeneration", 
							  "Bat Form", 
							  "Mist Form", 
							  "Vampiric Regeneration",)) 
			//here we assign a custom bad trait
			ADD_TRAIT(user, TRAIT_VAMP_HEAL_LIMIT, "TRAIT_GENERIC")
		*/
		
		addtimer(CALLBACK(user.mind, TYPE_PROC_REF(/datum/mind, check_learnvampspellperk)), 2 SECONDS) //self remove if no points
		return TRUE




