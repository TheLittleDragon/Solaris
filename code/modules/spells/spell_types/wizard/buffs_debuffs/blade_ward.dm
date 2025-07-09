/obj/effect/proc_holder/spell/self/bladeward
	name = "Blade Ward"
	desc = "Grants you temporary resistance to physical harm. For a short time, incoming weapon damage is dulled, lessening its impact."
	clothes_req = FALSE
	range = 8
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	recharge_time = 60 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 2

	spell_tier = 2
	miracle = FALSE
	xp_gain = TRUE

	invocation = "Gladii Molliti!"
	invocation_type = "shout"

/obj/effect/proc_holder/spell/self/bladeward/cast(mob/user = usr)
	var/mob/living/target = user
	target.apply_status_effect(/datum/status_effect/buff/bladeward)
	user.visible_message("<span class='info'>[user] traces a warding sigil in the air.</span>", "<span class='notice'>I trace a a sigil of warding in the air.</span>")

/datum/status_effect/buff/bladeward
	id = "blade ward"
	alert_type = /atom/movable/screen/alert/status_effect/buff/bladeward
	effectedstats = list("constitution" = 3)
	duration = 20 SECONDS
	var/static/mutable_appearance/ward = mutable_appearance('icons/effects/beam.dmi', "purple_lightning", -MUTATIONS_LAYER)

/atom/movable/screen/alert/status_effect/buff/bladeward
	name = "Blade Ward"
	desc = "I am resistant to damage."
	icon_state = "buff"

/datum/status_effect/buff/bladeward/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(ward)
	target.update_vision_cone()

/datum/status_effect/buff/bladeward/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(ward)
	target.update_vision_cone()
	. = ..()

/obj/effect/proc_holder/spell/self/bladeward/test
	antimagic_allowed = TRUE
