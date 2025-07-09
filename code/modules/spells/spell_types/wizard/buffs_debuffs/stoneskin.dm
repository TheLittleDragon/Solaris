/obj/effect/proc_holder/spell/invoked/stoneskin
	name = "Stoneskin"
	overlay_state = "stoneskin"
	desc = "Harden the target's skin like stone. (+3 Constitution, -2 Speed, Critical Resistance)"
	cost = 4
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 1 SECONDS
	recharge_time = 2 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	spell_tier = 2
	invocation = "Indura Sicut Saxum"
	invocation_type = "whisper"
	glow_color = GLOW_COLOR_BUFF
	glow_intensity = GLOW_INTENSITY_LOW
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	range = 7

/obj/effect/proc_holder/spell/invoked/stoneskin/cast(list/targets, mob/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	if(spelltarget != user)
		user.visible_message("[user] mutters an incantation and [spelltarget] 's skin hardens like stone.")
		to_chat(user, span_notice("With another person as a conduit, my spell's duration is doubled."))
		spelltarget.apply_status_effect(/datum/status_effect/buff/stoneskin/other)
	else
		user.visible_message("[user] mutters an incantation and their skin hardens.")
		spelltarget.apply_status_effect(/datum/status_effect/buff/stoneskin)

	return TRUE

#define STONESKIN_FILTER "stoneskin_glow"
/atom/movable/screen/alert/status_effect/buff/stoneskin
	name = "Stoneskin"
	desc = "My skin are hardened like stone (+3 Constitution, -2 Speed, Critical Resistance)"
	icon_state = "buff"

/datum/status_effect/buff/stoneskin
	var/outline_colour ="#808080" // Granite Grey
	id = "stoneskin"
	alert_type = /atom/movable/screen/alert/status_effect/buff/stoneskin
	effectedstats = list("constitution" = 3, "speed" = -2)
	var/hadcritres = FALSE
	duration = 1 MINUTES

/datum/status_effect/buff/stoneskin/other
	duration = 2 MINUTES

/datum/status_effect/buff/stoneskin/on_apply()
	. = ..()
	var/filter = owner.get_filter(STONESKIN_FILTER)
	if (!filter)
		owner.add_filter(STONESKIN_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))
	to_chat(owner, span_warning("My skin hardens like stone."))
	if(!HAS_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE))
		ADD_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE, MAGIC_TRAIT)
	else
		hadcritres = TRUE

/datum/status_effect/buff/stoneskin/on_remove()
	. = ..()
	to_chat(owner, span_warning("The stone shell cracks away."))
	owner.remove_filter(STONESKIN_FILTER)
	if(!hadcritres)
		REMOVE_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE, MAGIC_TRAIT)

#undef STONESKIN_FILTER
