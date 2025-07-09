/obj/effect/proc_holder/spell/invoked/projectile/firebolt
	name = "Fire Bolt"
	desc = "Conjures a searing bolt of arcane fire. Damage is increased by 100% versus soulless creatures."
	clothes_req = FALSE
	range = 10
	projectile_type = /obj/projectile/magic/firebolt
	overlay_state = "fireball_multi"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	recharge_time = 3 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	spell_tier = 2
	cost = 3
	invocation = "Ignis iaculare!"
	invocation_type = "shout"
	xp_gain = TRUE
	ignore_fiendkiss = FALSE

/obj/projectile/magic/firebolt
	name = "Fire Bolt"
	icon_state = "fireball"
	damage = 20
	damage_type = BURN
	npc_damage_mult = 2
	flag = "magic"
	range = 10
