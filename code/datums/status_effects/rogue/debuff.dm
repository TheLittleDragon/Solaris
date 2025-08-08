/datum/status_effect/debuff
	status_type = STATUS_EFFECT_REFRESH

///////////////////////////

/datum/status_effect/debuff/hungryt1
	id = "hungryt1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt1
	effectedstats = list("constitution" = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/hungryt1
	name = "Hungry"
	desc = "Hunger weakens this living body."
	icon_state = "hunger1"

/datum/status_effect/debuff/hungryt2
	id = "hungryt2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt2
	effectedstats = list("strength" = -2, "constitution" = -2, "endurance" = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/hungryt2
	name = "Hungry"
	desc = "This living body suffers heavily from hunger."
	icon_state = "hunger2"

/datum/status_effect/debuff/hungryt3
	id = "hungryt3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt3
	effectedstats = list("strength" = -5, "constitution" = -3, "endurance" = -2)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/hungryt3
	name = "Hungry"
	desc = "My body can barely hold it!"
	icon_state = "hunger3"

//SILVER DAGGER EFFECT

/datum/status_effect/debuff/silver_curse
	id = "silver_curse"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/silver_curse
	effectedstats = list("strength" = -2,"perception" = -2,"intelligence" = -2, "constitution" = -2, "endurance" = -2,"speed" = -2)
	duration = 45 SECONDS

/atom/movable/screen/alert/status_effect/debuff/silver_curse
	name = "Silver Curse"
	desc = "My BANE!"
	icon_state = "hunger3"

////////////////////


/datum/status_effect/debuff/thirstyt1
	id = "thirsty1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/thirstyt1
	effectedstats = list("endurance" = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/thirstyt1
	name = "Thirsty"
	desc = "I need water."
	icon_state = "thirst1"

/datum/status_effect/debuff/thirstyt2
	id = "thirsty2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/thirstyt2
	effectedstats = list("speed" = -1, "endurance" = -2)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/thirstyt2
	name = "Thirsty"
	desc = "My mouth feels much drier."
	icon_state = "thirst2"

/datum/status_effect/debuff/thirstyt3
	id = "thirsty3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/thirstyt3
	effectedstats = list("strength" = -1, "speed" = -2, "endurance" = -3)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/thirstyt3
	name = "Thirsty"
	desc = "I urgently need water!"
	icon_state = "thirst3"

/////////

/datum/status_effect/debuff/uncookedfood
	id = "uncookedfood"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/uncookedfood/on_apply()
	if(HAS_TRAIT(owner, TRAIT_NASTY_EATER) || HAS_TRAIT(owner, TRAIT_WILD_EATER))
		return ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(100)
	return ..()

/datum/status_effect/debuff/badmeal
	id = "badmeal"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/badmeal/on_apply()
	owner.add_stress(/datum/stressevent/badmeal)
	return ..()

/datum/status_effect/debuff/burnedfood
	id = "burnedfood"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/burnedfood/on_apply()
	if(HAS_TRAIT(owner, TRAIT_NASTY_EATER))
		return ..()
	owner.add_stress(/datum/stressevent/burntmeal)
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(100)
	return ..()

/datum/status_effect/debuff/rotfood
	id = "rotfood"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/rotfood/on_apply()
	if(HAS_TRAIT(owner, TRAIT_NASTY_EATER))
		return ..()
	owner.add_stress(/datum/stressevent/rotfood)
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(200)
	return ..()

/datum/status_effect/debuff/bleeding
	id = "bleedingt1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/bleedingt1
	effectedstats = list("speed" = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/bleedingt1
	name = "Dizzy"
	desc = ""
	icon_state = "bleed1"

/datum/status_effect/debuff/bleedingworse
	id = "bleedingt2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/bleedingt2
	effectedstats = list("strength" = -1, "speed" = -2)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/bleedingt2
	name = "Faint"
	desc = ""
	icon_state = "bleed2"

/datum/status_effect/debuff/bleedingworst
	id = "bleedingt3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/bleedingt3
	effectedstats = list("strength" = -3, "speed" = -4)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/bleedingt3
	name = "Drained"
	desc = ""
	icon_state = "bleed3"

/datum/status_effect/debuff/sleepytime
	id = "sleepytime"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/sleepytime

/atom/movable/screen/alert/status_effect/debuff/netted
	name = "Net"
	desc = "A net was thrown on me.. how can I move?"
	icon_state = "muscles"

/datum/status_effect/debuff/netted
	id = "net"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/netted
	effectedstats = list("speed" = -5, "endurance" = -2)
	duration = 3 MINUTES

/datum/status_effect/debuff/netted/on_apply()
		. = ..()
		var/mob/living/carbon/C = owner
		C.add_movespeed_modifier(MOVESPEED_ID_NET_SLOWDOWN, multiplicative_slowdown = 3)

/datum/status_effect/debuff/netted/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.legcuffed = null
		C.update_inv_legcuffed()
		C.remove_movespeed_modifier(MOVESPEED_ID_NET_SLOWDOWN)

/datum/status_effect/debuff/dazed
	id = "dazed"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/dazed
	effectedstats = list("perception" = -2, "intelligence" = -2)
	duration = 15 SECONDS
	status_type = STATUS_EFFECT_REFRESH

/atom/movable/screen/alert/status_effect/debuff/dazed
	name = "Dazed"
	desc = "You've been smacked on the head very hard. Which way is left, again?"
	icon_state = "dazed"

/atom/movable/screen/alert/status_effect/debuff/sleepytime
	name = "Tired"
	desc = "I should get some rest."
	icon_state = "sleepy"

/datum/status_effect/debuff/muscle_sore
	id = "muscle_sore"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/muscle_sore
	effectedstats = list("strength" = -1, "endurance" = -1)

/atom/movable/screen/alert/status_effect/debuff/muscle_sore
	name = "Muscle Soreness"
	desc = "My muscles need some sleep to recover."
	icon_state = "muscles"

/datum/status_effect/debuff/devitalised
	id = "devitalised"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/devitalised
	effectedstats = list("fortune" = -3)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/debuff/devitalised
	name = "Devitalised"
	desc = "Something has been taken from me, and it will take time to recover."

/datum/status_effect/debuff/vamp_dreams
	id = "sleepytime"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/vamp_dreams

/atom/movable/screen/alert/status_effect/debuff/vamp_dreams
	name = "Insight"
	desc = "With some sleep in a coffin I feel like I could become better."
	icon_state = "sleepy"

/// SURRENDERING DEBUFFS

/datum/status_effect/debuff/breedable
	id = "breedable"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/breedable
	duration = 30 SECONDS

/datum/status_effect/debuff/breedable/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE, id)

/datum/status_effect/debuff/breedable/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE, id)

/atom/movable/screen/alert/status_effect/debuff/breedable
	name = "Obedient"
	desc = "They won't hurt me too much..."

/datum/status_effect/debuff/submissive
	id = "submissive"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/submissive
	duration = 60 SECONDS

/datum/status_effect/debuff/submissive/on_apply()
	. = ..()
	owner.add_movespeed_modifier("SUBMISSIVE", multiplicative_slowdown = 4)

/datum/status_effect/debuff/submissive/on_remove()
	. = ..()
	owner.remove_movespeed_modifier("SUBMISSIVE")

/atom/movable/screen/alert/status_effect/debuff/submissive
	name = "Compliant"
	desc = "Falling in line is my only choice."

/datum/status_effect/debuff/chilled
	id = "chilled"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/chilled
	effectedstats = list("speed" = -5, "strength" = -2, "endurance" = -2)
	duration = 15 SECONDS

/atom/movable/screen/alert/status_effect/debuff/chilled
	name = "Chilled"
	desc = "I can barely feel my limbs!"
	icon_state = "chilled"


/datum/status_effect/debuff/ritesexpended
	id = "ritesexpended"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/ritesexpended
	duration = 30 MINUTES

/atom/movable/screen/alert/status_effect/debuff/ritesexpended
	name = "Rites Complete"
	desc = "It will take time before I can next perform a rite."
	icon_state = "ritesexpended"

/datum/status_effect/debuff/call_to_arms
	id = "call_to_arms"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/call_to_arms
	duration = 2.5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/call_to_arms
	name = "Cathus' Call to Arms"
	desc = "His voice keeps ringing in your ears, rocking your soul.."
	icon_state = "call_to_arms"

/datum/status_effect/debuff/carthus_burden
	id = "carthus_burden"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/carthus_burden
	effectedstats = list("speed" = -2, "endurance" = -3)
	duration = 12 SECONDS

/atom/movable/screen/alert/status_effect/debuff/carthus_burden
	name = "Carthus' Burden"
	desc = "My arms and legs are restrained by divine chains!\n"
	icon_state = "restrained"

/datum/status_effect/debuff/unnaturalexhaustion
	id = "unnaturalexhaustion"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/unnaturalexhaustion
	effectedstats = list("endurance" = -2, "fortune" = -1)
	duration = 5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/unnaturalexhaustion
	name = "Unnatural Exhaustion"
	desc = "My whole body is sore, I feel like I spent all day working out"
	icon_state = "muscles"
 
//vampire related debuffs
/atom/movable/screen/alert/status_effect/debuff/veil_up
	name = "Vampires Veil"
	desc = "raise my veil to protect me from the sun and to hide my true nature."
	icon_state = "veil_up"

/datum/status_effect/debuff/veil_up
	id = "veil_up"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/veil_up

/datum/status_effect/debuff/veil_up/on_apply()	
	if(iscarbon(owner))
		if(HAS_TRAIT(owner, TRAIT_VAMPIRISM))
			var/mob/living/carbon/human/H = owner
			var/vampskill = H.mind.get_skill_level(/datum/skill/magic/vampirism)
			//less of a debutff them higher your vampirism level is
			switch(vampskill)
				if(1) 
					effectedstats = list("speed" = -2, "strength" = -2, "endurance" = -2)
				if(2) 
					effectedstats = list("speed" = -1, "strength" = -2, "endurance" = -2)
				if(3) 
					effectedstats = list("speed" = -1, "strength" = -1, "endurance" = -2)
				if(4) 
					effectedstats = list("speed" = -1, "strength" = -1, "endurance" = -1)
				if(5)
					effectedstats = list("strength" = -1, "endurance" = -1)
				if(6)
					effectedstats = list("endurance" = -1)
			if(HAS_TRAIT(owner,TRAIT_WEAK_VEIL)) //if someone has a weak veil their vampirism level is just ignored
				effectedstats = list("speed" = -3, "strength" = -3, "endurance" = -3)
	return ..()

//may not include for Solaris, intended for a silent bite
/datum/status_effect/debuff/blood_tired
	id = "blood_tired"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/blood_tired
	effectedstats = list("speed" = -5)
	duration = 2.5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/blood_tired
	name = "Tired"
	desc = "Something has made me extremely tired, but I can't sleep it off"
	icon_state = "sleepy"

//a few weaknesses that could be applied to vampires or other antags
//makes you weak in the sun, applies to vampires with their veil down
/datum/status_effect/debuff/sun_curse
	id = "sun_curse"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/sun_curse
	effectedstats = list("strength" = -3,"perception" = -4, "constitution" = -2, "endurance" = -2,"speed" = -2, "fortune" = -2)
	duration = 1.5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/sun_curse
	name = "Sun Curse"
	desc = "The sun weakens me, I need to get back to the shade"
	icon_state = "hunger3"

//makes you weak being in salt water or having it thrown at you
/datum/status_effect/debuff/salt_curse
	id = "salt_curse"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/salt_curse
	effectedstats = list("strength" = -2,"perception" = -2, "constitution" = -2, "endurance" = -2,"speed" = -2)
	duration = 2.5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/salt_curse
	name = "Salt Curse"
	desc = "My BANE! The salt weakens me!"
	icon_state = "hunger3"

//makes you weak for touching clean water or salt water, but not sewer or sludge water
/datum/status_effect/debuff/water_curse
	id = "water_curse"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/water_curse
	effectedstats = list("strength" = -2,"perception" = -2, "constitution" = -2, "endurance" = -2,"speed" = -2)
	duration = 2.5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/water_curse
	name = "Water Curse"
	desc = "My BANE! Clean water weakens me!"
	icon_state = "hunger3"

//weakens those going into holy areas. 
/datum/status_effect/debuff/holy_curse
	id = "holy_curse"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/holy_curse
	effectedstats = list("strength" = -2,"perception" = -2, "constitution" = -2, "endurance" = -2, "fortune" = -2)
	duration = 2.5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/holy_curse
	name = "Holy Curse"
	desc = "My BANE! Holy areas weaken me!"
	icon_state = "hunger3"

//weakens creatures that want to see the sky
/datum/status_effect/debuff/indoor_fear
	id = "indoor_fear"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/indoor_fear
	effectedstats = list("strength" = -2,"perception" = -2, "endurance" = -2,"speed" = -2)
	duration = 10 SECONDS

/atom/movable/screen/alert/status_effect/debuff/indoor_fear
	name = "Indoors"
	desc = "Ugh, TOO CRAMPED! I need to see the sky!"
	icon_state = "hunger3"

//weakens certain monsters and people for being in town
/datum/status_effect/debuff/town_fear
	id = "town_fear"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/town_fear
	effectedstats = list("strength" = -1,"perception" = -1, "endurance" = -1,"speed" = -1)
	duration = 45 SECONDS

/atom/movable/screen/alert/status_effect/debuff/town_fear
	name = "Town Disgust"
	desc = "I HATE being in town, I CRAVE the wilds!"
	icon_state = "hunger3"
