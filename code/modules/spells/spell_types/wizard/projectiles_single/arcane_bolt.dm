/obj/effect/proc_holder/spell/invoked/projectile/arcanebolt //makes you confused for 2 seconds,
	name = "Arcane Bolt"
	desc = "Shoot out a rapid bolt of arcane magic that hits on impact. Little damage, but disorienting. \n\
	Damage is increased by 50% versus soulless creatures."
	clothes_req = FALSE
	range = 12
	projectile_type = /obj/projectile/energy/rogue3
	overlay_state = "force_dart"
	sound = list('sound/magic/vlightning.ogg')
	active = FALSE
	releasedrain = 15
	chargedrain = 1
	chargetime = 0
	recharge_time = 3.5 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	spell_tier = 3
	invocation_type = "emote"
	invocation = span_warning("%user% casts Arcane Bolt!")
	invocation_emote_self = span_warning("I cast Arcane Bolt!")
	glow_color = GLOW_COLOR_ARCANE
	glow_intensity = GLOW_INTENSITY_LOW
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 3
	xp_gain = TRUE

	ignore_fiendkiss = FALSE

/obj/projectile/energy/rogue3
	name = "Arcane Bolt"
	icon_state = "arcane_barrage"
	damage = 40
	damage_type = BRUTE
	armor_penetration = 0
	npc_damage_mult = 1.5
	woundclass = BCLASS_BLUNT
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/combat/hits/blunt/shovel_hit2.ogg'
	speed = 1

/obj/projectile/energy/rogue3/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/living/carbon/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		playsound(get_turf(target), 'sound/combat/hits/blunt/shovel_hit2.ogg', 100) //CLANG
	else
		return
