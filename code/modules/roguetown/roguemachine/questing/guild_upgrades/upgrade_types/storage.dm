/datum/guild_upgrade/file_cabinet
	name = "File Drawer"
	category = "storage"
	cost = 100
	active_effects = list(/obj/structure/closet/crate/drawer)
	passive_effects = "20% increased quest rewards when handling guild quests"
	conflicts_with = list(/datum/guild_upgrade/file_cabinet)

/datum/guild_upgrade/file_cabinet/apply_passive_bonus(mob/user, datum/quest/quest)
	if(!user || !quest.complete)
		return FALSE
	
	var/mob/resolved_user = user
	if(istype(user, /datum/weakref))
		resolved_user = quest.quest_giver_reference.resolve()
		if(!resolved_user)
			return FALSE

	if(resolved_user.job == "Guild Handler")
		to_chat(resolved_user, span_notice("Your organized files grant a 20% bonus to this quest's reward!"))
		quest.reward_amount *= 1.2
		return TRUE
	return FALSE

/datum/guild_upgrade/stockpile
	name = "Stockpile (east-leaning)"
	category = "storage"
	cost = 150
	active_effects = list(/obj/structure/roguemachine/stockpile)
	conflicts_with = list(/datum/guild_upgrade/stockpile)
	direction = "east"

/datum/guild_upgrade/mail_station
	name = "HERMES (south-leaning)"
	category = "storage"
	cost = 250
	active_effects = list(/obj/structure/roguemachine/mail)
	passive_effects = "10% bonus for fetch/courier quests and temporary speed boost on completion"
	conflicts_with = list(/datum/guild_upgrade/mail_station)
	direction = "south"

/datum/guild_upgrade/mail_station/apply_passive_bonus(mob/user, datum/quest/quest)
	if(!quest.complete)
		return FALSE
	
	var/mob/living/resolved_user = user
	if(istype(user, /datum/weakref))
		resolved_user = quest.quest_receiver_reference.resolve()
		if(!resolved_user)
			return FALSE

	if(quest.quest_type in list("Fetch", "Courier"))
		quest.reward_amount *= 1.1
		to_chat(resolved_user, span_notice("Guild's own pneumatic delivery system grants a 10% bonus for this delivery quest!"))
		resolved_user.apply_status_effect(/datum/status_effect/buff/alch/speedpot)
		return TRUE
	return FALSE

/datum/guild_upgrade/reward_chest
	name = "Reward Chest"
	category = "storage"
	cost = 200
	active_effects = list(/obj/structure/closet/crate/chest)
	passive_effects = "Guild handlers receive 30% of quest rewards"
	conflicts_with = list(/datum/guild_upgrade/reward_chest)

/datum/guild_upgrade/reward_chest/apply_passive_bonus(mob/user, datum/quest/quest)
	if(!quest.complete)
		return FALSE

	// Find a guild handler to reward
	var/mob/guild_handler
	for(var/mob/M in SStreasury.bank_accounts)
		if(M.job == "Guild Handler")
			guild_handler = M
			break

	if(guild_handler)
		var/bonus = round(quest.reward_amount * 0.3)
		SStreasury.bank_accounts[guild_handler] += bonus
		SStreasury.log_entries += "+[bonus] to [guild_handler.real_name] (reward chest bonus)"
		to_chat(guild_handler, span_notice("The Reward Chest grants you [bonus] marks (130%) from a completed quest!"))
		return TRUE

	return FALSE
