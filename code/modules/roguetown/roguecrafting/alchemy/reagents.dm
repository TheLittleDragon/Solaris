// Catalyst. This reagent combined with normal potion reagent makes the strong potion reagent. Reactions defined by the end of this doccument
/datum/reagent/additive
	name = "additive"
	reagent_state = LIQUID

//Potions
/datum/reagent/medicine/healthpot
	name = "Health Potion"
	description = "Gradually regenerates all types of damage."
	reagent_state = LIQUID
	color = "#ff0000"
	taste_description = "lifeblood"
	overdose_threshold = 0
	metabolization_rate = REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/healthpot/on_mob_life(mob/living/carbon/M)
	if(volume >= 60)
		M.reagents.remove_reagent(/datum/reagent/medicine/healthpot, 2) //No overhealing.
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+20, BLOOD_VOLUME_MAXIMUM)
	var/list/wCount = M.get_wounds()
	if(wCount.len > 0)
		M.heal_wounds(3) //at a motabalism of .5 U a tick this translates to 120WHP healing with 20 U Most wounds are unsewn 15-100. This is powerful on single wounds but rapidly weakens at multi wounds.
	if(volume > 0.99)
		M.adjustBruteLoss(-1.75*REM, 0)
		M.adjustFireLoss(-1.75*REM, 0)
		M.adjustOxyLoss(-1.25, 0)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -5*REM)
		M.adjustCloneLoss(-1.75*REM, 0)
	..()

/datum/reagent/medicine/stronghealth
	name = "Strong Health Potion"
	description = "Quickly regenerates all types of damage."
	color = "#820000be"
	taste_description = "rich lifeblood"
	metabolization_rate = REAGENTS_METABOLISM * 3

/datum/reagent/medicine/stronghealth/on_mob_life(mob/living/carbon/M)
	if(volume >= 60)
		M.reagents.remove_reagent(/datum/reagent/medicine/healthpot, 2) //No overhealing.
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+80, BLOOD_VOLUME_MAXIMUM)
	else
		//can overfill you with blood, but at a slower rate
		M.blood_volume = min(M.blood_volume+10, BLOOD_VOLUME_MAXIMUM)
	var/list/wCount = M.get_wounds()
	if(wCount.len > 0)
		M.heal_wounds(6) //at a motabalism of .5 U a tick this translates to 240WHP healing with 20 U Most wounds are unsewn 15-100.
	if(volume > 0.99)
		M.adjustBruteLoss(-7*REM, 0)
		M.adjustFireLoss(-7*REM, 0)
		M.adjustOxyLoss(-5, 0)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -5*REM)
		M.adjustCloneLoss(-7*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/gender_potion
	name = "Gender Potion"
	description = "Change the user's gender."
	reagent_state = LIQUID
	color = "#FF33FF"
	taste_description = "organic scent"
	overdose_threshold = 0
	metabolization_rate = REAGENTS_METABOLISM * 5
	alpha = 173

/datum/reagent/medicine/gender_potion/on_mob_life(mob/living/carbon/M)
	if(!istype(M) || M.stat == DEAD)
		to_chat(M, span_warning("The potion can only be used on living things!"))
		return
	if(M.gender != MALE && M.gender != FEMALE)
		to_chat(M, span_warning("The potion can only be used on gendered things!"))
		return
	if(M.gender == MALE)
		M.gender = FEMALE
		M.visible_message(span_boldnotice("[M] suddenly looks more feminine!"), span_boldwarning("You suddenly feel more feminine!"))
	else
		M.gender = MALE
		M.visible_message(span_boldnotice("[M] suddenly looks more masculine!"), span_boldwarning("You suddenly feel more masculine!"))
	M.regenerate_icons()
	..()

//Someone please remember to change this to actually do mana at some point?
/datum/reagent/medicine/manapot
	name = "Mana Potion"
	description = "Gradually regenerates energy."
	reagent_state = LIQUID
	color = "#0000ff"
	taste_description = "sweet mana"
	overdose_threshold = 0
	metabolization_rate = REAGENTS_METABOLISM
	alpha = 173

//Turns out that Stamina is in reality the Blue bar.
/datum/reagent/medicine/manapot/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M,TRAIT_NOROGSTAM))
		M.rogstam_add(30) //15 oz of mana potion = 45u. With default metabolism ticking 1u, you can regen 1350 rogstam in one bottle. A 10 Endurance character has by default 1000 rogstam maximum
	..()

/datum/reagent/medicine/strongmana
	name = "Strong Mana Potion"
	description = "Rapidly regenerates energy."
	color = "#000080"
	taste_description = "raw power"
	metabolization_rate = REAGENTS_METABOLISM * 3

//Turns out that Stamina is in reality the Blue bar.
/datum/reagent/medicine/strongmana/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M,TRAIT_NOROGSTAM))
		M.rogstam_add(120)
	..()

/datum/reagent/medicine/stampot
	name = "Stamina Potion"
	description = "Gradually regenerates stamina."
	reagent_state = LIQUID
	color = "#13df00"
	taste_description = "sweet tea"
	overdose_threshold = 0
	metabolization_rate = REAGENTS_METABOLISM
	alpha = 173

//Despite the name, the green bar is actually Fatigue in the code.
/datum/reagent/medicine/stampot/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M,TRAIT_NOROGSTAM))
		M.rogfat_add(-20) //The less rogfat you have, the fuller the green bar is. This should make sprinting last longer, and mitigate combat consumption. Your maximum rogfat is a tenth of your maximum rogstam
	..()

/datum/reagent/medicine/strongstam
	name = "Strong Stamina Potion"
	description = "Rapidly regenerates stamina."
	color = "#129c00"
	taste_description = "sparkling static"
	metabolization_rate = REAGENTS_METABOLISM * 3

//Despite the name, the green bar is actually Fatigue in the code.
/datum/reagent/medicine/strongstam/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M,TRAIT_NOROGSTAM))
		M.rogfat_add(-50)  //The less rogfat you have, the fuller the green bar is. Should make sprinting last forever while you chug this. But metabolizes only twice per sip. More like of a second wind if using mid combat.
	..()

/datum/reagent/medicine/antidote
	name = "Poison Antidote"
	description = "A mild detoxifying agent."
	reagent_state = LIQUID
	color = "#ccccff"
	taste_description = "cleansing river water"
	metabolization_rate = REAGENTS_METABOLISM

/datum/reagent/medicine/antidote/on_mob_life(mob/living/carbon/M)
	if(volume > 0.99)
		M.adjustToxLoss(-4, 0)
	..()
	. = 1

/datum/reagent/medicine/diseasecure
	name = "Disease Cure"
	description = "A potent detoxifying agent."
	reagent_state = LIQUID
	color = "#cc99ff"
	taste_description = "sweet salvation"
	metabolization_rate = REAGENTS_METABOLISM * 3

/datum/reagent/medicine/diseasecure/on_mob_life(mob/living/carbon/M)
	if(volume > 0.99)
		M.adjustToxLoss(-16, 0)
	..()
	. = 1

//Buff potions
/datum/reagent/buff
	description = ""
	reagent_state = LIQUID
	metabolization_rate = REAGENTS_METABOLISM

/datum/reagent/buff/strength
	name = "Strength"
	color = "#800000"
	taste_description = "burning fire and invigoration"

/datum/reagent/buff/strength/on_mob_add(mob/living/carbon/M)
	testing("str pot in system")
	if(M.has_status_effect(/datum/status_effect/buff/alch/strengthpot))
		return ..()
	if(M.reagents.has_reagent(/datum/reagent/buff/strength,4))
		M.apply_status_effect(/datum/status_effect/buff/alch/strengthpot)
		M.reagents.remove_reagent(/datum/reagent/buff/strength, M.reagents.get_reagent_amount(/datum/reagent/buff/strength))
	return ..()

/datum/reagent/buff/perception
	name = "Perception"
	color = "##ffc34d"
	taste_description = "a chalky, bitter awareness"

/datum/reagent/buff/perception/on_mob_life(mob/living/carbon/M)
	testing("per pot in system")
	if(M.has_status_effect(/datum/status_effect/buff/alch/perceptionpot))
		return ..()
	if(M.reagents.has_reagent((/datum/reagent/buff/perception),4))
		M.apply_status_effect(/datum/status_effect/buff/alch/perceptionpot)
		M.reagents.remove_reagent(/datum/reagent/buff/perception, M.reagents.get_reagent_amount(/datum/reagent/buff/perception))
	return ..()

/datum/reagent/buff/intelligence
	name = "Intelligence"
	color = "#00b386"
	taste_description = "a spark of enlightenment"

/datum/reagent/buff/intelligence/on_mob_life(mob/living/carbon/M)
	testing("int pot in system")
	if(M.has_status_effect(/datum/status_effect/buff/alch/intelligencepot))
		return ..()
	if(M.reagents.has_reagent((/datum/reagent/buff/intelligence),4))
		M.apply_status_effect(/datum/status_effect/buff/alch/intelligencepot)
		M.reagents.remove_reagent(/datum/reagent/buff/intelligence, M.reagents.get_reagent_amount(/datum/reagent/buff/intelligence))
	return ..()

/datum/reagent/buff/constitution
	name = "Constitution"
	color = "#d9bfcc"
	taste_description = "the will to persevere"

/datum/reagent/buff/constitution/on_mob_life(mob/living/carbon/M)
	testing("con pot in system")
	if(M.has_status_effect(/datum/status_effect/buff/alch/constitutionpot))
		return ..()
	if(M.reagents.has_reagent((/datum/reagent/buff/constitution),4))
		M.apply_status_effect(/datum/status_effect/buff/alch/constitutionpot)
		M.reagents.remove_reagent(/datum/reagent/buff/constitution, M.reagents.get_reagent_amount(/datum/reagent/buff/constitution))
	return ..()

/datum/reagent/buff/endurance
	name = "Endurance"
	color = "#5c8a8a"
	taste_description = "a blessed second wind"

/datum/reagent/buff/endurance/on_mob_life(mob/living/carbon/M)
	testing("end pot in system")
	if(M.has_status_effect(/datum/status_effect/buff/alch/endurancepot))
		return ..()
	if(M.reagents.has_reagent((/datum/reagent/buff/endurance),4))
		M.apply_status_effect(/datum/status_effect/buff/alch/endurancepot)
		M.reagents.remove_reagent(/datum/reagent/buff/endurance, M.reagents.get_reagent_amount(/datum/reagent/buff/endurance))
	return ..()

/datum/reagent/buff/speed
	name = "Speed"
	color = "#99ddff"
	taste_description = "carbonated, energized herbs"

/datum/reagent/buff/speed/on_mob_life(mob/living/carbon/M)
	testing("spd pot in system")
	if(M.has_status_effect(/datum/status_effect/buff/alch/speedpot))
		return ..()
	if(M.reagents.has_reagent((/datum/reagent/buff/speed),4))
		M.apply_status_effect(/datum/status_effect/buff/alch/speedpot)
		M.reagents.remove_reagent(/datum/reagent/buff/speed, M.reagents.get_reagent_amount(/datum/reagent/buff/speed))
	return ..()

/datum/reagent/buff/fortune
	name = "Fortune"
	color = "#ff9900"
	taste_description = "lavish riches on the tongue"

/datum/reagent/buff/fortune/on_mob_life(mob/living/carbon/M)
	testing("luck pot in system")
	if(M.has_status_effect(/datum/status_effect/buff/alch/fortunepot))
		return ..()
	if(M.reagents.has_reagent((/datum/reagent/buff/fortune),4))
		M.apply_status_effect(/datum/status_effect/buff/alch/fortunepot)
		M.reagents.remove_reagent(/datum/reagent/buff/fortune, M.reagents.get_reagent_amount(/datum/reagent/buff/fortune))
	return ..()


//Poisons
/* Tested this quite a bit. Heres the deal. Metabolism REAGENTS_SLOW_METABOLISM is 0.1 and needs to be that so poison isnt too fast working but
still is dangerous. Toxloss of 3 at metabolism 0.1 puts you in dying early stage then stops for reference of these values.
A dose of ingested potion is defined as 5u, projectile deliver at most 2u, you already do damage with projectile, a bolt can only feasible hold a tiny amount of poison, so much easier to deliver than ingested and so on.
If you want to expand on poisons theres tons of fun effects TG chemistry has that could be added, randomzied damage values for more unpredictable poison, add trait based resists instead of the clunky race check etc.*/

/datum/reagent/berrypoison	// Weaker poison, balanced to make you wish for death and incapacitate but not kill
	name = "Berry Poison"
	description = "A sickening liquid that decently toxifies."
	reagent_state = LIQUID
	color = "#264670"
	taste_description = "bitterness"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM

/datum/reagent/berrypoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER))	
		if(volume > 0.09)
			if(isdwarf(M))
				M.add_nausea(1)
				M.adjustToxLoss(0.5)
			else
				M.add_nausea(3) // so one berry or one dose (one clunk of extracted poison, 5u) will make you really sick and a hair away from crit.
				M.adjustToxLoss(2)
	return ..()


/datum/reagent/strongpoison		// Strong poison, meant to be somewhat difficult to produce using alchemy or spawned with select antags. Designed to kill in one full dose (5u) better drink antidote fast
	name = "Strong Poison"
	description = "An extremely potent liquid that kills quickly."
	reagent_state = LIQUID
	color = "#06151c"
	taste_description = "burning"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM

/datum/reagent/strongpoison/on_mob_life(mob/living/carbon/M)
	testing("Someone was poisoned")
	if(volume > 0.09)
		if(isdwarf(M))
			M.add_nausea(1)
			M.adjustToxLoss(2.3)  // will put you just above dying crit treshold
		else
			M.add_nausea(6) //So a poison bolt (2u) will eventually cause puking at least once
			M.adjustToxLoss(4.5) // just enough so 5u will kill you dead with no help
	return ..()

/datum/reagent/organpoison
	name = "Organ Poison"
	description = ""
	reagent_state = LIQUID
	color = "#2c1818"
	taste_description = "sour meat"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM

/datum/reagent/organpoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER))
		M.add_nausea(9)
		M.adjustToxLoss(2)
	return ..()

/datum/reagent/stampoison
	name = "Stamina Poison"
	description = "Gradually drains your stamina."
	reagent_state = LIQUID
	color = "#083b1c"
	taste_description = "breathlessness"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM * 3

/datum/reagent/stampoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M,TRAIT_NOROGSTAM))
		M.rogfat_add(2) //Slowly leech the green bar. Sort of similar at how fast sprinting drains your stamina. With a slow metabolization, this poison is more of a stamina blocker. Can still lock someone in stam crit if thex exhert too much while this poison is active.
	return ..()

/datum/reagent/strongstampoison
	name = "Strong Stamina Poison"
	description = "Quickly drains your stamina."
	reagent_state = LIQUID
	color = "#041d0e"
	taste_description = "frozen air"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM * 9

/datum/reagent/strongstampoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M,TRAIT_NOROGSTAM))
		M.rogfat_add(20) //Rapidly leech stamina. Drains faster, but lasts less. Should ideally be able to neutralize someone out of combat in one application.
	return ..()


/datum/reagent/killersice
	name = "Killer's Ice"
	description = ""
	reagent_state = LIQUID
	color = "#c8c9e9"
	taste_description = "cold needles"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM

/datum/reagent/killersice/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER))
		M.adjustToxLoss(5)
	return ..()


//Potion reactions
/datum/chemical_reaction/alch/stronghealth
	name = "Strong Health Potion"
	id = /datum/reagent/medicine/stronghealth
	results = list(/datum/reagent/medicine/stronghealth = 1)
	required_reagents = list(/datum/reagent/medicine/healthpot = 1, /datum/reagent/additive = 1)
	mix_message = "The cauldron glows for a moment."

/datum/chemical_reaction/alch/strongmana
	name = "Strong Mana Potion"
	id = /datum/reagent/medicine/strongmana
	results = list(/datum/reagent/medicine/strongmana = 1)
	required_reagents = list(/datum/reagent/medicine/manapot = 1, /datum/reagent/additive = 1)
	mix_message = "The cauldron glows for a moment."

/datum/chemical_reaction/alch/strongstam
	name = "Strong Stamina Potion"
	id = /datum/reagent/medicine/strongstam
	results = list(/datum/reagent/medicine/strongstam = 1)
	required_reagents = list(/datum/reagent/medicine/stampot = 1, /datum/reagent/additive = 1)
	mix_message = "The cauldron glows for a moment."

/datum/chemical_reaction/alch/strongpoison
	name = "Strong Health Poison"
	id = /datum/reagent/strongpoison
	results = list(/datum/reagent/strongpoison = 1)
	required_reagents = list(/datum/reagent/berrypoison = 1, /datum/reagent/additive = 1)
	mix_message = "The cauldron glows for a moment."

/datum/chemical_reaction/alch/strongstampoison
	name = "Strong Stamina Leech Potion"
	id = /datum/reagent/strongstampoison
	results = list(/datum/reagent/strongstampoison = 1)
	required_reagents = list(/datum/reagent/stampoison = 1, /datum/reagent/additive = 1)
	mix_message = "The cauldron glows for a moment."



/*----------\
|Ingredients|
\----------*/
/datum/reagent/undeadash
	name = "Spectral Powder"
	description = ""
	reagent_state = SOLID
	color = "#330066"
	taste_description = "tombstones"
	metabolization_rate = 0.1

/datum/reagent/toxin/fyritiusnectar
	name = "fyritius nectar"
	description = "oh no"
	reagent_state = LIQUID
	color = "#ffc400"
	metabolization_rate = 0.5

/datum/reagent/toxin/fyritiusnectar/on_mob_life(mob/living/carbon/M)
	if(volume > 0.49)
		M.add_nausea(9)
		M.adjustFireLoss(2, 0)
		M.adjust_fire_stacks(1)
		M.IgniteMob()
	return ..()
//I'm stapling our infection reagents on the bottom, because IDEK where else to put them.

/datum/reagent/infection
	name = "excess choleric humour"
	description = "Red-yellow pustulence - the carrier of disease."
	reagent_state = LIQUID
	color = "#dfe36f"
	metabolization_rate = 0.1
	var/damage_tick = 0.3
	var/lethal_fever = FALSE
	var/fever_multiplier = 1

/datum/reagent/infection/on_mob_life(mob/living/carbon/M)
	var/heat = (BODYTEMP_AUTORECOVERY_MINIMUM + clamp(volume, 3, 15)) * fever_multiplier
	M.adjustToxLoss(damage_tick, 0)
	if (lethal_fever)
		M.adjust_bodytemperature(heat, 0)
		if (prob(5))
			to_chat(M, span_warning("A wicked heat settles within me... I feel ill. Very ill."))
	else
		M.adjust_bodytemperature(heat, 0, BODYTEMP_HEAT_DAMAGE_LIMIT - 1)
		if (prob(5))
			to_chat(M, span_warning("I feel a horrible chill despite the sweat rolling from my brow..."))
	return ..()

/datum/reagent/infection/minor
	name = "disrupted choleric humor"
	description = "Symptomatic of disrupted humours."
	damage_tick = 0.1
	lethal_fever = FALSE

/datum/reagent/infection/major
	name = "excess melancholic humour"
	description = "Kingsfield's Bane. Excess melancholic has killed thousands."
	damage_tick = 1
	lethal_fever = TRUE
	fever_multiplier = 3

/datum/reagent/infection/major/on_mob_life(mob/living/carbon/M)
	if (M.badluck(1))
		M.reagents.add_reagent(src, rand(1,3))
		to_chat(M, span_small("I feel even worse..."))
	return ..()

