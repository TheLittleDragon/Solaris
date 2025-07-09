/obj/effect/proc_holder/spell/invoked/celestial_vigil
    name = "Celestial Vigil"
    desc = "Summons guiding stars that protect the caster against those who draw near."
    sound = list("modular_azurepeak/sound/spellbooks/crystal.ogg")
    invocation = "Custodes caeli, vigilemus!"
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
    glow_color = GLOW_COLOR_ARCANE
    glow_intensity = GLOW_INTENSITY_LOW
    charging_slowdown = 3
    chargedloop = /datum/looping_sound/invokegen
    associated_skill = /datum/skill/magic/arcane
    cost = 6
    xp_gain = TRUE

/obj/effect/proc_holder/spell/invoked/celestial_vigil/cast(mob/living/target, mob/living/user)
    . = ..()
    if(!user)
        return

    if(user.has_status_effect(/datum/status_effect/buff/celestial_vigil))
        to_chat(user, span_warning("The celestial vigil is already watching over you."))
        return

    user.apply_status_effect(/datum/status_effect/buff/celestial_vigil)
    create_celestial_orb_overlay(user)

    spawn()
        monitor_celestial_vigil(user)

/atom/movable/screen/alert/status_effect/buff/celestial_vigil
	name = "Celestial Vigil"
	desc = "Luminous stars drift in silent orbit, shielding you with radiant vigilance."
	icon_state = "buff"

/datum/status_effect/buff/celestial_vigil
	id = "celestialvigil"
	alert_type = /atom/movable/screen/alert/status_effect/buff/celestial_vigil
	duration = 1 MINUTES

/datum/status_effect/buff/celestial_vigil/on_remove()
	. = ..()
	remove_celestial_orb_overlay(owner)

/proc/create_celestial_orb_overlay(mob/living/user)
	if (!user) return

	var/orb_count = get_celestial_orb_count(user)
	if (orb_count <= 0) return

	var/radius = 16
	var/spread = 180                // total arc (degrees)
	var/angle_step = spread / (orb_count + 1)
	var/base_angle = 90 - (spread / 2)  // centre the arc above the head

	for (var/i = 1 to orb_count)
		var/angle = base_angle + angle_step * i  // angle in DEGREES
		var/pixel_x = round(cos(angle) * radius)
		var/pixel_y = round(sin(angle) * radius + 8)  // lift arc

		var/obj/effect/overlay/orb/orb = new
		orb.icon = 'icons/obj/projectiles.dmi'
		orb.icon_state = "ice_1"
		orb.layer = FLOAT_LAYER
		orb.pixel_x = pixel_x
		orb.pixel_y = pixel_y
		orb.alpha = 200
		orb.color = "#ddeeff"
		orb.mouse_opacity = 0
		orb.anchored = TRUE
		orb.loc = null

		user.vis_contents += orb

	user.update_icon()

/obj/effect/overlay/orb
    icon = 'icons/obj/projectiles.dmi'
    icon_state = "ice_1"
    name = "Celestial Light"
    color = "#ddeeff"
    alpha = 200
    mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/proc/monitor_celestial_vigil(mob/living/user)
	while(user && user.has_status_effect(/datum/status_effect/buff/celestial_vigil))
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
			user.remove_status_effect(/datum/status_effect/buff/celestial_vigil)
			remove_celestial_orb_overlay(user)
			fire_celestial_orbs(user, enemies[1])
			return

/proc/remove_celestial_orb_overlay(mob/living/user)
    for(var/obj/effect/overlay/orb in user.vis_contents)
        if(orb.name == "Celestial Light")
            qdel(orb)
    user.update_icon()

/proc/fire_celestial_orbs(mob/living/user, mob/living/target)
	var/turf/start = get_turf(user)
	var/turf/end = get_turf(target)
	var/total_orbs = get_celestial_orb_count(user)
	var/fan_angle = 30 // total spread angle
	var/step = total_orbs > 1 ? fan_angle / (total_orbs - 1) : 0
	var/base_angle = Get_Angle(start, end)
	var/offset = -(fan_angle / 2)

	for (var/i = 0 to total_orbs - 1)
		var/obj/projectile/magic/celestial_orb/orb_proj = new(start)
		orb_proj.firer = user
		orb_proj.original = target

		var/final_angle = base_angle + offset + (step * i)
		orb_proj.setAngle(final_angle)
		orb_proj.current_angle = final_angle // Important: set logic angle too
		orb_proj.fire()

/obj/projectile/magic/celestial_orb
    name = "Celestial Orb"
    icon = 'icons/obj/projectiles.dmi'
    color = "#ddeeff"
    icon_state = "ice_1"
    pixel_x = -8
    pixel_y = -8
    speed = 20

    damage = 15
    damage_type = BRUTE
    armor_penetration = 10
    woundclass = BCLASS_BLUNT
    nodamage = FALSE
    hitsound = 'sound/combat/hits/blunt/bluntsmall (1).ogg'

    var/max_turn_rate = 1 //The higher it is, the better it turns
    var/direction = 0
    var/current_angle = null

/obj/projectile/magic/celestial_orb/process()
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

/proc/get_celestial_orb_count(mob/living/user)
    if (!user || !user.mind) return 1

    var/intellect = clamp(user.STAINT, 1, 20)
    var/skill_level = user.mind.get_skill_level(/datum/skill/magic/arcane)

    // Base: 3 + 1 per 5 INT, +1 per Arcane skill tier past Apprentice
    var/count = 3
    count += round(intellect / 5)
    count += max(0, skill_level - SKILL_LEVEL_APPRENTICE)

    return min(count, 9) // Cap to avoid spam
