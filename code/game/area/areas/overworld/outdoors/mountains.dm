/area/provincial/outdoors/mountains
	name = "\proper Scordris Mountains"
	icon_state = "mountains"
	ambientsounds = AMB_MOUNTAIN
	ambientnight = AMB_MOUNTAIN
	spookysounds = SPOOKY_GEN
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	warden_area = TRUE
	soundenv = 17
	brief_descriptor = "in a makeshift shelter from the world around"
	general_location = "Up in the mountains!"

/area/provincial/outdoors/mountains/underkings_maw
	name = "Underking's Maw"
	icon_state = "decap"
	ambush_types = list(
				/turf/open/floor/rogue/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 30,
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf/bobcat = 20,
				/mob/living/simple_animal/hostile/retaliate/rogue/direbear = 15,
				/mob/living/carbon/human/species/skeleton/npc/ambush = 10,
				/mob/living/carbon/human/species/goblin/npc/ambush/hell = 20)
	droning_sound = 'sound/music/area/decap.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "UNDERKING'S MAW"
	ambush_times = list("night","dawn","dusk","day")
	converted_type = /area/provincial/underground/mountains/underkings_maw
	brief_descriptor = "in a land of magma and arid air"
	general_location = "High above, in the mountaintops!"

/area/provincial/outdoors/mountains/underkings_maw/deeper_within
	name = "Maw's Edge"
	first_time_text = "MAW'S EDGE"
	brief_descriptor = "towards the opening of the underking's maw"
	general_location = "From the mountains of Scordris!"
