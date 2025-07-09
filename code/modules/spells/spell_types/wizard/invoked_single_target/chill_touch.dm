/obj/effect/proc_holder/spell/invoked/chilltouch
	name = "Chill Touch"
	desc = "Conjures a spectral skeletal hand that clings to your target, delivering chilling torment."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 10
	recharge_time = 50 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 3

	spell_tier = 2

	xp_gain = TRUE
	miracle = FALSE

	invocation = "Manus Gelida!"
	invocation_type = "shout"
	ignore_fiendkiss = FALSE

/obj/effect/proc_holder/spell/invoked/chilltouch/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		if(!istype(targets[1], /mob/living/carbon))
			var/mob/living/living_tar = targets[1]
			living_tar.adjustBruteLoss(10)
			living_tar.visible_message(span_warning("A skeletal hand punches [living_tar] before vanishing"))
			return TRUE
		var/mob/living/carbon/target = targets[1]
		var/obj/item/bodypart/bodypart = target.get_bodypart(user.zone_selected)
		if(!bodypart)
			return FALSE
		var/obj/item/chilltouch/hand = new(target)
		hand.host = target
		hand.bodypart = bodypart
		hand.forceMove(target)
		bodypart.add_embedded_object(hand, silent = TRUE, crit_message = FALSE)
		target.visible_message(span_warning("A skeletal hand grips [target]'s [bodypart.name]!"), span_danger("A skeletal hand grips my [bodypart.name]!"))
	return FALSE

/obj/item/chilltouch
	name = "Skeletal Hand"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "bounty"

	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	throwforce = 0
	max_integrity = 10

	var/oxy_drain = 2
	var/curprocs = 0
	var/procsmax = 180
	var/mob/living/host
	var/obj/item/bodypart/bodypart

	embedding = list(
		"embedded_unsafe_removal_time" = 50,
		"embedded_pain_chance" = 0,
		"embedded_pain_multiplier" = 0,
		"embed_chance" = 100,
		"embedded_fall_chance" = 0)
	item_flags = DROPDEL
	destroy_sound = 'sound/magic/vlightning.ogg'

/obj/item/chilltouch/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/chilltouch/on_embed(obj/item/bodypart/bodypart)
	to_chat(bodypart.owner, "<span class='warning'>hand attached to [bodypart.owner]'s [bodypart.name]!</span>")
	if(bodypart.owner)
		host = bodypart.owner
		START_PROCESSING(SSobj, src)

/obj/item/chilltouch/process()
	var/hand_proc = pick(1,2,3,4,5)
	var/mult = pick(1,2)
	var/mob/living/target = host
	if(!is_embedded)
		host = null
		return PROCESS_KILL
	if(curprocs >= procsmax)
		host = null
		return PROCESS_KILL
	if(!host)
		qdel(src)
		return FALSE
	curprocs++
	if(hand_proc == 1)
		switch(bodypart.name)
			if(BODY_ZONE_HEAD) //choke
				to_chat(host, "<span class='warning'>[host] is choked by a skeletal hand!</span>")
				playsound(get_turf(host), pick('sound/combat/shove.ogg'), 100, FALSE, -1)
				host.emote("choke")
				target.adjustOxyLoss(oxy_drain*mult*2)
			if(BODY_ZONE_CHEST)
				to_chat(host, "<span class='danger'>[host] is pummeled by a skeletal hand!</span>")
				playsound(get_turf(host), pick('sound/combat/hits/punch/punch_hard (1).ogg','sound/combat/hits/punch/punch_hard (2).ogg','sound/combat/hits/punch/punch_hard (3).ogg'), 100, FALSE, -1)
				target.adjustBruteLoss(oxy_drain*mult*3)
			else
				to_chat(host, "<span class='danger'>[host]'s [bodypart] is twisted by a skeletal hand!</span>")
				playsound(get_turf(host), pick('sound/combat/hits/punch/punch (1).ogg','sound/combat/hits/punch/punch (2).ogg','sound/combat/hits/punch/punch (3).ogg'), 100, FALSE, -1)
				target.apply_damage(oxy_drain*mult*3, BRUTE, bodypart)
				bodypart.update_disabled()
	return FALSE
