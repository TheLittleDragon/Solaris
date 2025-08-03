
/obj/structure/fluff/walldeco
	name = ""
	desc = ""
	icon = 'icons/roguetown/misc/decoration.dmi'
	anchored = TRUE
	density = FALSE
	max_integrity = 0
	layer = ABOVE_MOB_LAYER+0.1

/obj/structure/fluff/walldeco/OnCrafted(dirin, user)
	pixel_x = 0
	pixel_y = 0
	switch(dirin)
		if(NORTH)
			pixel_y = 32
		if(SOUTH)
			pixel_y = -32
		if(EAST)
			pixel_x = 32
		if(WEST)
			pixel_x = -32
	. = ..()

/obj/structure/fluff/walldeco/proc/get_attached_wall()
	return

/obj/structure/fluff/walldeco/wantedposter
	name = "bandit notice"
	desc = ""
	icon_state = "wanted1"
	layer = BELOW_MOB_LAYER

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/wantedposter, 32)

/obj/structure/fluff/walldeco/wantedposter/Initialize()
	. = ..()
	icon_state = "wanted[rand(1,3)]"
	dir = pick(GLOB.cardinals)

/obj/structure/fluff/walldeco/wantedposter/examine(mob/user)
	. = ..()
	if(user.Adjacent(src))
		if(SSrole_class_handler.bandits_in_round)
			. += span_bold("I see that bandits are active in the region.")
			user.playsound_local(user, 'sound/misc/notice (2).ogg', 100, FALSE)
		else
			. += span_bold("There doesn't seem to be any reports of bandit activity.")

/obj/structure/fluff/walldeco/innsign
	name = "sign"
	desc = ""
	icon_state = "bar"
	layer = ABOVE_MOB_LAYER

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/innsign, 32)

/obj/structure/fluff/walldeco/steward // not actually traditional walldeco; this typepath STINKS
	name = "sign"
	desc = ""
	icon_state = "steward"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/bsmith
	name = "sign"
	desc = ""
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "bsmith"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/goblet
	name = "sign"
	desc = ""
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "goblet"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/flower
	name = "sign"
	desc = ""
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "flower"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/barbersign
	name = "sign"
	desc = "The iconic swirl of the barber surgeon."
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "barbersign"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/barbersignreverse
	name = "sign"
	desc = "The iconic swirl of the barber surgeon."
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "barbersignflip"
	layer = ABOVE_MOB_LAYER

/obj/structure/fluff/walldeco/sparrowflag
	name = "sparrow flag"
	desc = ""
	icon_state = "sparrow"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/sparrowflag, 32)

/obj/structure/fluff/walldeco/serpflag
	name = "serpent flag"
	desc = ""
	icon_state = "serpent"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/serpflag, 32)

/obj/structure/fluff/walldeco/artificerflag
	name = "Artificer's Creed"
	desc = ""
	icon_state = "artificer"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/artificerflag, 32)

/obj/structure/fluff/walldeco/maidendrape
	name = "black drape"
	desc = "A drape of fabric."
	icon_state = "black_drape"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/maidendrape, 32)

/obj/structure/fluff/walldeco/wallshield
	name = ""
	desc = ""
	icon_state = "wallshield"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/wallshield, 32)

/obj/structure/fluff/walldeco/psybanner
	name = "banner"
	icon_state = "Psybanner-PURPLE"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/psybanner, 32)

/obj/structure/fluff/walldeco/psybanner/red
	icon_state = "Psybanner-RED"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/psybanner/red, 32)

/obj/structure/fluff/walldeco/stone
	name = ""
	desc = ""
	icon_state = "walldec1"
	mouse_opacity = 0

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/stone, 32)

/obj/structure/fluff/walldeco/stone/Initialize()
	icon_state = "walldec[rand(1,6)]"
	..()

/obj/structure/fluff/walldeco/maidensigil
	name = "stone sigil"
	desc = ""
	icon_state = "maidensigil"
	mouse_opacity = 0

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/maidensigil, 32)

/obj/structure/fluff/walldeco/bigpainting
	name = "painting"
	icon = 'icons/roguetown/misc/64x64.dmi'
	icon_state = "sherwoods"
	pixel_y = 32
	pixel_x = -16

/obj/structure/fluff/walldeco/bigpainting/lake
	icon_state = "lake"

/obj/structure/fluff/walldeco/mona
	name = "painting"
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "mona"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/mona, 32)

/obj/structure/fluff/walldeco/chains
	name = "hanging chains"
	alpha = 180
	layer = 4.26
	icon_state = "chains1"
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	can_buckle = 1
	buckle_lying = 0
	breakoutextra = 10 MINUTES
	buckleverb = "tie"

/obj/structure/fluff/walldeco/chains/Initialize()
	icon_state = "chains[rand(1,8)]"
	..()

/obj/structure/fluff/walldeco/customflag
	name = "Flag of Sunmarch"
	desc = "The flag of Sunmarch; proud province of Rasura."
	icon_state = "wallflag"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/customflag, 32)

/obj/structure/fluff/walldeco/customflag/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	GLOB.lordcolor += src

/obj/structure/fluff/walldeco/customflag/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/structure/fluff/walldeco/customflag/lordcolor(primary,secondary)
	if(!primary || !secondary)
		return
	var/mutable_appearance/M = mutable_appearance(icon, "wallflag_primary", -(layer+0.1))
	M.color = primary
	add_overlay(M)
	M = mutable_appearance(icon, "wallflag_secondary", -(layer+0.1))
	M.color = secondary
	add_overlay(M)

/obj/structure/fluff/walldeco/moon
	name = "banner"
	icon_state = "moon"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/moon, 32)

/obj/structure/fluff/walldeco/rpainting
	name = "painting"
	icon_state = "painting_1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/rpainting, 32)

/obj/structure/fluff/walldeco/rpainting/forest
	icon_state = "painting_2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/rpainting/forest, 32)

/obj/structure/fluff/walldeco/rpainting/crown
	icon_state = "painting_3"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/rpainting/crown, 32)

/obj/structure/fluff/walldeco/med
	name = "diagram"
	icon_state = "medposter"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/med, 32)

/obj/structure/fluff/walldeco/med/two
	name = "diagram"
	icon_state = "medposter2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/med/two, 32)

/obj/structure/fluff/walldeco/med/three
	name = "diagram"
	icon_state = "medposter3"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/med/three, 32)

/obj/structure/fluff/walldeco/med/four
	name = "diagram"
	icon_state = "medposter4"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/med/four, 32)

/obj/structure/fluff/walldeco/med/five
	name = "diagram"
	icon_state = "medposter5"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/med/five, 32)

/obj/structure/fluff/walldeco/med/six
	name = "diagram"
	icon_state = "medposter6"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/med/six, 32)

/// This isn't even decoration; man, fuck's sake
/obj/structure/fluff/walldeco/alarm
	name = "visage of heart"
	icon_state = "alarm"
	desc = "An alarm system for the upper caste of Rasurian society. It would probably be best to avoid it's gaze; lest you be pre-approved..."
	var/next_yap = 0
	var/onoff = 1 //Init on

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/walldeco/alarm, 32)

/obj/structure/fluff/walldeco/alarm/attack_hand(mob/living/user)

	user.changeNext_move(CLICK_CD_MELEE)

	if(!(HAS_TRAIT(user, TRAIT_NOBLE)))
		playsound(src, 'sound/misc/machineno.ogg', 100, TRUE, -1)
		say("YOU HAVE NO RIGHT TO TINKER! BEGONE!")
		return

	playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)
	if(onoff == 0)
		onoff = 1
		icon_state = "alarm"
		say("ACTIVE.")
		next_yap = 0 //They won't believe us unless we yap again
		return
	if(onoff == 1)
		onoff = 0
		icon_state = "face"
		say("INACTIVE.")
		return
	else //failsafe
		onoff = 1
		icon_state = "alarm"

/obj/structure/fluff/walldeco/alarm/Crossed(mob/living/user)

	if(onoff == 0)
		return

	if(next_yap > world.time) //Yap cooldown
		return

	if(ishuman(user)) //are we a person?
		var/mob/living/carbon/human/HU = user

		if(HU.anti_magic_check()) //are we shielded?
			return

		if(!(HU in SStreasury.bank_accounts)) //first off- do we not have an account? we'll ALWAYS scream if that's the case
			playsound(loc, 'sound/misc/gold_license.ogg', 100, TRUE, -1)
			say("UNKNOWN PERSON IN SECURE AREA - HALT!!")
			next_yap = world.time + 6 SECONDS
			return

		if(HAS_TRAIT(user, TRAIT_NOBLE))
			say("Hail, [user.real_name]. A thirty-breaths silence in your wake.")
			playsound(loc, 'sound/misc/gold_menu.ogg', 100, TRUE, -1)
			next_yap = world.time + 30 SECONDS
			return

		if((HU in SStreasury.bank_accounts)) //do we have an account?
			playsound(loc, 'sound/misc/gold_menu.ogg', 100, TRUE, -1)
			say("Greetings; [user.real_name]. Persist only with oversight.")
			return

		else //?????
			playsound(loc, 'sound/misc/gold_license.ogg', 100, TRUE, -1)
			say("UNKNOWN PERSON IN SECURE AREA - HALT!!")
			next_yap = world.time + 6 SECONDS

	else
		playsound(loc, 'sound/misc/gold_license.ogg', 100, TRUE, -1)
		say("UNKNOWN CREATURE IN SECURE AREA - DESIST AT ONCE!!") // what're you gonna do; tell it to stop?
		next_yap = world.time + 6 SECONDS

/obj/structure/fluff/walldeco/vinez // overlay vines for more flexibile mapping
	icon_state = "vinez"

/obj/structure/fluff/walldeco/vinez/l
	pixel_x = -32

/obj/structure/fluff/walldeco/vinez/r
	pixel_x = 32

/obj/structure/fluff/walldeco/vinez/offset
	icon_state = "vinez"
	pixel_y = 32

/obj/structure/fluff/walldeco/vinez/blue
	icon_state = "vinez_blue"

/obj/structure/fluff/walldeco/vinez/red
	icon_state = "vinez_red"

/obj/structure/fluff/walldeco/bath // suggestive stonework
	icon_state = "bath1"
	pixel_x = -32
	alpha = 210

/obj/structure/fluff/walldeco/bath/two
	icon_state = "bath2"
	pixel_x = -29

/obj/structure/fluff/walldeco/bath/three
	icon_state = "bath3"
	pixel_x = -29

/obj/structure/fluff/walldeco/bath/four
	icon_state = "bath4"
	pixel_y = 32
	pixel_x = 0

/obj/structure/fluff/walldeco/bath/five
	icon_state = "bath5"
	pixel_x = -29

/obj/structure/fluff/walldeco/bath/six
	icon_state = "bath6"
	pixel_x = -29

/obj/structure/fluff/walldeco/bath/seven
	icon_state = "bath7"
	pixel_x = 32

/obj/structure/fluff/walldeco/bath/gents
	icon_state = "gents"
	pixel_x = 0
	pixel_y = 32

/obj/structure/fluff/walldeco/bath/ladies
	icon_state = "ladies"
	pixel_x = 0
	pixel_y = 32

/obj/structure/fluff/walldeco/bath/wallrope
	icon_state = "wallrope"
	layer = WALL_OBJ_LAYER+0.1
	pixel_x = 0
	pixel_y = 0
	color = "#d66262"

/obj/structure/fluff/walldeco/sign/saiga
	name = "The Drunken Saiga"
	icon_state = "shopsign_inn_saiga_right"
	plane = -1
	pixel_x = 3
	pixel_y = 16

/obj/structure/fluff/walldeco/sign/saiga/left
	icon_state = "shopsign_inn_saiga_left"

/obj/structure/fluff/walldeco/sign/trophy
	name = "saiga trophy"
	icon_state = "saiga_trophy"
	pixel_y = 32

/obj/effect/decal/shadow_floor
	name = ""
	desc = ""
	icon = 'icons/roguetown/misc/decoration.dmi'
	icon_state = "shadow_floor"
	mouse_opacity = 0

/obj/effect/decal/shadow_floor/corner
	icon_state = "shad_floorcorn"
