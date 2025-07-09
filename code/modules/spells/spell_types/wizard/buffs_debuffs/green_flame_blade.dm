/obj/effect/proc_holder/spell/invoked/greenflameblade
	name = "Green-Flame Blade"
	desc = "Imbue your weapon with green flame. Your next strike burns your target and nearby enemies."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 3
	recharge_time = 10 SECONDS
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 2

	spell_tier = 2
	xp_gain = TRUE
	miracle = FALSE

	invocation = "Gladius flamma viridis!"
	invocation_type = "shout"

/obj/effect/proc_holder/spell/invoked/greenflameblade/cast(mob/living/user)
	var/obj/item/held_item = user.get_active_held_item()
	if(!held_item)
		user.visible_message(span_warning("You need a weapon to cast Green-Flame Blade!"))
		return FALSE

	user.apply_status_effect(/datum/status_effect/buff/greenflameblade_weapon, held_item)
	user.visible_message(span_info("Your [held_item.name] glows with verdant magical fire!"))
	return TRUE

/datum/status_effect/buff/greenflameblade_weapon
	id = "greenflame_blade_weapon"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 15 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/buff/greenflameblade_weapon
	on_remove_on_mob_delete = TRUE
	var/datum/weakref/buffed_item

/datum/status_effect/buff/greenflameblade_weapon/on_creation(mob/living/new_owner, obj/item/item)
	. = ..()
	if(!. || !item)
		return
	buffed_item = WEAKREF(item)
	RegisterSignal(item, COMSIG_ITEM_AFTERATTACK, PROC_REF(item_afterattack))

/datum/status_effect/buff/greenflameblade_weapon/on_remove()
	if(buffed_item)
		var/obj/item/item = buffed_item.resolve()
		if(item)
			UnregisterSignal(item, COMSIG_ITEM_AFTERATTACK)

/datum/status_effect/buff/greenflameblade_weapon/proc/item_afterattack(obj/item/source, mob/living/target, mob/user, proximity_flag, click_parameters)
	if(!proximity_flag || !isliving(target))
		return

	// Primary burn
	target.adjustFireLoss(15)
	playsound(target, 'sound/items/firesnuff.ogg', 100)
	new /obj/effect/temp_visual/greenflameblade(get_turf(target))

	// AoE burn
	for(var/mob/living/mob_hit in range(1, get_turf(target)))
		if(mob_hit != user && !mob_hit.anti_magic_check())
			mob_hit.adjustFireLoss(15)
			playsound(mob_hit, 'sound/items/firelight.ogg', 100)
			new /obj/effect/temp_visual/greenflameblade(get_turf(mob_hit))

	user.visible_message(span_danger("[target] and nearby foes erupt in green fire!"))
	owner.remove_status_effect(src)

/atom/movable/screen/alert/status_effect/buff/greenflameblade_weapon
	name = "Green-Flame Blade"
	desc = "Your next strike will ignite enemies with green fire."
	icon_state = "buff" 

/obj/effect/temp_visual/greenflameblade
	icon = 'icons/effects/fire.dmi'
	icon_state = "1"
	name = "Green-flame"
	desc = "Magical fire. Interesting."
	color = COLOR_GREEN
	randomdir = FALSE
	duration = 1 SECONDS
	layer = ABOVE_ALL_MOB_LAYER
