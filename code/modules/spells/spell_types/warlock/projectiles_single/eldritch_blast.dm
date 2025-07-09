/obj/effect/proc_holder/spell/invoked/projectile/eldritchblast
	name = "Eldritch Blast"
	desc = ""
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/eldritchblast
	overlay_state = "force_dart"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 40
	chargedrain = 1
	chargetime = 3
	recharge_time = 5 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 1

	xp_gain = TRUE
	miracle = FALSE

	invocation = "Táin!"
	invocation_type = "shout"
	ignore_fiendkiss = FALSE
	spell_tier = 1


/obj/projectile/magic/eldritchblast
	name = "Eldritch blast"
	desc = "Unleashes a crackling arcane force toward a distant foe."
	tracer_type = /obj/effect/projectile/tracer/bloodsteal
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	light_color = LIGHT_COLOR_PURPLE
	movement_type = UNSTOPPABLE
	damage = 40
	npc_damage_mult = 1.5
	damage_type = BRUTE
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	range = 15
	woundclass = BCLASS_STAB
	light_color = "#7405b4" // purple
	light_outer_range = 7

/obj/projectile/magic/eldritchblast/on_hit(atom/target, blocked = FALSE)
	. = ..()
	playsound(src, 'sound/magic/swap.ogg', 100)
	qdel(src)

/obj/effect/proc_holder/spell/invoked/projectile/eldritchblast/empowered
	name = "Empowered eldritch blast"
	desc = "Empowered form of eldritch blast. Hits harder and knocks targets back with a surge of otherworldly power."
	releasedrain = 40
	projectile_type = /obj/projectile/magic/eldritchblast/empowered

/obj/projectile/magic/eldritchblast/empowered
	damage = 60
	range = 25

/obj/projectile/magic/eldritchblast/empowered/on_hit(atom/target, blocked = FALSE)
	var/atom/throw_target = get_step(target, get_dir(firer, target))
	if(isliving(target))
		var/mob/living/L = target
		if(L.anti_magic_check())
			return BULLET_ACT_BLOCK
		L.throw_at(throw_target, 200, 4)
	else
		if(isitem(target))
			var/obj/item/I = target
			I.throw_at(throw_target, 200, 4)
	return ..()
