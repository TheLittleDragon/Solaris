/obj/effect/proc_holder/spell/invoked/vampire_greaterregenerate
	name = "Greater Vampiric Regeneration"
	desc = "Regenerate using half of my blood (300 used minimum)"
	cost = 2 //how many points it takes
	xp_gain = TRUE
	releasedrain = 0
	chargedrain = 1
	chargetime = 1 SECONDS
	warnie = "spellwarning"
	school = "blood"
	no_early_release = TRUE
	movement_interrupt = FALSE
	spell_tier = 1 // What vampire level are we?
	invocation = "Saguine Regeneratio"
	invocation_type = "whisper"
	charging_slowdown = 300
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood
	goodtrait = null //is there a good trait we want to associate? the code name
	badtrait = TRAIT_VAMP_HEAL_LIMIT //is there a bad trait we want to associate? the code name
	badtraitname = "Healing Abilities Limit" //is there a bad trait we want to associate? the player name
	badtraitdesc = "You can only have one ability that gives a heal. Affects regeneration, passive regeneration, batform, and mistform" //is there a bad trait we want to associate? the player description
	recharge_time = 3 MINUTES
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM
	vitaedrain = 300

/obj/effect/proc_holder/spell/invoked/vampire_greaterregenerate/cast(list/targets, mob/living/user)
	if(isliving(user))
		var/mob/living/carbon/human/BSDrinker = user
		var/silver_curse_status = FALSE
		var/temp_vitae = BSDrinker.vitae
		silver_curse_status = BSDrinker.has_status_effect(/datum/status_effect/debuff/silver_curse)
		if(!BSDrinker == user)
			recharge_time = 1 SECONDS
			to_chat(BSDrinker, span_warning("I can only regenerate myself"))
			return
		if(silver_curse_status)
			to_chat(BSDrinker, span_warning("My BANE is not letting me heal!."))
			return
		if(!HAS_TRAIT(BSDrinker,TRAIT_VAMPIRISM))
			to_chat(BSDrinker, span_warning("I'm not a vampire, what am I doing?"))
			return
		if(BSDrinker.has_status_effect(/datum/status_effect/debuff/veil_up))
			to_chat(BSDrinker, span_warning("My curse is hidden."))
			return
		if(BSDrinker.vitae < 2*vitaedrain)
			to_chat(BSDrinker, span_warning("Not enough vitae."))
			return

		if(BSDrinker.vitae > 2*vitaedrain)
			BSDrinker.vitae -= temp_vitae/2
		else
			BSDrinker.vitae -= vitaedrain
		BSDrinker.fully_heal()
		BSDrinker.regenerate_limbs()
		BSDrinker.vitae -= vitaedrain
		to_chat(BSDrinker, span_greentext("! REGENERATE !"))
		BSDrinker.playsound_local(get_turf(BSDrinker), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
/* we can apply a buff and a glow if we want to telegraph this
#define VAMPIRIC_FILTER "vampiric_glow"


/datum/status_effect/buff/vampire_regenerate/on_apply()
	. = ..()
	var/filter = owner.get_filter(VAMPIRIC_FILTER)
	if (!filter)
		owner.add_filter(VAMPIRIC_FILTER, 2, list("type" = "outline", "color" = "#8B0000", "alpha" = 100, "size" = 1))

/datum/status_effect/buff/vampire_regenerate/on_remove()
	. = ..()
	to_chat(owner, span_warning("My fortitude leaves me"))
	owner.remove_filter(VAMPIRIC_FILTER)

#undef VAMPIRIC_FILTER

*/
