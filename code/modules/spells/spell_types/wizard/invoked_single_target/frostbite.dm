// Spell is disabled because of snap freeze + frost bolt existing at the same time
/obj/effect/proc_holder/spell/invoked/frostbite
	name = "Frostbite"
	desc = "Freeze your enemy with an icy blast that does low damage, but reduces the target's Speed for a considerable length of time."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 8
	recharge_time = 25 SECONDS
	range = 7
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	gesture_required = TRUE
	associated_skill = /datum/skill/magic/arcane
	spell_tier = 2
	invocation = "Congelationis!"
	invocation_type = "shout"
	glow_color = GLOW_COLOR_ICE
	glow_intensity = GLOW_INTENSITY_LOW
	cost = 3

	xp_gain = TRUE
	miracle = FALSE

/obj/effect/proc_holder/spell/invoked/frostbite/cast(list/targets, mob/living/user)
	if(!isliving(targets[1]))
		to_chat(user, span_warning("You need to target a living thing."))
		revert_cast()
		return FALSE

	var/mob/living/carbon/target = targets[1]

	new /obj/effect/temp_visual/trapice(target.loc)

	// Apply effects
	target.apply_status_effect(/datum/status_effect/debuff/frostbite/)
	target.adjustFireLoss(12)
	target.adjustBruteLoss(12)

	// Messaging
	to_chat(user, span_info("You unleash a blast of frost at [target] — ice crackles around them!"))
	target.visible_message(span_notice("[target] is struck by a freezing blast from [user]!"), span_danger("A wave of cold slams into you! Your limbs grow numb..."))
