/area/provincial/underground/underdark
	name = "The Underdark"
	icon_state = "cavewet"
	warden_area = FALSE
	first_time_text = "The Underdark"
	ambientsounds = AMB_CAVEWATER
	ambientnight = AMB_CAVEWATER
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'sound/music/area/underdark.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/floor/rogue/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/spider/mutated = 20,
				/mob/living/carbon/human/species/elf/dark/drowraider/ambush = 10,
				/mob/living/simple_animal/hostile/retaliate/rogue/minotaur = 25,
				/mob/living/carbon/human/species/goblin/npc/ambush/moon = 30,
				/mob/living/simple_animal/hostile/retaliate/rogue/mole = 10,
				/mob/living/simple_animal/hostile/retaliate/rogue/troll = 15)
	brief_descriptor = "where dusk elves once stood as monuments"

/area/provincial/underground/underdark/undersea
	name = "The Undersea"
	warden_area = TRUE
	first_time_text = "The Undersea"
	droning_sound = 'sound/music/area/caves.ogg'
	ambush_mobs = list(
				/mob/living/carbon/human/species/skeleton/npc = 10,
				/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 30,
				/mob/living/simple_animal/hostile/retaliate/rogue/mole = 10,
				/mob/living/simple_animal/hostile/retaliate/rogue/direbear = 5,
				/mob/living/carbon/human/species/goblin/npc/sea = 20,
				/mob/living/simple_animal/hostile/retaliate/rogue/troll = 15)
	brief_descriptor = "a sea, entrenched in the Underking's former realm"

/area/provincial/underground/underdark/undersea/undergrove
	name = "The Undergrove"
	first_time_text = "The Undergrove"
	brief_descriptor = "beneath the bog's nightmare"
	general_location = span_danger("From below the bog.")

/area/provincial/underground/underdark/sunkencity
	name = "The Melted Undercity"
	first_time_text = "MELTED UNDERCITY"
	spookysounds = SPOOKY_MYSTICAL
	spookynight = SPOOKY_MYSTICAL
	droning_sound = 'sound/music/area/underdark.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	brief_descriptor = "where men roamed so long ago"
