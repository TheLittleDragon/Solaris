/obj/effect/proc_holder/spell/invoked/void_vigil
    name = "Void Vigil"
    desc = "Summons shadowy sentinels that hunt your enemies with unerring malice."
    sound = list("sound/magic/shadowstep_destination.ogg")
    invocation = "Umbrae vigilent!"
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

/obj/effect/proc_holder/spell/invoked/void_vigil/cast(mob/living/target, mob/living/user)
    . = ..()
    if(!user)
        return

    if(user.has_status_effect(/datum/status_effect/buff/void_vigil))
        to_chat(user, span_warning("The void is already watching through you."))
        return

    user.apply_status_effect(/datum/status_effect/buff/void_vigil)
    create_void_orb_overlay(user)

    spawn()
        monitor_void_vigil(user)

/atom/movable/screen/alert/status_effect/buff/void_vigil
	name = "Void Vigil"
	desc = "Eyes of the void spiral silently around you, drawn to threats like moths to unseen flame."
	icon_state = "buff"

/datum/status_effect/buff/void_vigil
	id = "voidvigil"
	alert_type = /atom/movable/screen/alert/status_effect/buff/void_vigil
	duration = 1 MINUTES

/datum/status_effect/buff/void_vigil/on_remove()
	. = ..()
	remove_void_orb_overlay(owner)

/proc/create_void_orb_overlay(mob/living/user)
	if (!user) return

	var/orb_count = get_void_orb_count(user)
	if (orb_count <= 0) return

	var/radius = 16
	var/spread = 180                // total arc (degrees)
	var/angle_step = spread / (orb_count + 1)
	var/base_angle = 90 - (spread / 2)  // centre the arc above the head

	for (var/i = 1 to orb_count)
		var/angle = base_angle + angle_step * i  // angle in DEGREES
		var/pixel_x = round(cos(angle) * radius)
		var/pixel_y = round(sin(angle) * radius + 8)  // lift arc

		var/obj/effect/overlay/orb/void/orb = new
		orb.icon = 'icons/obj/projectiles.dmi'
		orb.icon_state = "ice_1"
		orb.layer = FLOAT_LAYER
		orb.pixel_x = pixel_x
		orb.pixel_y = pixel_y
		orb.alpha = 200
		orb.color = "#2A003F"
		orb.mouse_opacity = 0
		orb.anchored = TRUE
		orb.loc = null

		user.vis_contents += orb

	user.update_icon()

/obj/effect/overlay/orb/void
    name = "Void Sentinel"
    color = "#2A003F"
    alpha = 180

/proc/monitor_void_vigil(mob/living/user)
	while(user && user.has_status_effect(/datum/status_effect/buff/void_vigil))
		sleep(10) // every second

		var/list/enemies = list()
		for(var/mob/living/mob in view(5, user))
			if(mob == user) continue
			if(!isliving(mob)) continue
			if(mob.health <= 0) continue

			// Skip mounts or riders
			if(user.buckled_mobs && (mob in user.buckled_mobs)) continue
			if(mob.buckled_mobs && (user in mob.buckled_mobs)) continue

			// Skip friendly familiars
			if(istype(mob, /mob/living/simple_animal/pet/familiar/))
				var/mob/living/simple_animal/pet/familiar/fam_target = mob
				if(fam_target.familiar_summoner == user.real_name) continue

			// Skip other friendly summons
			if(mob.summoner == user.real_name) continue

			enemies += mob

		if(enemies.len)
			user.remove_status_effect(/datum/status_effect/buff/void_vigil)
			remove_void_orb_overlay(user)
			fire_void_orbs(user, enemies[1])
			return

/proc/remove_void_orb_overlay(mob/living/user)
    for(var/obj/effect/overlay/orb/void/orb in user.vis_contents)
        if(orb.name == "Void Sentinel")
            qdel(orb)
    user.update_icon()

/proc/fire_void_orbs(mob/living/user, mob/living/target)
	var/turf/start = get_turf(user)
	var/turf/end = get_turf(target)
	var/total_orbs = get_void_orb_count(user)
	var/fan_angle = 60 // total spread angle
	var/step = total_orbs > 1 ? fan_angle / (total_orbs - 1) : 0
	var/base_angle = Get_Angle(start, end)
	var/offset = -(fan_angle / 2)

	for (var/i = 0 to total_orbs - 1)
		var/obj/projectile/magic/void_orb/orb_proj = new(start)
		orb_proj.firer = user
		orb_proj.original = target

		var/final_angle = base_angle + offset + (step * i)
		orb_proj.setAngle(final_angle)
		orb_proj.current_angle = final_angle // Important: set logic angle too
		orb_proj.fire()

/obj/projectile/magic/void_orb
    name = "Void Orb"
    icon = 'icons/obj/projectiles.dmi'
    icon_state = "ice_1"
    color = "#2A003F"
    pixel_x = -8
    pixel_y = -8
    speed = 60

    damage = 15
    damage_type = BRUTE
    armor_penetration = 10
    woundclass = BCLASS_BLUNT
    nodamage = FALSE
    hitsound = 'sound/combat/hits/blunt/bluntsmall (1).ogg'

    var/max_turn_rate = 3 //Higher this is, the better it turns.
    var/direction = 0
    var/current_angle = null

/obj/projectile/magic/void_orb/process()
    . = ..()

    if (!original || QDELETED(original))
        return

    if (ismob(original))
        var/angle_to_target = Get_Angle(get_turf(src), get_turf(original))
        var/delta_angle = (angle_to_target - current_angle + 540) % 360 - 180

        var/turn_amount = clamp(delta_angle, -max_turn_rate, max_turn_rate)
        current_angle += turn_amount
        current_angle = (current_angle + 360) % 360
        setAngle(current_angle)

/proc/get_void_orb_count(mob/living/user)
    if (!user || !user.mind) return 1

    var/intellect = clamp(user.STAINT, 1, 20)
    var/skill_level = user.mind.get_skill_level(/datum/skill/magic/arcane)

    // Base: 3 + 1 per 5 INT, +1 per Arcane skill tier past Apprentice
    var/count = 3
    count += round(intellect / 5)
    count += max(0, skill_level - SKILL_LEVEL_APPRENTICE)

    return min(count, 9) // Cap to avoid spam
