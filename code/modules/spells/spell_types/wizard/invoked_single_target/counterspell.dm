/obj/effect/proc_holder/spell/invoked/counterspell
	name = "Counterspell"
	desc = "Briefly nullify the arcane energy surrounding a target. Either preventing magic from being used outright, or preventing most magics from affecting the subject."
	cost = 3
	releasedrain = 35
	chargedrain = 1
	chargetime = 15
	recharge_time = 80 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/wind
	associated_skill = /datum/skill/magic/arcane
	spell_tier = 3 // Full shut down of another mage should be a full mage privilege, imo
	invocation = "Respondeo!"
	invocation_type = "shout"
	glow_color = GLOW_COLOR_ARCANE
	glow_intensity = GLOW_INTENSITY_MEDIUM
	overlay_state = "rune2"
	xp_gain = TRUE

/obj/effect/proc_holder/spell/invoked/counterspell/cast(list/targets, mob/user = usr)
	var/list/buff_to_purge = list(
		/datum/status_effect/buff/celestial_vigil,
		/datum/status_effect/buff/void_vigil,
	)

	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]

		if(HAS_TRAIT(target, TRAIT_COUNTERCOUNTERSPELL))
			to_chat(user, "<span class='warning'>They've counterspelled my counterspell immediately! It's not going to work on them!</span>")
			revert_cast()
			return

		ADD_TRAIT(target, TRAIT_SPELLCOCKBLOCK, MAGIC_TRAIT)
		ADD_TRAIT(target, TRAIT_ANTIMAGIC, MAGIC_TRAIT)

		// Immediately purge listed buffs
		for(var/buff in buff_to_purge)
			if(target.has_status_effect(buff))
				target.remove_status_effect(buff)

		to_chat(target, span_warning("I feel as if my connection to the Arcane disappears entirely. The air feels still..."))
		target.visible_message("[target]'s arcane aura seems to fade.")

		addtimer(CALLBACK(src, PROC_REF(remove_buff), target), wait = 20 SECONDS)
		return TRUE

/obj/effect/proc_holder/spell/invoked/counterspell/proc/remove_buff(mob/living/carbon/target)
	REMOVE_TRAIT(target, TRAIT_SPELLCOCKBLOCK, MAGIC_TRAIT)
	REMOVE_TRAIT(target, TRAIT_ANTIMAGIC, MAGIC_TRAIT)
	to_chat(target, span_warning("I feel my connection to the arcane surround me once more."))
	target.visible_message("[target]'s arcane aura seems to return once more.")
