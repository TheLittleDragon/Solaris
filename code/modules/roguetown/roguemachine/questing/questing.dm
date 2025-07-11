/obj/structure/roguemachine/questgiver
	name = "grand quest book"
	desc = "A large wooden notice board, carrying postings from all across Sunmarch. A crow's perch sits atop it."
	icon = 'code/modules/roguetown/roguemachine/questing/questing.dmi'
	icon_state = "questgiver"
	density = TRUE
	anchored = TRUE
	max_integrity = 0
	blade_dulling = DULLING_BASH
	/// Whether it's the main guild quest giver
	var/guild = FALSE
	/// Place to deposit completed scrolls or items
	var/input_point
	/// Place to spawn scrolls or rewards
	var/scroll_point
	/// Items that can be sold directly through the guild
	var/list/sellable_items = list()

/obj/structure/roguemachine/questgiver/Initialize()
	. = ..()
	SSroguemachine.questgivers += src
	input_point = locate(x, y - 1, z)
	scroll_point = locate(x, y, z)

	var/obj/effect/decal/questing/marker_export/marker = new(get_turf(input_point))
	marker.desc = "Place completed quest scrolls here to turn them in."

/obj/structure/roguemachine/questgiver/examine(mob/user)
	. = ..()
	if(guild)
		. += span_notice("This quest book will give <b>bigger rewards</b> if processed with the help of a <b>local guild handler</b>!")

/obj/structure/roguemachine/questgiver/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return

	var/list/choices = list("Consult Quests", "Turn In Quest", "Abandon Quest")
	if(guild && user.job == "Guild Handler")
		choices += "Print Issued Quests"
		choices += "Purchase Upgrades"  // New option

	var/selection = input(user, "The Excidium listens", src) as null|anything in choices
	if(!selection)
		return

	switch(selection)
		if("Consult Quests")
			consult_quests(user)
		if("Turn In Quest")
			turn_in_quest(user)
		if("Abandon Quest")
			abandon_quest(user)
		if("Print Issued Quests")
			print_quests(user)
		if("Purchase Upgrades")
			manage_upgrades(user)

/obj/structure/roguemachine/questgiver/proc/consult_quests(mob/user)
	if(!(user in SStreasury.bank_accounts))
		say("You have no bank account.")
		return

	var/list/difficulty_data = list(
		"Easy" = list(deposit = 5, reward_min = 15, reward_max = 25, icon = "scroll_quest_low"),
		"Medium" = list(deposit = 10, reward_min = 30, reward_max = 50, icon = "scroll_quest_mid"),
		"Hard" = list(deposit = 20, reward_min = 60, reward_max = 100, icon = "scroll_quest_high")
	)

	// Create a list with formatted difficulty choices showing deposits
	var/list/difficulty_choices = list()
	for(var/difficulty in difficulty_data)
		var/deposit = difficulty_data[difficulty]["deposit"]
		difficulty_choices["[difficulty] ([deposit] mark deposit)"] = difficulty

	var/selection = input(user, "Select quest difficulty (deposit required)", src) as null|anything in difficulty_choices
	if(!selection)
		return

	// Get the actual difficulty key from our formatted choice
	var/actual_difficulty = difficulty_choices[selection]
	var/deposit = difficulty_data[actual_difficulty]["deposit"]

	if(SStreasury.bank_accounts[user] < deposit)
		say("Insufficient balance funds. You need [deposit] marks.")
		return

	var/list/type_choices = list(
		"Easy" = list("Fetch", "Courier", "Kill", "Beacon"),
		"Medium" = list("Kill", "Clear Out", "Beacon"),
		"Hard" = list("Clear Out", "Beacon", "Miniboss")
	)

	var/type_selection = input(user, "Select quest type", src) as null|anything in type_choices[actual_difficulty] // Changed from selection to actual_difficulty
	if(!type_selection)
		return

	// Continue with the rest of the proc using actual_difficulty instead of selection
	var/datum/quest/attached_quest = new()
	attached_quest.reward_amount = rand(difficulty_data[actual_difficulty]["reward_min"], difficulty_data[actual_difficulty]["reward_max"]) // Changed from selection to actual_difficulty
	attached_quest.quest_difficulty = actual_difficulty // Changed from selection to actual_difficulty
	attached_quest.quest_type = type_selection

	var/obj/item/paper/scroll/quest/spawned_scroll = new(get_turf(scroll_point))
	spawned_scroll.base_icon_state = difficulty_data[actual_difficulty]["icon"] // Changed from selection to actual_difficulty
	spawned_scroll.assigned_quest = attached_quest
	attached_quest.quest_scroll_ref = WEAKREF(spawned_scroll)

	if(user.job != "Guild Handler")
		attached_quest.quest_receiver_reference = WEAKREF(user)
		attached_quest.quest_receiver_name = user.real_name
	else
		attached_quest.quest_giver_name = user.real_name
		attached_quest.quest_giver_reference = WEAKREF(user)

	var/obj/effect/landmark/quest_spawner/chosen_landmark = find_quest_landmark(actual_difficulty, type_selection) // Changed from selection to actual_difficulty
	if(!chosen_landmark)
		to_chat(user, span_warning("No suitable location found for this quest!"))
		qdel(attached_quest)
		qdel(spawned_scroll)
		return

	chosen_landmark.generate_quest(attached_quest, user.job == "Guild Handler" ? null : user)
	spawned_scroll.update_quest_text()
	SStreasury.bank_accounts[user] -= deposit
	SStreasury.treasury_value += deposit
	SStreasury.log_entries += "+[deposit] to treasury (quest deposit)"

/obj/structure/roguemachine/questgiver/proc/find_quest_landmark(difficulty, type)
	// First try to find landmarks that match both difficulty AND type
	var/list/correctest_landmarks = list()
	for(var/obj/effect/landmark/quest_spawner/landmark in GLOB.landmarks_list)
		if(landmark.quest_difficulty == difficulty && (type in landmark.quest_type))
			correctest_landmarks += landmark

	if(length(correctest_landmarks))
		return pick(correctest_landmarks)

	// If none found, try landmarks that match just the difficulty
	var/list/correcter_landmarks = list()
	for(var/obj/effect/landmark/quest_spawner/landmark in GLOB.landmarks_list)
		if(landmark.quest_difficulty == difficulty)
			correcter_landmarks += landmark

	if(length(correcter_landmarks))
		return pick(correcter_landmarks)

	// If still none found, return a random landmark as fallback
	var/list/fallback_landmarks = list()
	for(var/obj/effect/landmark/quest_spawner/landmark in GLOB.landmarks_list)
		fallback_landmarks += landmark

	if(length(fallback_landmarks))
		return pick(fallback_landmarks)

	return null

/obj/structure/roguemachine/questgiver/proc/turn_in_quest(mob/user)
	var/reward = 0
	var/original_reward = 0
	var/total_deposit_return = 0

	for(var/atom/movable/pawnable_loot in input_point)
		// Handle quest scrolls
		if(istype(pawnable_loot, /obj/item/paper/scroll/quest))
			var/obj/item/paper/scroll/quest/turned_in_scroll = pawnable_loot
			if(turned_in_scroll.assigned_quest?.complete)
				// Calculate base reward
				var/base_reward = turned_in_scroll.assigned_quest.reward_amount
				original_reward += base_reward

				// Apply bonuses only once through apply_bonuses
				if(!turned_in_scroll.assigned_quest.reward_modified)
					turned_in_scroll.assigned_quest.apply_bonuses(user)
					// Apply guild handler bonus if applicable (only once)
					if(guild && user?.job == "Guild Handler")
						turned_in_scroll.assigned_quest.reward_amount += base_reward * 1  // 100% bonus
						to_chat(user, span_notice("Your guild handler expertise adds a 100% bonus to this quest!"))

				reward += turned_in_scroll.assigned_quest.reward_amount

				// Calculate deposit return based on difficulty
				var/deposit_return = turned_in_scroll.assigned_quest.quest_difficulty == "Easy" ? 5 : \
									turned_in_scroll.assigned_quest.quest_difficulty == "Medium" ? 10 : 20
				total_deposit_return += deposit_return
				reward += deposit_return
				original_reward += deposit_return

				qdel(turned_in_scroll.assigned_quest)
				qdel(turned_in_scroll)
				continue

		// Handle upgrade kit refunds
		if(istype(pawnable_loot, /obj/item/guild_upgrade_kit))
			var/obj/item/guild_upgrade_kit/kit = pawnable_loot
			if(kit.attempt_refund(user))
				continue

		// Handle sellable items
		if(guild && is_type_in_list(pawnable_loot, sellable_items))
			var/obj/item/to_sell = pawnable_loot
			if(to_sell.get_real_price() > 0)
				reward += to_sell.sellprice
				qdel(to_sell)
				continue

	cash_in(round(reward), original_reward)

/obj/structure/roguemachine/questgiver/proc/cash_in(reward, original_reward)
	var/list/coin_types = list(
		/obj/item/roguecoin/gold = FLOOR(reward / 10, 1),
		/obj/item/roguecoin/silver = FLOOR(reward % 10 / 5, 1),
		/obj/item/roguecoin/copper = reward % 5
	)

	for(var/coin_type in coin_types)
		var/amount = coin_types[coin_type]
		if(amount > 0)
			var/obj/item/roguecoin/coin_stack = new coin_type(scroll_point)
			coin_stack.quantity = amount
			coin_stack.update_icon()
			coin_stack.update_transform()

	if(reward > 0)
		say(reward != original_reward ? \
			"Your guild handler assistance-increased reward of [reward] marks has been dispensed! The difference is [reward - original_reward] marks." : \
			"Your reward of [reward] marks has been dispensed.")

/obj/structure/roguemachine/questgiver/proc/abandon_quest(mob/user)
	var/obj/item/paper/scroll/quest/abandoned_scroll = locate() in input_point
	if(!abandoned_scroll)
		to_chat(user, span_warning("No quest scroll found in the input area!"))
		return

	var/datum/quest/quest = abandoned_scroll.assigned_quest
	if(!quest)
		to_chat(user, span_warning("This scroll doesn't have an assigned quest!"))
		return

	if(quest.complete)
		turn_in_quest(user)
		return

	var/refund = quest.quest_difficulty == "Easy" ? 5 : \
				quest.quest_difficulty == "Medium" ? 10 : 20

	// First try to return to quest giver
	var/mob/giver = quest.quest_giver_reference?.resolve()
	if(giver && (giver in SStreasury.bank_accounts))
		SStreasury.bank_accounts[giver] += refund
		SStreasury.treasury_value -= refund
		SStreasury.log_entries += "-[refund] from treasury (quest refund to handler)"
		to_chat(user, span_notice("The deposit has been returned to the quest giver."))
	// Otherwise try quest receiver
	else if(quest.quest_receiver_reference)
		var/mob/receiver = quest.quest_receiver_reference.resolve()
		if(receiver && (receiver in SStreasury.bank_accounts))
			SStreasury.bank_accounts[receiver] += refund
			SStreasury.treasury_value -= refund
			SStreasury.log_entries += "-[refund] from treasury (quest refund to volunteer)"
			to_chat(user, span_notice("You receive a [refund] mark refund for abandoning the quest."))
		else
			cash_in(refund)
			SStreasury.treasury_value -= refund
			SStreasury.log_entries += "-[refund] from treasury (quest refund)"
			to_chat(user, span_notice("Your refund of [refund] marks has been dispensed."))

	// Clean up quest items
	if(quest.quest_type == "Courier" && quest.target_delivery_item)
		quest.target_delivery_item = null
		for(var/obj/item/I in world)
			if(istype(I, quest.target_delivery_item))
				var/datum/component/quest_object/Q = I.GetComponent(/datum/component/quest_object)
				if(Q && Q.quest_ref == WEAKREF(quest))
					I.remove_filter("quest_item_outline")
					qdel(Q)
					qdel(I)

	abandoned_scroll.assigned_quest = null
	qdel(quest)
	qdel(abandoned_scroll)

/obj/structure/roguemachine/questgiver/proc/print_quests(mob/user)
	if(!guild)
		return

	var/list/active_quests = list()
	for(var/obj/item/paper/scroll/quest/quest_scroll in world)
		if(quest_scroll.assigned_quest && !quest_scroll.assigned_quest.complete)
			active_quests += quest_scroll

	if(!length(active_quests))
		say("No active quests found.")
		return

	var/obj/item/paper/scroll/report = new(get_turf(scroll_point))
	report.name = "Guild Quest Report"
	report.desc = "A list of currently active quests issued by the Adventurers' Guild."

	var/report_text = "<center><b>ADVENTURER'S GUILD - ACTIVE QUESTS</b></center><br><br>"
	report_text += "<i>Generated on [station_time_timestamp()]</i><br><br>"

	for(var/obj/item/paper/scroll/quest/quest_scroll in active_quests)
		var/datum/quest/quest = quest_scroll.assigned_quest
		var/area/quest_area = get_area(quest_scroll)
		report_text += "<b>Title:</b> [quest.title].<br>"
		report_text += "<b>Recipient:</b> [quest.quest_receiver_name ? quest.quest_receiver_name : "Unclaimed"].<br>"
		report_text += "<b>Type:</b> [quest.quest_type].<br>"
		report_text += "<b>Difficulty:</b> [quest.quest_difficulty].<br>"
		report_text += "<b>Last Known Location:</b> [quest_area ? quest_area.name : "Unknown Location"].<br>"
		report_text += "<b>Reward:</b> [quest.reward_amount] marks.<br><br>"

	report.info = report_text
	say("Quest report printed.")

/obj/structure/roguemachine/questgiver/proc/manage_upgrades(mob/user)
	if(!guild || user.job != "Guild Handler")
		return

	// Initialize categories with empty lists
	var/list/categories = list(
		"utility" = list(),
		"convenience" = list(),
		"storage" = list()
	)

	// Populate from global registry, filtering out upgrades that conflict with installed ones
	var/list/installed_upgrade_types = list()
	for(var/datum/guild_upgrade/upgrade in SSroguemachine.guild_upgrades)
		installed_upgrade_types += upgrade.type

	for(var/upgrade_type in GLOB.all_guild_upgrades)
		var/datum/guild_upgrade/upgrade = new upgrade_type()
		var/conflict_with_installed = FALSE
		
		// Check if this upgrade conflicts with any installed upgrades
		for(var/installed_type in installed_upgrade_types)
			if(installed_type in upgrade.conflicts_with)
				conflict_with_installed = TRUE
				break

		if(!conflict_with_installed)
			if(!categories[upgrade.category])
				categories[upgrade.category] = list()
			categories[upgrade.category][upgrade_type] = upgrade
		qdel(upgrade)

	// Category selection
	var/category_choice = input(user, "Select upgrade category", "Guild Upgrades") as null|anything in categories
	if(!category_choice || !length(categories[category_choice]))
		return

	// Create a formatted list of upgrades for display
	var/list/upgrade_choices = list()
	for(var/upgrade_type in categories[category_choice])
		var/datum/guild_upgrade/upgrade = categories[category_choice][upgrade_type]
		upgrade_choices["[upgrade.name] ([upgrade.cost] marks)"] = upgrade_type

	// Upgrade selection
	var/upgrade_choice = input(user, "Select upgrade to purchase", "Guild Upgrades") as null|anything in upgrade_choices
	if(!upgrade_choice)
		return

	// Get the selected upgrade type
	var/upgrade_type = upgrade_choices[upgrade_choice]
	var/datum/guild_upgrade/upgrade = new upgrade_type()

	// Check funds
	if(SStreasury.bank_accounts[user] < upgrade.cost)
		to_chat(user, span_warning("You don't have enough marks for this upgrade!"))
		qdel(upgrade)
		return

	// Enhanced confirmation window
	var/list/confirmation_text = list()
	confirmation_text += "[upgrade.name]"
	confirmation_text += "Category: [upgrade.category]"
	confirmation_text += "Cost: [upgrade.cost] marks"

	if(upgrade.bonus > 0)
		confirmation_text += "Immediate Bonus: +[upgrade.bonus] marks"

	if(upgrade.active_effects.len)
		confirmation_text += "Creates:"
		for(var/path in upgrade.active_effects)
			var/atom/A = path
			confirmation_text += " - [initial(A.name)]"

	if(upgrade.passive_effects)
		confirmation_text += "Passive Effect: [upgrade.passive_effects]"

	confirmation_text += "Installation: [upgrade.outdoor_only ? "OUTSIDE the guild" : "INSIDE the guild"]"

	// Show all potential conflicts from the upgrade's conflicts_with list
	var/list/all_potential_conflicts = list()
	for(var/conflicting_type in upgrade.conflicts_with)
		if(conflicting_type == upgrade.type)
			continue
		var/datum/guild_upgrade/conflicting_upgrade = new conflicting_type()
		all_potential_conflicts += conflicting_upgrade.name
		qdel(conflicting_upgrade)

	if(length(all_potential_conflicts))
		confirmation_text += "WARNING: Will conflict with: [english_list(all_potential_conflicts)]"
		confirmation_text += "(These upgrades will become unavailable if you install this one)"

	var/confirm = alert(user, jointext(confirmation_text, "\n"), "Confirm Purchase", "Purchase", "Cancel")
	if(confirm != "Purchase")
		qdel(upgrade)
		return

	// Deduct cost and spawn kit
	SStreasury.bank_accounts[user] -= upgrade.cost
	SStreasury.treasury_value += upgrade.cost
	SStreasury.log_entries += "+[upgrade.cost] to treasury (guild upgrade purchase)"

	var/obj/item/guild_upgrade_kit/kit = new(get_turf(scroll_point), upgrade_type)
	user.put_in_hands(kit)
	to_chat(user, span_notice("The [kit.name] has been dispensed. Place it on a [upgrade.category] upgrade slot to install."))

	// Show installation instructions
	to_chat(user, span_info("Look for [icon2html('code/modules/roguetown/roguemachine/questing/questing.dmi', user, "marker_[upgrade.category]")] [upgrade.category] markers on the ground."))

	qdel(upgrade)

/obj/structure/roguemachine/questgiver/guild
	guild = TRUE
	icon_state = "questgiver_guild"
