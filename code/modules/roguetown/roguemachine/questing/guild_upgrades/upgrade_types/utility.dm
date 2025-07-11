/datum/guild_upgrade/hearth
	name = "Guild Hearth"
	category = "utility"
	cost = 150
	active_effects = list(/obj/machinery/light/rogue/hearth, /obj/machinery/light/rogue/oven/south, /obj/item/cooking/pan)
	passive_effects = "Spawns crackers when completing quests"
	conflicts_with = list(/datum/guild_upgrade/hearth)

/datum/guild_upgrade/hearth/apply_passive_bonus(mob/user, datum/quest/quest)
	if(!user || !quest.complete)
		return FALSE
	
	var/mob/resolved_user = user
	if(istype(user, /datum/weakref))
		resolved_user = quest.quest_receiver_reference.resolve()
		if(!resolved_user)
			return FALSE

	var/obj/item/reagent_containers/food/snacks/rogue/crackerscooked/cookerscracked = new
	resolved_user.put_in_hands(cookerscracked)
	return TRUE

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
	conflicts_with = list(/datum/guild_upgrade/tanning_rack)

/datum/guild_upgrade/tanning_rack/apply_passive_bonus(mob/user, datum/quest/quest)
	if(!quest.complete)
		return FALSE
	
	var/mob/resolved_user = user
	if(istype(user, /datum/weakref))
		resolved_user = quest.quest_receiver_reference.resolve()
		if(!resolved_user)
			return FALSE

	// Only notify adventurers about the rack if they haven't received gear yet
	if(resolved_user.job == "Adventurer")
		// Check all guild tanning racks to see if this user has received equipment
		var/has_received_gear = FALSE
		for(var/obj/machinery/tanningrack/guild/rack in world)
			if(rack.received_adventurers[resolved_user.ckey])
				has_received_gear = TRUE
				break
		
		if(!has_received_gear)
			to_chat(resolved_user, span_notice("The guild's tanning rack might have some equipment for you!"))
			return TRUE
	return FALSE
