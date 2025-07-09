/obj/effect/proc_holder/spell/invoked/umbral_volley
    name = "Umbral Volley"
    desc = "Unleash a spread of void-forged projectiles that tear through reality toward your foe."
    sound = list("sound/magic/shadowstep_destination.ogg")
    invocation = "Umbrae findite!"
    invocation_type = "shout"

    clothes_req = FALSE
    range = 12
    releasedrain = 30
    chargedrain = 1
    chargetime = 2
    recharge_time = 12 SECONDS
    warnie = "spellwarning"
    no_early_release = TRUE
    movement_interrupt = FALSE
    spell_tier = 3
    glow_color = "#3b1f47"
    glow_intensity = GLOW_INTENSITY_LOW
    charging_slowdown = 3
    chargedloop = /datum/looping_sound/invokegen
    associated_skill = /datum/skill/magic/arcane
    cost = 6
    xp_gain = TRUE

/obj/effect/proc_holder/spell/invoked/umbral_volley/cast(list/targets, mob/user)
	. = ..()
	if (!user || !targets)
		return

	var/turf/start = get_turf(user)
	var/turf/end = get_turf(targets[1])
	if (!start || !end)
		return

	var/total_projectiles = 7
	var/fan_angle = 30
	var/step = total_projectiles > 1 ? fan_angle / (total_projectiles - 1) : 0
	var/base_angle = Get_Angle(start, end)
	var/offset = -(fan_angle / 2)

	for (var/i in 0 to total_projectiles - 1)
		var/obj/projectile/magic/umbral_shard/shard = new /obj/projectile/magic/umbral_shard(start)
		shard.firer = user

		var/final_angle = base_angle + offset + (step * i)
		shard.setAngle(final_angle)
		shard.fire()

/obj/projectile/magic/umbral_shard
	name = "Umbral Shard"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "umbral_shard"
	speed = 12
	damage = 10
	armor_penetration = 5
	damage_type = BRUTE
	woundclass = BCLASS_STAB
	hitsound = 'sound/combat/hits/bladed/genstab (1).ogg'
