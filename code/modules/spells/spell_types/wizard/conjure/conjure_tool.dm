#define CONJURE_DURATION 15 MINUTES

/obj/effect/proc_holder/spell/invoked/conjure_tool
	name = "Conjure Tool"
	desc = "Conjure a tool of your choice in your hand or on the ground.\n\
	The tool lasts for 15 minutes - but will refresh its duration infinitely when in the hand of an Arcane user."
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')

	releasedrain = 60
	chargedrain = 1
	chargetime = 3 SECONDS // Tools aren't meant to be used in combat nor are they good for it, so it's a faster charge.
	no_early_release = TRUE
	recharge_time = 60 SECONDS // Can't be spammed, but you can get a few tools decently quickly.

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	antimagic_allowed = FALSE
	charging_slowdown = 3
	cost = 2
	xp_gain = TRUE
	spell_tier = 1

	invocation = "Instrumentum Exoriantur!"
	invocation_type = "shout"
	glow_color = GLOW_COLOR_METAL
	glow_intensity = GLOW_INTENSITY_LOW

	var/list/tool_options = list(
		"Hoe" = /obj/item/rogueweapon/hoe,
		"Thresher" = /obj/item/rogueweapon/thresher,
		"Sickle" = /obj/item/rogueweapon/sickle,
		"Pitchfork" = /obj/item/rogueweapon/pitchfork,
		"Tongs" = /obj/item/rogueweapon/tongs,
		"Hammer" = /obj/item/rogueweapon/hammer,
		"Shovel" = /obj/item/rogueweapon/shovel,
		"Fishing Rod" = /obj/item/fishingrod,
	)

/obj/effect/proc_holder/spell/invoked/conjure_tool/cast(list/targets, mob/living/user = usr)
	var/tool_choice = input(user, "Choose a tool", "Conjure tool") as anything in tool_options
	if(!tool_choice)
		return
	tool_choice = tool_options[tool_choice]

	if (tool_choice == /obj/item/fishingrod)
		var/obj/item/R = new tool_choice(user.drop_location())
		R.AddComponent(/datum/component/conjured_item, CONJURE_DURATION)
		user.put_in_hands(R)
		return
	else
		var/obj/item/rogueweapon/R = new tool_choice(user.drop_location())
		R.AddComponent(/datum/component/conjured_item, CONJURE_DURATION)
		user.put_in_hands(R)
		return TRUE


#undef CONJURE_DURATION
