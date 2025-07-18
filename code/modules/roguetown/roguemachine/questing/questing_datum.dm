/datum/quest
	var/title = ""
	var/datum/weakref/quest_giver_reference
	var/quest_giver_name = ""
	var/datum/weakref/quest_receiver_reference
	var/quest_receiver_name = ""
	var/quest_type = ""
	var/quest_difficulty = ""
	var/reward_amount = 0
	var/complete = FALSE
	/// Target item type for fetch quests
	var/obj/item/target_item_type
	/// Target item type for courier quests
	var/obj/item/target_delivery_item
	/// Target mob type for kill quests
	var/mob/target_mob_type
	/// Number of targets needed
	var/target_amount = 1
	/// Location for beacon quests
	var/area/beacon_activation_location
	/// Location for courier quests
	var/area/provincial/indoors/town/target_delivery_location
	/// Location name for kill/clear quests
	var/target_spawn_area = ""
	/// Fallback reference to the spawned scroll
	var/obj/item/paper/scroll/quest/quest_scroll
	/// Weak reference to the quest scroll
	var/datum/weakref/quest_scroll_ref
	/// Target beacon for beacon quests
	var/obj/structure/roguemachine/teleport_beacon/target_beacon
	/// Whether this is a beacon connection quest
	var/beacon_connection = FALSE
	/// List of possible beacons for connection quests
	var/list/possible_beacons = list()
	/// Whether the beacon has been activated for this quest
	var/beacon_activated = FALSE
	/// Track if reward has been adjusted
	var/reward_modified = FALSE
	/// Tracks which upgrade types have already been applied
	var/list/applied_upgrade_types = list()
	var/static/list/difficulty_base_rewards = list(
	"Easy" = list(base = 15, max = 25, falloff_level = 15),
	"Medium" = list(base = 30, max = 50, falloff_level = 25),
	"Hard" = list(base = 60, max = 100, falloff_level = 30),
	)
	var/static/list/difficulty_xp_multipliers = list(
		"Easy" = 1.0,
		"Medium" = 2.0,
		"Hard" = 4.0,
	)
	var/is_custom = FALSE
	var/custom_report = ""
	var/report_submitted = FALSE
	var/report_submitted_by = ""

/datum/quest/Destroy()
	for(var/mob/living/M in GLOB.mob_list)
		var/datum/component/quest_object/Q = M.GetComponent(/datum/component/quest_object)
		if(Q && Q.quest_ref?.resolve() == src)
			M.remove_filter("quest_item_outline")
			qdel(Q)

	for(var/obj/item/I in world)
		var/datum/component/quest_object/Q = I.GetComponent(/datum/component/quest_object)
		if(Q && Q.quest_ref?.resolve() == src && !QDELETED(I))
			I.remove_filter("quest_item_outline")
			qdel(Q)
			if(quest_type == "Fetch" && istype(I, target_item_type))
				qdel(I)
			else if(quest_type == "Courier" && istype(I, target_delivery_item))
				qdel(I)

	quest_scroll = null
	if(quest_scroll_ref)
		var/obj/item/paper/scroll/quest/Q = quest_scroll_ref.resolve()
		if(Q && !QDELETED(Q))
			Q.assigned_quest = null
			qdel(Q)
		quest_scroll_ref = null

	target_beacon = null
	possible_beacons = null
	return ..()

/datum/quest/proc/calculate_rewards(mob/user)
	var/mob/living/carbon/human/resolved_user
	if(istype(user, /datum/weakref))
		var/datum/weakref/user_ref = user
		resolved_user = user_ref.resolve()
	else if(istype(user, /mob/living/carbon/human))
		resolved_user = user

	// Get user level from their stats if available
	var/user_level = 1
	if(resolved_user?.real_name && GLOB.adventuring_statistics_tracker[resolved_user.real_name])
		user_level = GLOB.adventuring_statistics_tracker[resolved_user.real_name]["level"] || 1

	// Calculate base reward with proper level scaling
	var/difficulty_data = difficulty_base_rewards[quest_difficulty]
	var/base_reward = difficulty_data["base"]
	var/max_reward = difficulty_data["max"]

	// Apply consistent level scaling across all difficulties
	switch(quest_difficulty)
		if("Easy")
			var/falloff_level = difficulty_data["falloff_level"]
			if(user_level > falloff_level)
				var/levels_over = user_level - falloff_level
				var/reduction = min(0.5, levels_over * 0.05) // 5% reduction per level (max 50%)
				base_reward *= (1 - reduction)
		if("Medium")
			var/falloff_level = difficulty_data["falloff_level"]
			if(user_level > falloff_level)
				var/levels_over = user_level - falloff_level
				var/reduction = min(0.3, levels_over * 0.03) // 3% reduction per level (max 30%)
				base_reward *= (1 - reduction)
		if("Hard")
			var/falloff_level = difficulty_data["falloff_level"]
			if(user_level > falloff_level)
				var/levels_over = user_level - falloff_level
				var/reduction = min(0.2, levels_over * 0.02) // 2% reduction per level (max 20%)
				base_reward *= (1 - reduction)

	// Calculate XP based on BASE reward (before level scaling)
	var/xp_multiplier = difficulty_xp_multipliers[quest_difficulty]
	var/xp_gain = round(base_reward * xp_multiplier)

	// Final reward is random between adjusted base and max
	reward_amount = rand(base_reward, max_reward)

	return xp_gain

/datum/quest/proc/apply_bonuses(mob/user)
	if(reward_modified || istype(src, /datum/quest/custom)) // Skip if already modified or custom
		return

	var/original_reward = reward_amount
	// Always use the quest receiver for XP calculations
	var/mob/living/carbon/human/resolved_user
	if(quest_receiver_reference)
		resolved_user = quest_receiver_reference.resolve()

	// Apply leveling to the quest receiver
	if(resolved_user?.real_name)
		// Initialize tracking if needed
		if(!GLOB.adventuring_statistics_tracker[resolved_user.real_name])
			GLOB.adventuring_statistics_tracker[resolved_user.real_name] = list(
				"rewards" = list(),
				"xp" = 0,
				"level" = 1,
				"recent_quests" = list(),
				"status" = "Inactive",
			)

		// Calculate XP and apply level scaling
		var/xp_gain = calculate_rewards(resolved_user)
		var/list/user_stats = GLOB.adventuring_statistics_tracker[resolved_user.real_name]
		user_stats["xp"] += xp_gain

		// Check for level-up
		var/xp_needed = get_xp_for_level(user_stats["level"])
		while(user_stats["xp"] >= xp_needed && user_stats["level"] < 50)
			user_stats["level"]++
			user_stats["xp"] -= xp_needed
			xp_needed = get_xp_for_level(user_stats["level"])
			to_chat(resolved_user, span_notice("You've reached Adventurer Level [user_stats["level"]]!"))

	// Only apply upgrade bonuses if upgrades exist
	if(length(SSroguemachine.guild_upgrades))
		for(var/datum/guild_upgrade/upgrade in SSroguemachine.guild_upgrades)
			if(upgrade.type in applied_upgrade_types)
				continue
			if(upgrade.apply_passive_bonus(resolved_user, src)) // Pass the resolved user
				applied_upgrade_types += upgrade.type

	// Show upgrade message only if upgrades modified the reward
	if(reward_amount != original_reward && resolved_user && length(SSroguemachine.guild_upgrades))
		to_chat(resolved_user, span_notice("Guild upgrades increased your reward from [original_reward] to [reward_amount] marks!"))

	reward_modified = TRUE

/datum/quest/custom
	var/list/objectives = list()

/datum/quest/custom/New()
	. = ..()
	is_custom = TRUE
