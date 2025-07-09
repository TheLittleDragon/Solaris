// Arcane Prison, with warning
/obj/effect/proc_holder/spell/invoked/forcewall/arcane_prison
	name = "Arcane Prison"
	desc = "Conjure a wall of weak arcane force around a 5x5 area after a short delay, trapping anyone within. You can pass through it."
	school = "transmutation"
	releasedrain = 50
	spell_tier = 4 // Trolling spell, CM only.
	invocation = "Carcer Arcana!"
	invocation_type = "shout"
	glow_color = GLOW_COLOR_ARCANE
	glow_intensity = GLOW_INTENSITY_HIGH
	wall_type = /obj/structure/forcefield_weak/arcane_prison
	cost = 6
	xp_gain = TRUE

/obj/effect/proc_holder/spell/invoked/forcewall/arcane_prison/cast(list/targets,mob/user = usr)
	var/turf/target = get_turf(targets[1])

	for(var/turf/affected_turf in view(2, target))
		if(!(affected_turf in view(target)))
			continue
		if(get_dist(target, affected_turf) != 2)
			continue
		new /obj/effect/temp_visual/trap_wall(affected_turf)
		addtimer(CALLBACK(src, PROC_REF(new_wall), affected_turf, user), wait = 1 SECONDS)

	user.visible_message("[user] mutters an incantation and a prison of arcane force manifests out of thin air!")
	return TRUE

/obj/structure/forcefield_weak/arcane_prison
	desc = "A wall of pure arcane force. This looks like it would be easily broken."
	name = "Arcane Prison"
	max_integrity = 50 // Ultra 
