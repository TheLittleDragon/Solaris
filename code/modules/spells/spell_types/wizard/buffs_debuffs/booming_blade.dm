/obj/effect/proc_holder/spell/invoked/boomingblade
	name = "Booming Blade"
	overlay_state = "blade_burst"
	desc = "Strike your target with your weapon, infused with volatile energy. If the target moves after being hit, a thunderous explosion erupts around them, dealing extra damage"
	releasedrain = 50
	chargetime = 3
	recharge_time = 15 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 2

	spell_tier = 2

	xp_gain = TRUE
	miracle = FALSE

	invocation = "Fulminis Ictus!"
	invocation_type = "shout"

/obj/effect/proc_holder/spell/invoked/boomingblade/cast(mob/living/user)
	var/obj/item/held_item = user.get_active_held_item()
	if(!held_item)
		to_chat(user, span_warning("You need a weapon to cast Booming Blade!"))
		return FALSE

	// Apply the weapon buff effect to the caster with the held weapon
	user.apply_status_effect(/datum/status_effect/buff/boomingblade_weapon, held_item)

	to_chat(user, span_info("You infuse your [held_item.name] with volatile booming energy."))
	return TRUE

/datum/status_effect/buff/boomingblade_weapon
	id = "booming_blade_weapon"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 15 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/buff/boomingblade_weapon
	on_remove_on_mob_delete = TRUE
	var/datum/weakref/buffed_item

/datum/status_effect/buff/boomingblade_weapon/on_creation(mob/living/new_owner, obj/item/item)
	. = ..()
	if(!.)
		return
	if(istype(item) && !(item.item_flags & ABSTRACT))
		buffed_item = WEAKREF(item)
		if(!item.light_outer_range && item.light_system == STATIC_LIGHT)
			item.set_light(1)
		RegisterSignal(item, COMSIG_ITEM_AFTERATTACK, PROC_REF(item_afterattack))
	else
		return

/datum/status_effect/buff/boomingblade_weapon/on_remove()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOB_ATTACK_HAND)
	if(buffed_item)
		var/obj/item/item = buffed_item.resolve()
		if(istype(item))
			item.set_light(0)
		UnregisterSignal(item, COMSIG_ITEM_AFTERATTACK)

	// Called when weapon attacks successfully
/datum/status_effect/buff/boomingblade_weapon/proc/item_afterattack(obj/item/source, mob/living/target, mob/user, proximity_flag, click_parameters)
	if(!proximity_flag)
		return
	if(!isliving(target))
		return
	// Apply the booming blade debuff to the target
	target.apply_status_effect(/datum/status_effect/buff/boomingblade)
	// Optionally notify the user
	user.visible_message(span_info("[target] is crackling with thunderous energy!"))
	// Remove this buff since it’s used up
	owner.remove_status_effect(src)

/datum/status_effect/buff/boomingblade
	id = "booming blade"
	alert_type = /atom/movable/screen/alert/status_effect/buff/boomingblade
	duration = 10 SECONDS
	var/turf/start_pos
	var/static/mutable_appearance/glow = mutable_appearance('icons/effects/effects.dmi', "empdisable", -MUTATIONS_LAYER)

/datum/status_effect/buff/boomingblade/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(glow)
	target.update_vision_cone()
	start_pos = get_turf(target)

/datum/status_effect/buff/boomingblade/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(glow)
	target.update_vision_cone()
	. = ..()

/datum/status_effect/buff/boomingblade/tick()
	var/turf/new_pos = get_turf(owner)
	var/startX = start_pos.x
	var/startY = start_pos.y
	var/newX = new_pos.x
	var/newY = new_pos.y
	if(startX != newX || startY != newY)
		if(!owner.anti_magic_check())
			boom()
		qdel(src)

/datum/status_effect/buff/boomingblade/proc/boom()
	var/damage = 30
	owner.visible_message(
		span_warning("A thunderous crack erupts around [owner]!"),
		span_danger("Your movement triggers a thunderous blast!")
	)
	playsound(owner.loc, 'sound/magic/lightning.ogg', 70, TRUE)
	owner.adjustBruteLoss(damage)

/atom/movable/screen/alert/status_effect/buff/boomingblade
	name = "Booming Blade"
	desc = "I feel if I move I am in serious trouble."
	icon_state = "debuff"

/atom/movable/screen/alert/status_effect/buff/boomingblade_weapon
	name = "Booming Blade"
	desc = "Your next attack will trigger more damage if the target moves."
	icon_state = "stressvg"
