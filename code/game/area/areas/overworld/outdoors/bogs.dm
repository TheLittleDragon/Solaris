/area/provincial/outdoors/bog
	name = "\proper Synod Of Willows"
	icon_state = "bog"
	warden_area = TRUE
	ambientsounds = AMB_BOGDAY
	ambientnight = AMB_BOGNIGHT
	spookysounds = SPOOKY_FROG
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/bog.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/floor/rogue/dirt,
				/turf/open/floor/rogue/grass,
				/turf/open/water)
	//Minotaurs too strong for the lazy amount of places this area covers
	ambush_mobs = list(
				/mob/living/carbon/human/species/skeleton/npc/ambush = 20,
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 60,
				/mob/living/simple_animal/hostile/retaliate/rogue/troll/bog = 20,
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf/bobcat = 20,
				/mob/living/simple_animal/hostile/retaliate/rogue/spider = 40,
				/mob/living/carbon/human/species/goblin/npc/ambush/cave = 30)
	first_time_text = "THE SYNOD OF WILLOWS"
	brief_descriptor = "a terrible place of wilt and willow"
	general_location = span_danger("It's from the synod of willows.") // You are in danger.

/area/provincial/outdoors/bog/Initialize()
	. = ..()
	if(SSevents.holidays && SSevents.holidays[APRIL_FOOLS])
		first_time_text = "FLORIDA"
