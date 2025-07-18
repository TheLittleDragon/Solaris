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
		choices += "Purchase Upgrades"
		choices += "View Registered Adventurers"
		choices += "Issue Custom Quest"
		choices += "Review Custom Quests"

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
		if("View Registered Adventurers")
			show_rewards(user)
		if("Issue Custom Quest")
			create_custom_quest(user)
		if("Review Custom Quests")
			review_custom_quests(user)

/obj/structure/roguemachine/questgiver/proc/consult_quests(mob/user)
	if(!(user in SStreasury.bank_accounts))
		say("You have no bank account.")
		return

	var/list/difficulty_data = list(
		"Easy" = list(deposit = 5, reward_min = 15, reward_max = 25, icon = "scroll_quest_low"),
		"Medium" = list(deposit = 10, reward_min = 30, reward_max = 50, icon = "scroll_quest_mid"),
		"Hard" = list(deposit = 20, reward_min = 60, reward_max = 100, icon = "scroll_quest_high")
	)

	// Standard quest handling
	var/list/difficulty_choices = list()
	for(var/difficulty in difficulty_data)
		var/deposit = difficulty_data[difficulty]["deposit"]
		difficulty_choices["[difficulty] ([deposit] mark deposit)"] = difficulty

	var/selection = input(user, "Select quest difficulty (deposit required)", src) as null|anything in difficulty_choices
	if(!selection)
		return

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

	var/type_selection = input(user, "Select quest type", src) as null|anything in type_choices[actual_difficulty]
	if(!type_selection)
		return

	var/datum/quest/attached_quest = new()
	attached_quest.reward_amount = rand(difficulty_data[actual_difficulty]["reward_min"], difficulty_data[actual_difficulty]["reward_max"])
	attached_quest.quest_difficulty = actual_difficulty
	attached_quest.quest_type = type_selection

	var/obj/item/paper/scroll/quest/spawned_scroll = new(get_turf(scroll_point))
	spawned_scroll.base_icon_state = difficulty_data[actual_difficulty]["icon"]
	spawned_scroll.assigned_quest = attached_quest
	attached_quest.quest_scroll_ref = WEAKREF(spawned_scroll)

	if(user.job != "Guild Handler")
		attached_quest.quest_receiver_reference = WEAKREF(user)
		attached_quest.quest_receiver_name = user.real_name
	else
		attached_quest.quest_giver_name = user.real_name
		attached_quest.quest_giver_reference = WEAKREF(user)

	var/obj/effect/landmark/quest_spawner/chosen_landmark = find_quest_landmark(actual_difficulty, type_selection)
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
	var/list/processed_quests = list()

	for(var/atom/movable/pawnable_loot in input_point)
		if(istype(pawnable_loot, /obj/item/paper/scroll/quest))
			var/obj/item/paper/scroll/quest/turned_in_scroll = pawnable_loot
			if(turned_in_scroll.assigned_quest?.complete && !processed_quests[turned_in_scroll.assigned_quest])
				processed_quests[turned_in_scroll.assigned_quest] = TRUE
				
				// Get the quest receiver
				var/mob/resolved_receiver = turned_in_scroll.assigned_quest.quest_receiver_reference?.resolve()
				var/base_reward = turned_in_scroll.assigned_quest.reward_amount
				original_reward += base_reward

				// Record completed quest in adventurer's history
				if(resolved_receiver?.real_name)
					// Initialize user stats if they don't exist
					if(!GLOB.adventuring_statistics_tracker[resolved_receiver.real_name])
						GLOB.adventuring_statistics_tracker[resolved_receiver.real_name] = list(
							"rewards" = list(),
							"xp" = 0,
							"level" = 1,
							"recent_quests" = list(),
							"status" = "Inactive",
						)
					
					var/list/user_stats = GLOB.adventuring_statistics_tracker[resolved_receiver.real_name]
					
					// Ensure recent_quests is a list
					if(!istype(user_stats["recent_quests"], /list))
						user_stats["recent_quests"] = list()
					
					// Add quest to history
					var/quest_entry = "[turned_in_scroll.assigned_quest.title] ([turned_in_scroll.assigned_quest.quest_type]) - Reward: [turned_in_scroll.assigned_quest.reward_amount] marks"
					user_stats["recent_quests"] += quest_entry
					
					// Keep only last 5 quests
					var/list/recent_quests = user_stats["recent_quests"]
					if(length(recent_quests) > 5)
						recent_quests.Cut(1, length(recent_quests) - 4) // Keep last 5 entries

				// Apply bonuses to the quest (this will calculate XP for the receiver)
				if(!turned_in_scroll.assigned_quest.reward_modified)
					turned_in_scroll.assigned_quest.apply_bonuses(resolved_receiver) // Pass the receiver, not the user
					
					// Only apply guild handler bonus if the user is a guild handler
					if(guild && user?.job == "Guild Handler" && !istype(turned_in_scroll.assigned_quest, /datum/quest/custom))
						var/handler_bonus = base_reward * 0.5 // 50% bonus
						turned_in_scroll.assigned_quest.reward_amount += handler_bonus
						to_chat(user, span_notice("Your guild handler expertise adds a [handler_bonus] mark bonus to this quest!"))

				reward += turned_in_scroll.assigned_quest.reward_amount

				var/deposit_return = turned_in_scroll.assigned_quest.quest_difficulty == "Easy" ? 5 : \
									turned_in_scroll.assigned_quest.quest_difficulty == "Medium" ? 10 : 20
				total_deposit_return += deposit_return
				reward += deposit_return
				original_reward += deposit_return

				qdel(turned_in_scroll.assigned_quest)
				qdel(turned_in_scroll)
				continue

		// Handle other items...
		if(istype(pawnable_loot, /obj/item/guild_upgrade_kit))
			var/obj/item/guild_upgrade_kit/kit = pawnable_loot
			if(kit.attempt_refund(user))
				continue

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

/obj/structure/roguemachine/questgiver/proc/create_custom_quest(mob/user)
	if(!guild || user.job != "Guild Handler")
		return

	if(!(user in SStreasury.bank_accounts))
		to_chat(user, span_warning("You need a bank account to issue quests!"))
		return

	var/difficulty = input(user, "Select quest difficulty", "Custom Quest") as null|anything in list("Easy", "Medium", "Hard")
	if(!difficulty)
		return

	var/reward = input(user, "Set reward amount (from your personal funds)", "Custom Quest") as num|null
	if(!reward || reward <= 0)
		return

	if(SStreasury.bank_accounts[user] < reward)
		to_chat(user, span_warning("You don't have enough marks for this reward!"))
		return

	var/title = input(user, "Enter quest title", "Custom Quest") as text|null
	if(!title)
		return

	var/list/objectives = list()
	var/objective_count = 1
	var/add_more = TRUE

	while(add_more)
		var/objective = input(user, "Enter objective #[objective_count] (Leave empty to finish)", "Custom Quest") as text|null
		if(!objective)
			add_more = FALSE
		else
			objectives += "[objective_count]. [objective]"
			objective_count++

	if(!length(objectives))
		to_chat(user, span_warning("Quest must have at least one objective!"))
		return

	var/confirm = alert(user, "Create this quest for [reward] marks?\nTitle: [title]\nObjectives:\n[jointext(objectives, "\n")]", "Confirm Custom Quest", "Create", "Cancel")
	if(confirm != "Create")
		return

	SStreasury.bank_accounts[user] -= reward
	SStreasury.log_entries += "-[reward] from [user.real_name] (custom quest reward)"

	var/datum/quest/custom/new_quest = new()
	new_quest.title = title
	new_quest.quest_type = "Custom Assignment"
	new_quest.quest_difficulty = difficulty
	new_quest.reward_amount = reward
	new_quest.quest_giver_reference = WEAKREF(user)
	new_quest.quest_giver_name = user.real_name
	new_quest.objectives = objectives
	new_quest.reward_modified = TRUE // Mark as already modified to prevent any bonuses

	var/obj/item/paper/scroll/quest/spawned_scroll = new(get_turf(scroll_point))
	spawned_scroll.base_icon_state = difficulty == "Easy" ? "scroll_quest_low" : \
									difficulty == "Medium" ? "scroll_quest_mid" : "scroll_quest_high"
	spawned_scroll.assigned_quest = new_quest
	new_quest.quest_scroll_ref = WEAKREF(spawned_scroll)

	var/scroll_text = "<center>CUSTOM QUEST</center><br>"
	scroll_text += "<center><b>[title]</b></center><br><br>"
	scroll_text += "<b>Issued by:</b> Guild Handler [user.real_name]<br>"
	scroll_text += "<b>Type:</b> Custom assignment<br>"
	scroll_text += "<b>Difficulty:</b> [difficulty]<br><br>"
	scroll_text += "<b>Objectives:</b><br>"
	scroll_text += jointext(objectives, "<br>")
	scroll_text += "<br><br><b>Reward:</b> [reward] marks upon completion<br>"
	scroll_text += "<br><i>Return this scroll to the Quest Book to claim your reward.</i>"

	spawned_scroll.info = scroll_text
	spawned_scroll.update_icon()
	to_chat(user, span_notice("Custom quest created! The scroll has been dispensed."))

/obj/structure/roguemachine/questgiver/proc/review_custom_quests(mob/user)
	if(!guild || user.job != "Guild Handler")
		return
	var/list/pending_quests = list()
	for(var/obj/item/paper/scroll/quest/quest_scroll in world)
		if(quest_scroll.assigned_quest && quest_scroll.assigned_quest.is_custom)
			if(quest_scroll.assigned_quest.quest_giver_reference?.resolve() == user && !quest_scroll.assigned_quest.complete)
				var/status = quest_scroll.assigned_quest.report_submitted ? "Awaiting Review" : "In Progress"
				pending_quests["[quest_scroll.assigned_quest.title] ([status])"] = quest_scroll.assigned_quest

	if(!length(pending_quests))
		to_chat(user, span_notice("No active custom quests."))
		return

	var/selected = input(user, "Select quest to review", "Custom Quests") as null|anything in pending_quests
	if(!selected)
		return

	var/datum/quest/custom/selected_quest = pending_quests[selected]
	var/obj/item/paper/scroll/quest/scroll = selected_quest.quest_scroll_ref?.resolve()
	var/mob/adventurer = selected_quest.quest_receiver_reference?.resolve()

	// Show quest details
	var/list/options = list()
	if(selected_quest.report_submitted)
		options += "Review Completion"
	else 
		options += "Check Progress"
	options += "Modify Quest"
	options += "Cancel Quest"

	var/action = input(user, "Quest: [selected_quest.title]\n\nRecipient: [selected_quest.quest_receiver_name]\n\nStatus: [selected_quest.report_submitted ? "Awaiting Review" : "In Progress"]", "Quest Management") as null|anything in options
	if(!action || action == "Cancel Quest")
		return

	switch(action)
		if("Review Completion")
			var/report = selected_quest.custom_report || "No report submitted."
			var/decision = alert(user, "Quest: [selected_quest.title]\n\nSubmitted by: [selected_quest.report_submitted_by]\n\nReport:\n[report]\n\nReward: [selected_quest.reward_amount] marks", "Review Quest", "Approve", "Deny", "Request Changes")
			
			if(decision == "Request Changes")
				var/changes = input(user, "What changes/additional work do you require?", "Request Changes") as message|null
				if(changes)
					selected_quest.report_submitted = FALSE
					selected_quest.custom_report = null
					if(adventurer)
						to_chat(adventurer, span_warning("Your completion of '[selected_quest.title]' requires additional work."))
						to_chat(adventurer, span_info("Guild Handler Notes: [changes]"))
					to_chat(user, span_notice("Changes requested. The adventurer can submit a new report when ready."))
				return

			var/reason = input(user, "Enter your reason for [decision == "Approve" ? "approving" : "denying"] this quest:", "Quest Review") as text|null
			if(!reason)
				return

			if(decision == "Approve")
				selected_quest.complete = TRUE
				if(adventurer)
					to_chat(adventurer, span_notice("Your completion of '[selected_quest.title]' has been approved by [user.real_name]!"))
					to_chat(adventurer, span_info("Reason: [reason]"))
				if(scroll)
					scroll.update_quest_text()
					to_chat(user, span_notice("Quest approved! The adventurer can now turn in the scroll for their reward."))
			else
				SStreasury.bank_accounts[user] += selected_quest.reward_amount
				SStreasury.log_entries += "+[selected_quest.reward_amount] to [user.real_name] (quest denial refund)"
				if(adventurer)
					to_chat(adventurer, span_warning("Your completion of '[selected_quest.title]' was denied by [user.real_name]."))
					to_chat(adventurer, span_info("Reason: [reason]"))
				qdel(selected_quest)
				if(scroll)
					qdel(scroll)
				to_chat(user, span_notice("Quest denied and funds refunded."))

		if("Check Progress")
			var/progress = ""
			if(adventurer)
				progress = input(adventurer, "How is your progress on '[selected_quest.title]'?", "Progress Report") as message|null
				if(progress)
					to_chat(user, span_notice("[adventurer.real_name] reports:\n[progress]"))
			else
				to_chat(user, span_warning("The adventurer is not currently available to provide an update."))

		if("Modify Quest")
			var/list/mod_options = list("Change Reward", "Add Objective", "Cancel")
			var/mod_choice = input(user, "Select modification", "Quest Editing") as null|anything in mod_options
			if(!mod_choice || mod_choice == "Cancel")
				return

			switch(mod_choice)
				if("Change Reward")
					var/new_reward = input(user, "Enter new reward amount (current: [selected_quest.reward_amount])", "Modify Reward") as num|null
					if(new_reward && new_reward > 0)
						var/difference = new_reward - selected_quest.reward_amount
						if(difference > 0 && SStreasury.bank_accounts[user] < difference)
							to_chat(user, span_warning("You don't have enough marks to increase the reward by [difference]!"))
							return
						
						selected_quest.reward_amount = new_reward
						if(difference > 0)
							SStreasury.bank_accounts[user] -= difference
							SStreasury.log_entries += "-[difference] from [user.real_name] (quest reward increase)"
						else if(difference < 0)
							SStreasury.bank_accounts[user] += abs(difference)
							SStreasury.log_entries += "+[abs(difference)] to [user.real_name] (quest reward decrease)"
						
						if(scroll)
							scroll.update_quest_text()
						to_chat(user, span_notice("Reward updated to [new_reward] marks."))
						if(adventurer)
							to_chat(adventurer, span_notice("The reward for '[selected_quest.title]' has been updated to [new_reward] marks by [user.real_name]."))

				if("Add Objective")
					var/new_objective = input(user, "Enter additional objective", "Add Objective") as text|null
					if(new_objective)
						if(!selected_quest.objectives)
							selected_quest.objectives = list()
						selected_quest.objectives += "[length(selected_quest.objectives)+1]. [new_objective]"
						if(scroll)
							scroll.update_quest_text()
						to_chat(user, span_notice("Objective added to quest."))
						if(adventurer)
							to_chat(adventurer, span_notice("An additional objective has been added to '[selected_quest.title]' by [user.real_name]:\n[new_objective]"))

/obj/structure/roguemachine/questgiver/proc/show_rewards(mob/user)
	if(!guild || user.job != "Guild Handler")
		return

	// Get list of adventurers with statistics
	var/list/adventurers = list()
	for(var/name in GLOB.adventuring_statistics_tracker)
		var/list/stats = GLOB.adventuring_statistics_tracker[name]
		var/status = "Retired" // Default status
		
		// Find the actual player
		for(var/mob/living/carbon/human/player in GLOB.player_list)
			if(player.real_name == name)
				if(player.client) // Player is online
					status = player.client.inactivity >= 300 ? "Inactive" : "Active"
				break // Found the player, stop searching

		// Update the stored status
		stats["status"] = status
		
		adventurers["[name] (Lv. [stats["level"]] - [status])"] = name

	if(!length(adventurers))
		to_chat(user, span_notice("No adventurers have registered statistics yet."))
		return

	var/selected_label = input(user, "Select adventurer to view", "Adventurer Statistics") as null|anything in adventurers
	if(!selected_label)
		return

	var/selected_name = adventurers[selected_label]
	var/list/selected_stats = GLOB.adventuring_statistics_tracker[selected_name]
	var/mob/living/carbon/human/selected_adventurer
	
	// Find the actual adventurer mob if online
	for(var/mob/living/carbon/human/player in GLOB.player_list)
		if(player.real_name == selected_name)
			selected_adventurer = player
			break

	// Apply consistent status checking logic
	var/status = "Retired"
	if(selected_adventurer)
		status = selected_adventurer.client ? (selected_adventurer.client.inactivity >= 300 ? "Inactive" : "Active") : "Retired"
	selected_stats["status"] = status // Update the stored status

	// Calculate XP progress
	var/current_level = selected_stats["level"]
	var/current_xp = selected_stats["xp"]
	var/xp_needed = get_xp_for_level(current_level)
	var/xp_percent = round((current_xp / xp_needed) * 100, 1)

	// Generate report
	var/report_text = "<center><b>ADVENTURER STATISTICS</b></center><br><br>"
	report_text += "<i>Generated on [station_time_timestamp()]</i><br><br>"
	report_text += "<b>Name:</b> [selected_name]<br>"
	report_text += "<b>Status:</b> [status]<br>"
	report_text += "<b>Level:</b> [current_level]<br>"
	report_text += "<b>Experience:</b> [current_xp]/[xp_needed] ([xp_percent]%)<br><br>"

	// Add recent quests if available
	if(length(selected_stats["recent_quests"]))
		report_text += "<b>Recent Quests:</b><br>"
		// Display in reverse chronological order (newest first)
		for(var/i = length(selected_stats["recent_quests"]); i >= 1; i--)
			report_text += "- [selected_stats["recent_quests"][i]]<br>"
	else
		report_text += "<b>Recent Quests:</b> No completed quests recorded<br>"

	// Add bank balance if available
	var/balance = 0
	for(var/mob/M in SStreasury.bank_accounts)
		if(M.real_name == selected_name)
			balance = SStreasury.bank_accounts[M]
			break
	report_text += "<b>Account Balance:</b> [balance] marks<br><br>"

	report_text += "<b>Available Rewards:</b><br>"
	var/has_rewards = FALSE

	// Only check installed upgrades
	var/list/processed_upgrades = list()
	for(var/datum/guild_upgrade/upgrade in SSroguemachine.guild_upgrades)
		if(upgrade.type in processed_upgrades)
			continue

		if(length(upgrade.rewards))
			var/upgrade_has_rewards = FALSE
			var/upgrade_text = ""

			for(var/path in upgrade.rewards)
				var/obj/item/I = path
				var/limit = upgrade.rewards[path]
				var/given = selected_stats["rewards"][path] || 0
				var/remaining = limit == -1 ? "Unlimited" : (limit - given)

				if(remaining != 0 && (limit == -1 || remaining > 0))
					upgrade_has_rewards = TRUE
					upgrade_text += "- [initial(I.name)]: [remaining] remaining<br>"

			if(upgrade_has_rewards)
				has_rewards = TRUE
				report_text += "<b>[upgrade.name]:</b><br>"
				report_text += upgrade_text

			processed_upgrades += upgrade.type

	if(!has_rewards)
		report_text += "No rewards currently available.<br>"

	// Show the report
	var/obj/item/paper/scroll/report = new(get_turf(scroll_point))
	report.name = "Adventurer Report: [selected_name]"
	report.desc = "Statistics and rewards for [selected_name]."
	report.info = report_text
	user.put_in_hands(report)
	to_chat(user, span_notice("Printed adventurer report for [selected_name]."))

/obj/structure/roguemachine/questgiver/guild
	guild = TRUE
	icon_state = "questgiver_guild"
