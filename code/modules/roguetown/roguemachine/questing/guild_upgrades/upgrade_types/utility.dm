/datum/guild_upgrade/hearth
	name = "Guild Hearth"
	category = "utility"
	cost = 150
	active_effects = list(/obj/machinery/light/rogue/hearth, /obj/machinery/light/rogue/oven/south, /obj/item/cooking/pan)
	passive_effects = "Provides food rewards for completing quests"
	rewards = list(
		/obj/item/reagent_containers/food/snacks/rogue/crackerscooked = 5,
	)
	conflicts_with = list(/datum/guild_upgrade/hearth)

/datum/guild_upgrade/hearth/apply_passive_bonus(mob/user, datum/quest/quest)
	if(!user || !quest.complete)
		return FALSE
	
	var/mob/resolved_user = user
	if(istype(user, /datum/weakref))
		resolved_user = quest.quest_receiver_reference.resolve()
		if(!resolved_user)
			return FALSE

	return give_reward(resolved_user)

/datum/guild_upgrade/training_dummy
	name = "Training Dummy"
	category = "utility"
	cost = 150
	active_effects = list(/obj/structure/fluff/statue/tdummy)
	passive_effects = "Allows adventurers to practice combat skills."
	conflicts_with = list(/datum/guild_upgrade/training_dummy)

/datum/guild_upgrade/bedrolls
	name = "Bedroll Set"
	category = "utility"
	cost = 150
	active_effects = list(/obj/item/bedroll, /obj/item/bedroll, /obj/item/bedroll, /obj/item/bedroll)
	passive_effects = "Provides resting places for tired adventurers. Restores a small amount of fatigue per completed quest."
	conflicts_with = list(/datum/guild_upgrade/bedrolls)

/datum/guild_upgrade/bedrolls/apply_passive_bonus(mob/user, datum/quest/quest)
	if(!user || !quest.complete)
		return FALSE
	
	var/mob/resolved_user = user
	if(istype(user, /datum/weakref))
		resolved_user = quest.quest_receiver_reference.resolve()
		if(!resolved_user)
			return FALSE

		var/mob/living/carbon/human/H = user
		H.rogstam_add(25) // Restore 25 stamina (2,5% of total) per completed quest
		to_chat(H, span_notice("The guild's interior helps you recover your strength."))
		return TRUE
	return FALSE

/datum/guild_upgrade/tanning_rack
	name = "Tanning Rack"
	category = "utility"
	cost = 250
	active_effects = list(/obj/machinery/tanningrack/guild)
	passive_effects = "Provides equipment to adventurers completing quests."
	rewards = list(
		/obj/item/reagent_containers/glass/bottle/waterskin = 1,
		/obj/item/bedroll = 1,
		/obj/item/storage/backpack/rogue/backpack = 1,
	)
	conflicts_with = list(/datum/guild_upgrade/tanning_rack)

/datum/guild_upgrade/tanning_rack/apply_passive_bonus(mob/user, datum/quest/quest)
	if(!quest.complete)
		return FALSE
	
	var/mob/resolved_user = user
	if(istype(user, /datum/weakref))
		resolved_user = quest.quest_receiver_reference.resolve()
		if(!resolved_user || resolved_user.job != "Adventurer")
			return FALSE

	return give_reward(resolved_user)
