/area/provincial/outdoors/forest
	name = "\proper Emerald Glade"
	icon_state = "woods"
	ambientsounds = AMB_FORESTDAY
	ambientnight = AMB_FORESTNIGHT
	spookysounds = SPOOKY_CROWS
	spookynight = SPOOKY_FOREST
	droning_sound = 'sound/music/area/forest.ogg'
	droning_sound_dusk = 'sound/music/area/fieldsdusk.ogg'
	droning_sound_night = 'sound/music/area/forestnight.ogg'
	soundenv = 15
	warden_area = TRUE
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/floor/rogue/dirt,
				/turf/open/floor/rogue/grass)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 40,
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf/bobcat = 20,
				/mob/living/carbon/human/species/skeleton/npc/ambush = 10,
				/mob/living/carbon/human/species/goblin/npc/ambush = 30)
	first_time_text = "THE EMERALD GLADE"
	brief_descriptor = "where trees line all view, and all thought"
	general_location = "From the Emerald Glade!"

/area/provincial/outdoors/forest/brightway
	name = "\proper Brightway Woods"
	first_time_text = "THE BRIGHTWAY WOODS"
