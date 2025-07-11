/datum/guild_upgrade/town_fountain
	name = "Ornamental Fountain"
	category = "convenience"
	cost = 200
	bonus = 500
	bonus_message = "The town beautification society has deposited 500 marks into your account for installing the fountain!"
	active_effects = list(/obj/structure/well/fountain/town_center)
	passive_effects = "Improves guild reputation with locals."
	outdoor_only = TRUE
	conflicts_with = list(/datum/guild_upgrade/town_fountain, /datum/guild_upgrade/town_beacon)

//These two are rivals

/datum/guild_upgrade/town_beacon
	name = "Town Beacon Installation"
	category = "convenience"
	cost = 500 
	active_effects = list(/obj/structure/roguemachine/teleport_beacon/main)
	passive_effects = "Provides teleportation access for town residents."
	outdoor_only = TRUE
	conflicts_with = list(/datum/guild_upgrade/town_beacon, /datum/guild_upgrade/town_fountain)

/datum/guild_upgrade/water_well
	name = "Water Well"
	category = "convenience"
	cost = 250
	active_effects = list(/obj/structure/well)
	passive_effects = "Allows adventurers to refill their water easily."
	outdoor_only = TRUE
	conflicts_with = list(/datum/guild_upgrade/water_well)

/datum/guild_upgrade/scom
	name = "SCOM (north-leaning)"
	category = "convenience"
	cost = 100
	active_effects = list(/obj/structure/roguemachine/scomm)
	conflicts_with = list(/datum/guild_upgrade/scom)
	direction = "north"

/datum/guild_upgrade/guild_lighting
	name = "Proper Lighting (west-leaning)"
	category = "convenience"
	cost = 75
	bonus = 100
	active_effects = list(/obj/machinery/light/rogue/wallfire/candle)
	passive_effects = "20% less eyestrain (and 100% less tripping in the dark)"
	conflicts_with = list(/datum/guild_upgrade/guild_lighting)
	direction = "west"

/datum/guild_upgrade/basic_questgiver
	name = "Basic Quest Book"
	category = "convenience"
	cost = 100
	active_effects = list(/obj/structure/roguemachine/questgiver)
	passive_effects = "Provides an additional quest book for convenience. Guild handlers receive 10 marks per completed quest."
	conflicts_with = list(/datum/guild_upgrade/basic_questgiver)

/datum/guild_upgrade/basic_questgiver/apply_passive_bonus(mob/user, datum/quest/quest)
	if(!quest.complete)
		return FALSE

	// Find a guild handler to reward
	var/mob/guild_handler
	for(var/mob/M in SStreasury.bank_accounts)
		if(M.job == "Guild Handler")
			guild_handler = M
			break

	if(guild_handler)
		SStreasury.bank_accounts[guild_handler] += 10
		SStreasury.log_entries += "+10 to [guild_handler.real_name] (quest completion bonus)"
		to_chat(guild_handler, span_notice("Adventurer's Guild grants you 10 marks for a registered quest completion!"))
		return TRUE

	return FALSE

/datum/guild_upgrade/knight_statue
	name = "Knight Statue"
	category = "convenience"
	cost = 200
	active_effects = list(/obj/structure/fluff/statue/knightalt/r/guild)
	passive_effects = "Provides a 20% bonus reward to Kill/Clear Out/Miniboss quests."
	outdoor_only = TRUE
	conflicts_with = list(/datum/guild_upgrade/aeternus_statue, /datum/guild_upgrade/knight_statue, /datum/guild_upgrade/copper_cross)

/datum/guild_upgrade/knight_statue/apply_passive_bonus(mob/user, datum/quest/quest)
	if(quest.complete && (quest.quest_type in list("Kill", "Clear Out", "Miniboss")))
		to_chat(user, span_notice("The knight statue's blessing grants a 20% bonus to this combat quest!"))
		quest.reward_amount *= 1.2
		return TRUE
	return FALSE

/datum/guild_upgrade/aeternus_statue
	name = "Statue of Aeternus"
	category = "convenience"
	cost = 250
	active_effects = list(/obj/structure/fluff/statue/aeternus)
	passive_effects = "10% bonus for beacon quests and free single time teleport until dawn."
	outdoor_only = TRUE
	conflicts_with = list(/datum/guild_upgrade/aeternus_statue, /datum/guild_upgrade/knight_statue, /datum/guild_upgrade/copper_cross)

/datum/guild_upgrade/aeternus_statue/apply_passive_bonus(mob/user, datum/quest/quest)
	if(!quest.complete)
		return FALSE
	
	var/mob/living/resolved_user = user
	if(istype(user, /datum/weakref))
		resolved_user = quest.quest_receiver_reference.resolve()
		if(!resolved_user)
			return FALSE

	if(quest.quest_type == "Beacon")
		quest.reward_amount *= 1.1
		to_chat(resolved_user, span_notice("The Aeternus Statue grants a 10% bonus for this beacon quest!"))
		
		// Add free teleport ability until dawn
		if(!resolved_user.has_status_effect(/datum/status_effect/free_teleport_guild))
			resolved_user.apply_status_effect(/datum/status_effect/free_teleport_guild)
			to_chat(resolved_user, span_notice("The Aeternus Statue grants you one free teleport until dawn!"))
		return TRUE
	return FALSE

/datum/guild_upgrade/copper_cross
	name = "Copper Cross"
	category = "convenience"
	cost = 250
	active_effects = list(/obj/structure/fluff/psycross/copper)
	passive_effects = "40% bonus for church members, 10% for others."
	outdoor_only = TRUE
	conflicts_with = list(/datum/guild_upgrade/aeternus_statue, /datum/guild_upgrade/knight_statue, /datum/guild_upgrade/copper_cross)

/datum/guild_upgrade/copper_cross/apply_passive_bonus(mob/user, datum/quest/quest)
	if(!quest.complete)
		return FALSE
	
	var/mob/resolved_user = user
	if(istype(user, /datum/weakref))
		resolved_user = quest.quest_receiver_reference.resolve()
		if(!resolved_user)
			return FALSE

	var/static/list/church_jobs = list(
		"Priest",
		"Acolyte",
		"Templar",
		"Churchling",
		"Deacon"
	)

	if(resolved_user.job in church_jobs)
		quest.reward_amount *= 1.4
		to_chat(resolved_user, span_notice("The pantheon cross grants a 40% bonus for your faithful service!"))
	else
		quest.reward_amount *= 1.1
		to_chat(resolved_user, span_notice("The pantheon cross grants a modest 10% bonus for the Guild's faith."))
	return TRUE

/datum/guild_upgrade/artificer_flag
	name = "Artificer's Flag (east-leaning)"
	category = "convenience"
	cost = 300
	active_effects = list(/obj/structure/fluff/walldeco/artificerflag)
	passive_effects = "10% bonus reward for quests issued by Guild Handlers"
	conflicts_with = list(/datum/guild_upgrade/artificer_flag)
	direction = "east"

/datum/guild_upgrade/artificer_flag/apply_passive_bonus(mob/user, datum/quest/quest)
	if(!quest.complete || !quest.quest_giver_reference)
		return FALSE
	
	var/mob/giver = quest.quest_giver_reference.resolve()
	if(giver && giver.job == "Guild Handler")
		quest.reward_amount *= 1.1
		to_chat(user, span_notice("Inter-guild cooperation grants a 10% bonus for this guild-issued quest!"))
		return TRUE
	return FALSE
