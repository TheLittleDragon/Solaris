/mob/living/simple_animal/hostile/boss/bandit_leader
	name = "Bandit Leader"
	desc = "Something about the smile on his face makes you want to believe he is as harmless as he appears. You know better."
	mob_biotypes = MOB_HUMANOID
	boss_abilities = list()
	faction = list("miniboss")
	del_on_death = TRUE
	icon = 'icons/mob/solaris_badasses.dmi'
	icon_state = "bandit_leader"
	wander = 0
	vision_range = 8
	aggro_vision_range = 10
	retreat_distance = 2
	minimum_distance = 1
	environment_smash = 1
	obj_damage = 15
	base_intents = list(/datum/intent/spear/banditboss_spear)
	melee_damage_lower = 15
	melee_damage_upper = 25
	dodge_prob = 33
	health = 800
	maxHealth = 800
	point_regen_delay = 1
	STASTR = 13
	STAPER = 14
	STAINT = 10
	STACON = 14
	STAEND = 18
	STASPD = 16
	STALUC = 19
	loot = list(/obj/effect/spawner/lootdrop/roguetown/dungeon/money/rich, /obj/effect/spawner/lootdrop/roguetown/dungeon/weapons, /obj/effect/spawner/lootdrop/roguetown/dungeon/food, /obj/effect/temp_visual/minibossdeath_bandit_leader)
	footstep_type = FOOTSTEP_MOB_SHOE
	stat_attack = UNCONSCIOUS
	var/spawned_mobs = 0
	var/max_mobs = 5
	var/list/spawnable_mobs = list(/mob/living/carbon/human/species/human/bandit_leader_henchman = 66, /mob/living/simple_animal/hostile/retaliate/rogue/wolf/miniboss = 33)
	var/mobs_to_spawn = 1
	var/next_allowed_spawn

/obj/effect/temp_visual/minibossdeath
	icon = 'icons/effects/effects.dmi'
	icon_state = "phaseout"
	dir = NORTH
	name = "Underking's Grasp"
	desc = "Put ominous message here"
	randomdir = FALSE
	duration = 1 SECONDS
	layer = MASSIVE_OBJ_LAYER

//Melee Attacks

/datum/intent/spear/banditboss_spear
	name = "thrust"
	blade_class = BCLASS_STAB
	attack_verb = list("thrusts")
	animname = "stab"
	icon_state = "instab"
	reach = 2
	chargetime = 0
	swingdelay = 1
	warnie = "mobwarning"
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = 33
	item_d_type = "stab"

//Boss Adds stuff courtesy of lich_boss

/mob/living/simple_animal/hostile/retaliate/rogue/wolf/miniboss
	faction = list("miniboss","wolfs")

/mob/living/simple_animal/hostile/boss/bandit_leader/Initialize()
	. = ..()
	next_allowed_spawn = world.time + 500000
	spawned_mobs = 0

/mob/living/simple_animal/hostile/boss/bandit_leader/Aggro()
	. = ..()
	next_allowed_spawn = world.time
	if(spawned_mobs == 0)
		src.say(pick("Get em!","That one!","Look alive lads!"))
		playsound(src,'sound/vo/attn.ogg', 80)

/mob/living/simple_animal/hostile/boss/bandit_leader/proc/spawn_minions()
	var/spawn_chance = 100
	if (prob(spawn_chance))
		var/turf/spawn_turf
		var/mob_type
		var/new_mob
		spawn_turf = get_random_valid_turf()
		if (spawn_turf)
			mob_type = pickweight(spawnable_mobs)
			new_mob = new mob_type(spawn_turf)
			if (new_mob)
				spawned_mobs++

/mob/living/simple_animal/hostile/boss/bandit_leader/proc/get_random_valid_turf()
	var/list/valid_turfs = list()
	for (var/turf/T in range(6, src))
		if (is_valid_spawn_turf(T))
			valid_turfs += T
	if (valid_turfs.len == 0)
		return null
	return pick(valid_turfs)

/mob/living/simple_animal/hostile/boss/bandit_leader/proc/is_valid_spawn_turf(turf/T)
	if (!(istype(T, /turf/open/floor/rogue)))
		return FALSE
	if (istype(T, /turf/closed))
		return FALSE
	return TRUE

/mob/living/simple_animal/hostile/boss/bandit_leader/handle_automated_action()
	. = ..()
	if((spawned_mobs) < (max_mobs) && (next_allowed_spawn) <= (world.time))
		spawn_minions((mobs_to_spawn))
		next_allowed_spawn = world.time + 700


//Boss Abilities - None. This is fucking patches. He's got charisma and thats it.


//Utility stuff

/obj/effect/temp_visual/minibossdeath_bandit_leader
	icon = 'icons/effects/effects.dmi'
	icon_state = "phaseout"
	dir = NORTH
	name = "Underking's Grasp"
	desc = "But I had it all..!"
	randomdir = FALSE
	duration = 1 SECONDS
	layer = MASSIVE_OBJ_LAYER

/obj/effect/temp_visual/minibossdeath_bandit_leader/Initialize()
	. = ..()
	visible_message(span_boldannounce("The Bandit Leader lets out a pathetic yelp and dissolves before you!"))
	playsound(src, 'sound/vo/male/evil/painscream (1).ogg', 90)
	for(var/mob/M in range(7,src))
		shake_camera(M, 7, 1)
