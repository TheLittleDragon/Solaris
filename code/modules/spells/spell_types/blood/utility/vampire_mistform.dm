/obj/effect/proc_holder/spell/targeted/shapeshift/vampire_mistform
	name = "Mist Form"
	desc = "Transform into mist"
	cost = 3 // a mobility form, setting high
	//charge_max = 50
	cooldown_min = 50
	die_with_shapeshifted_form =  FALSE
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/vampiregaseousform
	xp_gain = TRUE
	releasedrain = 0
	chargedrain = 1
	chargetime = 1 SECONDS
	warnie = "spellwarning"
	school = "blood"
	no_early_release = TRUE
	movement_interrupt = FALSE
	spell_tier = 3 // What vampire level are we?
	invocation = ""
	invocation_type = "whisper"
	charging_slowdown = 60
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood
	recharge_time = 1 MINUTES
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM
	vitaedrain = 100
	xp_gain = TRUE
	goodtrait = null //is there a good trait we want to associate? the code name
	badtrait = null //TRAIT_VAMP_HEAL_LIMIT //is there a bad trait we want to associate? the code name
	badtraitname = null //"Healing Abilities Limit" //is there a bad trait we want to associate? the player name
	badtraitdesc = null //"You can only have one ability that gives a heal. Affects regeneration, passive regeneration, batform, and mistform" //is there a bad trait we want to associate? the player description


/*
/obj/effect/proc_holder/spell/targeted/shapeshift/vampire_mistform/cast(list/targets, mob/living/user = usr)
	var/mob/living/carbon/human/BSDrinker = usr
	//var/temp_vitae = H.vitae //use this to store vitae if we need a dynamic cost

	/*Left here if we want to nerf a skill with a silver curse
	silver_curse_status = H.has_status_effect(/datum/status_effect/debuff/silver_curse)
	if(silver_curse_status)
		to_chat(H, span_warning("My BANE is not letting me use this ability!."))
		return */

	if(!HAS_TRAIT(BSDrinker,TRAIT_VAMPIRISM))
		to_chat(BSDrinker, span_warning("I'm not a vampire, what am I doing?"))
		return
	if(BSDrinker.has_status_effect(/datum/status_effect/debuff/veil_up))
		to_chat(BSDrinker, span_warning("My curse is hidden."))
		return
	if(BSDrinker.vitae < vitaedrain)
		to_chat(BSDrinker, span_warning("Not enough vitae."))
		return
	if(BSDrinker.has_status_effect(/datum/status_effect/buff/vampire_mistform))
		to_chat(BSDrinker, span_warning("Already active."))
		return
	BSDrinker.vitae -= vitaedrain
	to_chat(BSDrinker, span_greentext("! MIST !"))
	BSDrinker.playsound_local(get_turf(BSDrinker), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
	//ADD_TRAIT(src, TRAIT_NOFALLDAMAGE2, MAGIC_TRAIT)
	to_chat(BSDrinker, span_warning("mistform"))
	addtimer(CALLBACK(BSDrinker, to_chat(BSDrinker, span_warning("I'm about to change back"))), 25 SECONDS)
*/
