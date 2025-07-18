//basic bloodsucker references
/datum/antagonist/bloodsucker
	name = "Bloodsucker"
	roundend_category = "Bloodsuckers"
	antagpanel_category = "Bloodsucker"
	job_rank = ROLE_BLOODSUCKER
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "vampire"
	//starting traits 
	var/list/inherent_traits = list(TRAIT_NOHUNGER, 
									TRAIT_NOBREATH, 
									TRAIT_TOXIMMUNE, 
									TRAIT_STEELHEARTED, 
									TRAIT_GRAVEROBBER,
									TRAIT_NOSLEEP, 
									TRAIT_VAMP_DREAMS,
									TRAIT_VAMPIRISM,)
	rogue_enabled = TRUE
	//starting disguised
	var/disguised = TRUE
	var/last_transform
	var/is_lesser = FALSE
	//caching a players looks, this has not worked before
	var/new_bloodsucker = FALSE
	var/ancient_bloodsucker = FALSE
	var/sired = FALSE
	var/obj/effect/proc_holder/spell/targeted/shapeshift/bat/batform //attached to the datum itself to avoid cloning memes, and other duplicates
	var/obj/effect/proc_holder/spell/targeted/shapeshift/gaseousform/gas

//inspection references, I don't ever see these ever working
/datum/antagonist/vampire/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/bloodsucker))
		return span_boldnotice("A bloodsucker, like me")
	if(istype(examined_datum, /datum/antagonist/bloodsucker/lesser))
		return span_boldnotice("A fledgling bloodsucker")
	if(istype(examined_datum, /datum/antagonist/vampire/lesser))
		return span_boldnotice("A child of Kain.")
	if(istype(examined_datum, /datum/antagonist/vampire))
		return span_boldnotice("An elder Kin.")
	if(examiner.Adjacent(examined))
		if(istype(examined_datum, /datum/antagonist/werewolf/lesser))
			if(!disguised)
				return span_boldwarning("I sense a lesser Werewolf.")
		if(istype(examined_datum, /datum/antagonist/werewolf))
			if(!disguised)
				return span_boldwarning("THIS IS AN ELDER WEREWOLF! MY ENEMY!")
	if(istype(examined_datum, /datum/antagonist/zombie))
		return span_boldnotice("Another deadite.")
	if(istype(examined_datum, /datum/antagonist/skeleton))
		return span_boldnotice("Another deadite.")

/datum/antagonist/vampire/lesser/roundend_report()
	return


//setup a process if someone is turned into a vampire midround
/datum/antagonist/bloodsucker/on_gain()
	var/datum/game_mode/C = SSticker.mode
	var/mob/living/carbon/human/H = owner.current
	var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
	C.bloodsuckers |= owner
	. = ..()
	owner.special_role = name

	if(owner.special_role == "bloodsucker")
		new_bloodsucker = FALSE
	if(owner.special_role == "ancient bloodsucker")
		ancient_bloodsucker = TRUE

	for(var/inherited_trait in inherent_traits)
		//ADD_TRAIT(owner.current, inherited_trait, "[type]") commenting out, need to find out where to set a "type"
		ADD_TRAIT(owner.current, inherited_trait, TRAIT_GENERIC)

	owner.current.cmode_music = 'sound/music/combat_vamp2.ogg'
	owner.adjust_skillrank(/datum/skill/magic/vampirism, 1, TRUE)
	owner.adjust_skillrank(/datum/skill/magic/blood, 1, TRUE)
	if(!new_bloodsucker)
		owner.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		owner.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/vampire_transfix)
	owner.current.AddSpell(new /obj/effect/proc_holder/spell/self/blood_veil)
	if (ancient_bloodsucker)
		owner.adjust_skillrank(/datum/skill/magic/vampirism, 5, TRUE)
		owner.adjust_skillrank(/datum/skill/magic/blood, 5, TRUE)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/vampire_blood_vision)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/vampire_subjugate)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/vampire_blood_lightning)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/vampire_blood_steal)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/recruitthrall)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/shapeshift/vampire_bat)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/shapeshift/vampire_mistform)

	if (new_bloodsucker)
		//we give fewer points to new spawn or those with a virtue
		owner.adjust_vamppoints(-1)
		forge_bloodsucker_objectives()
		finalize_bloodsucker_lesser()
		if (H.bs_spawn == 1)
			lesser_greet()
	if (ancient_bloodsucker)
		owner.adjust_vamppoints(6)
		forge_bloodsucker_objectives()
		finalize_bloodsucker_ancient()
		ancient_greet()
	if ((!new_bloodsucker)&&(!ancient_bloodsucker))
		//starting vampire points, raise or lower
		owner.adjust_vamppoints(2)
		forge_bloodsucker_objectives()
		finalize_bloodsucker()
		greet()

	//storing the player's sink tone
	H.cache_skin = H.skin_tone
	eyes.Remove(H)
	H.cache_eyes = eyes.eye_color
	eyes.Insert(H, TRUE, FALSE)
	H.cache_hair = H.hair_color 
	H.bloodsucker_disguise(H)

	H.bs_hair = H.hair_color 
	choose_skin_popup(H)
	choose_eye_popup(H)
	//choose_hair_popup(H) //hair currently doesn't update in a consistent way, going to skip this for now
	antag_headshot(H)
	return ..()

//setup a process if someone cured of vampirism
/datum/antagonist/bloodsucker/on_removal()
	var/mob/living/carbon/human/M = owner.current
	if(!silent && owner.current)
		to_chat(owner.current,span_danger("I am no longer a [job_rank]!"))
	owner.special_role = null
	if(!isnull(batform))
		owner.current.RemoveSpell(batform)
		QDEL_NULL(batform)

	

	M.mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	M.skin_tone = M.cache_skin
	M.hair_color = M.cache_hair
	M.facial_hair_color = M.cache_hair 
	M.eye_color = M.cache_eyes
	M.update_body()
	M.update_hair()
	M.update_body_parts(redraw = TRUE)
	M.mind.special_role = null
	//removing the starting traits
	REMOVE_TRAIT(M,TRAIT_STRONGBITE, MAGIC_TRAIT)
	REMOVE_TRAIT(M,TRAIT_NOHUNGER, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_NOBREATH, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_STEELHEARTED, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_NOSLEEP, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_VAMPMANSION, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_VAMP_DREAMS, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_VAMPIRISM,TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_GRAVEROBBER,TRAIT_GENERIC)
	//time to remove any perks and weaknesses they got
	REMOVE_TRAIT(M,TRAIT_VAMPIRISM, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_SUN_RESIST, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_SILVER_RESIST, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_HOLY_RESIST, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_SECONDLIFE, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_BLOOD_REGEN, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_LOW_METABOLISM, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_EFFICIENT_DRINKER, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_NOPAIN, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_SILENTBITE, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_WEAK_VEIL, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_NO_VEIL, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_HYDROPHOBIA, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_HIGH_METABOLISM, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_NOVEGAN, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_SUN_WEAKNESS, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_SILVER_WEAKNESS, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_HOLY_WEAKNESS, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_HALOPHOBIA, TRAIT_GENERIC)
	REMOVE_TRAIT(M,TRAIT_PERMADUST, TRAIT_GENERIC)
	//removing vampire ranks
	M.mind.adjust_skillrank(/datum/skill/magic/vampirism, -6, TRUE)
	M.mind.adjust_skillrank(/datum/skill/magic/blood, -6, TRUE)
	//setting their wrestling and unarmed down, they are a weak mortal now
	M.mind.adjust_skillrank(/datum/skill/combat/wrestling, -1, TRUE)
	M.mind.adjust_skillrank(/datum/skill/combat/unarmed, -1, TRUE)
	//time to remove any spells they got
	M.mind?.vamp_points = 0
	M.mind?.used_vamp_points = 0
	M.mind?.adjust_vamppoints(1)
	M.mind?.adjust_vamppoints(-1)
	M.RemoveSpell(/obj/effect/proc_holder/spell/targeted/vampire_transfix)
	M.RemoveSpell(/obj/effect/proc_holder/spell/self/blood_veil)
	M.RemoveSpell(/obj/effect/proc_holder/spell/self/learnvampspell)
	
	M.RemoveSpell(/obj/effect/proc_holder/spell/)
	M.remove_status_effect(/datum/status_effect/debuff/veil_up)
	M.remove_status_effect(/datum/status_effect/buff/veil_down)

	var/list/vamp_choices = list()
	vamp_choices  += GLOB.learnable_vamp_spells

	for(var/vamp_choice in vamp_choices)
		M.RemoveSpell(vamp_choice)
	return ..()

//populate their objectives
/datum/antagonist/bloodsucker/proc/add_objective(datum/objective/O)
	objectives += O

/datum/antagonist/bloodsucker/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/bloodsucker/proc/forge_bloodsucker_objectives()
	if(!(locate(/datum/objective/escape) in objectives))
		var/datum/objective/bloodsucker/escape_objective = new
		escape_objective.owner = owner
		add_objective(escape_objective)
		return

//announcement to the player they are a vampire
/datum/antagonist/bloodsucker/greet()
	to_chat(owner.current, span_userdanger("Ever since that bite, I have been a VAMPIRE."))
	owner.announce_objectives()
	..()
/datum/antagonist/bloodsucker/proc/lesser_greet()
	to_chat(owner.current, span_userdanger("I awaken with a terrible thirst. I must learn from other vampires and become more powerful"))
	owner.announce_objectives()

/datum/antagonist/bloodsucker/proc/ancient_greet()
	to_chat(owner.current, span_userdanger("I awaken from years of slumber, what has changed in this land?"))
	owner.announce_objectives()

//finalize becoming a vampire
/datum/antagonist/bloodsucker/proc/finalize_bloodsucker()
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)

/datum/antagonist/bloodsucker/proc/finalize_bloodsucker_lesser()
	var/mob/living/carbon/human/spawn_check =owner.current
	if(!sired)
		owner.current.forceMove(pick(GLOB.vspawn_starts))
	if(spawn_check.bs_spawn == 1) //we do this to avoid spamming music to virtue thralls
		owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)

/datum/antagonist/bloodsucker/proc/finalize_bloodsucker_ancient()
	if(!sired)
		owner.current.forceMove(pick(GLOB.vlord_starts))
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)

// SPAWN
/datum/antagonist/bloodsucker/lesser
	name = "Fledgling Bloodsucker"
	antag_hud_name = "Vspawn"
	inherent_traits = list(TRAIT_NOHUNGER, 
						   TRAIT_NOBREATH, 
						   TRAIT_TOXIMMUNE, 
						   TRAIT_STEELHEARTED, 
						   TRAIT_GRAVEROBBER,
						   TRAIT_NOSLEEP, 
						   TRAIT_ZOMBIE_IMMUNE,
						   TRAIT_VAMP_DREAMS,
						   TRAIT_VAMPIRISM,)
	new_bloodsucker = TRUE

// Ancient
/datum/antagonist/bloodsucker/ancient
	//a strong set of skills for an ancient vampire, but with a fatal few weaknesses and they can be dusted.
	name = "Ancient Bloodsucker"
	antag_hud_name = "Vancient"
	inherent_traits = list(TRAIT_STRONGBITE, 
						   TRAIT_NOHUNGER, 
						   TRAIT_NOBREATH, 
						   TRAIT_TOXIMMUNE, 
						   TRAIT_STEELHEARTED, 
						   TRAIT_GRAVEROBBER,
						   TRAIT_NOSLEEP, 
						   TRAIT_ZOMBIE_IMMUNE,
						   TRAIT_VAMPMANSION, 
						   TRAIT_VAMP_DREAMS,
						   TRAIT_VAMPIRISM,
						   TRAIT_NOBLE,
						   TRAIT_NOPAIN,
						   TRAIT_NOROGSTAM, 
						   TRAIT_HEAVYARMOR, 
						   TRAIT_COUNTERCOUNTERSPELL,
						   TRAIT_LOW_METABOLISM,
						   TRAIT_EFFICIENT_DRINKER,
						   TRAIT_NOVEGAN,
						   TRAIT_PERMADUST,)
	new_bloodsucker = FALSE



// OBJECTIVES STORED HERE TEMPORARILY FOR EASE OF REFERENCE
/datum/objective/bloodsucker/announce
	name = "announce"
	explanation_text = "Sit on the thrown and let others know of Vampire's existance"
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/bloodsucker/announce/check_completion()
	return TRUE

/datum/objective/bloodsucker/infiltrate/one
	name = "infiltrate1"
	explanation_text = "Make a new fledgingling to carry on this era"
	triumph_count = 5

/datum/objective/bloodsucker/infiltrate/one/check_completion()
	//var/datum/game_mode/chaosmode/C = SSticker.mode
	//for(var/datum/mind/V in C.bloodsucker)
	//need a way to see if the player turned someone 
	return TRUE

/datum/objective/sun/drink
	name = "Drink"
	explanation_text = "I must Drink 3000 litres of Vitae"
	triumph_count = 1

/datum/objective/bloodsuckersurvive/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(!C.vlord.stat)
		return TRUE

/datum/objective/bloodsuckersurvive
	name = "survive"
	explanation_text = "I must survive to see the next Era"
	triumph_count = 3

/datum/objective/bloodsuckersurvive/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(!C.vlord.stat)
		return TRUE


/datum/antagonist/bloodsucker/roundend_report()
	return //just escaping out of amy antag reports for right now
	/*
	var/traitorwin = TRUE
	printplayer(owner)
	
	var/count = 0
	if(!new_bloodsucker) // don't need to spam up the chat with all spawn
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				else
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
					traitorwin = FALSE
				count += objective.triumph_count
	else
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(world, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				else
					to_chat(world, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
					traitorwin = FALSE
				count += objective.triumph_count

	var/special_role_text = lowertext(name)
	if(traitorwin)
		if(count)
			if(owner)
				owner.adjust_triumphs(count)
		to_chat(world, span_greentext("The [special_role_text] has TRIUMPHED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(world, span_redtext("The [special_role_text] has FAILED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)
	*/

// LANDMARKS

/obj/effect/landmark/start/bloodsucker
	name = "Bloodsucker Respawn"
	icon_state = "arrow"
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/bloodsucker/Initialize()
	. = ..()
	GLOB.secondlife_respawns += loc

//skin and hair color customizations		
/datum/antagonist/bloodsucker/proc/choose_skin_popup(mob/user)
	if(QDELETED(src))
		return
	var/mob/living/carbon/human/BSDrinker = user
	var/new_s_tone = input(BSDrinker, "Choose your unveild skin tone:", "Race change")  as null|anything in GLOB.vamp_skin_tones

	switch(new_s_tone)
		if("Pale")
			BSDrinker.bs_skin = "C9D3DE"
		if("Greyferatu")
			BSDrinker.bs_skin = "7C8A97"
		if("Jiangshi")
			BSDrinker.bs_skin = "97C9EA"
		if("Shadowed")
			BSDrinker.bs_skin = "2B2B3C"

	if(BSDrinker.has_status_effect(/datum/status_effect/buff/veil_down))
		BSDrinker.apply_status_effect(/datum/status_effect/debuff/veil_up)
		BSDrinker.remove_status_effect(/datum/status_effect/buff/veil_down)
		BSDrinker.apply_status_effect(/datum/status_effect/buff/veil_down)
		BSDrinker.remove_status_effect(/datum/status_effect/debuff/veil_up)

/datum/antagonist/bloodsucker/proc/choose_hair_popup(mob/user)
	var/mob/living/carbon/human/BSDrinker = user
	var/new_hair_color = input(BSDrinker, "Choose your hair color", "Hair Color","#"+BSDrinker.hair_color) as color|null
	if(new_hair_color)
		BSDrinker.bs_hair = sanitize_hexcolor(new_hair_color)
	else
		return
	if(BSDrinker.has_status_effect(/datum/status_effect/buff/veil_down))
		BSDrinker.apply_status_effect(/datum/status_effect/debuff/veil_up)
		BSDrinker.remove_status_effect(/datum/status_effect/buff/veil_down)
		BSDrinker.apply_status_effect(/datum/status_effect/buff/veil_down)
		BSDrinker.remove_status_effect(/datum/status_effect/debuff/veil_up)

/datum/antagonist/bloodsucker/proc/choose_eye_popup(mob/user)
	var/mob/living/carbon/human/BSDrinker = user
	var/new_eye_color = color_pick_sanitized(user, "Choose your eye color", "Eye Color", BSDrinker.eye_color)
	if(new_eye_color)
		new_eye_color = sanitize_hexcolor(new_eye_color, 6, TRUE)
		BSDrinker.bs_eyes = new_eye_color
	if(BSDrinker.has_status_effect(/datum/status_effect/buff/veil_down))
		BSDrinker.apply_status_effect(/datum/status_effect/debuff/veil_up)
		BSDrinker.remove_status_effect(/datum/status_effect/buff/veil_down)
		BSDrinker.apply_status_effect(/datum/status_effect/buff/veil_down)
		BSDrinker.remove_status_effect(/datum/status_effect/debuff/veil_up)

/datum/antagonist/bloodsucker/proc/antag_headshot(mob/user)
	var/mob/living/carbon/human/BSDrinker = user
	to_chat(user, "<span class='notice'>Please use a relatively SFW image of the head and shoulder area to maintain immersion level. <b>Do not use a real life photo or unserious images.</b></span>")
	to_chat(user, "<span class='notice'>Ensure it's a direct image link. The photo will be resized to 325x325 pixels.</span>")
	var/new_headshot_link = input(user, "Input the headshot link (https, hosts: gyazo, discord, lensdump, imgbox, catbox):", "Headshot", BSDrinker.antag_headshot_link) as text|null
	if(new_headshot_link == null)
		return
	if(new_headshot_link == "")
		BSDrinker.antag_headshot_link = null
		return
	if(!valid_headshot_link(user, new_headshot_link))
		BSDrinker.antag_headshot_link = null
		return
	BSDrinker.antag_headshot_link = new_headshot_link
	to_chat(user, "<span class='notice'>Successfully updated Antag headshot picture</span>")
	log_game("[user] has set their Antag Headshot image to '[BSDrinker.antag_headshot_link]'.")

/* this is only for testing.
/mob/living/carbon/human/verb/become_bloodsucker()
	//set category = "DEBUGTEST"
	set name = "BLOODSUCKER"
	if(mind)
		var/datum/antagonist/bloodsucker/new_antag = new /datum/antagonist/bloodsucker()
		mind.add_antag_datum(new_antag)
*/
