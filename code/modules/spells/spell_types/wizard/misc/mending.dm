/obj/effect/proc_holder/spell/invoked/mending
	name = "Mending"
	desc = "Repairs a damaged item, restoring a portion of its integrity and fixing broken status."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 5
	recharge_time = 20 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 2
	spell_tier = 1

	xp_gain = TRUE
	miracle = FALSE

	invocation = "Reparare et reformare."
	invocation_type = "whisper"

/obj/effect/proc_holder/spell/invoked/mending/cast(list/targets, mob/living/user)
	if(istype(targets[1], /obj/item))
		var/obj/item/I = targets[1]
		if(I.obj_integrity < I.max_integrity)
			var/repair_percent = 0.25
			repair_percent *= I.max_integrity
			I.obj_integrity = min(I.obj_integrity + repair_percent, I.max_integrity)
			user.visible_message(span_info("[I] glows in a faint mending light."))
			if(I.obj_broken == TRUE)
				I.obj_broken = FALSE
			if(istype(I, /obj/item/clothing))
				var/obj/item/clothing/C = I
				C.update_clothes_damaged_state(FALSE)
			I.update_overlays()
		else
			user.visible_message(span_info("[I] appears to be in pefect condition."))
			revert_cast()
	else
		to_chat(user, span_warning("There is no item here!"))
		revert_cast()
