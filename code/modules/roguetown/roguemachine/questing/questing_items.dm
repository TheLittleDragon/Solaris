/obj/item/paper/scroll/quest
	name = "enchanted quest scroll"
	desc = "A weathered scroll enchanted to list the active quests from the Adventurers' Guild. The magical protections make it resistant to damage and tampering."
	icon = 'code/modules/roguetown/roguemachine/questing/questing.dmi'
	icon_state = "scroll_quest"
	var/base_icon_state = "scroll_quest"
	var/datum/quest/assigned_quest
	var/last_compass_direction = ""
	var/last_z_level_hint = ""
	resistance_flags = FIRE_PROOF | LAVA_PROOF | INDESTRUCTIBLE | UNACIDABLE
	max_integrity = 1000
	armor = list("blunt" = 100, "slash" = 100, "stab" = 100, "piercing" = 100, "fire" = 100, "acid" = 100)

/obj/item/paper/scroll/quest/Initialize()
	. = ..()
	if(assigned_quest)
		assigned_quest.quest_scroll = src 
	update_quest_text()

/obj/item/paper/scroll/quest/Destroy()
	if(assigned_quest)
		// Return deposit if scroll is destroyed before completion
		if(!assigned_quest.complete)
			var/refund = assigned_quest.quest_difficulty == "Easy" ? 5 : \
						assigned_quest.quest_difficulty == "Medium" ? 10 : 20

			// First try to return to quest giver if available
			var/mob/giver = assigned_quest.quest_giver_reference?.resolve()
			if(giver && (giver in SStreasury.bank_accounts))
				SStreasury.bank_accounts[giver] += refund
				SStreasury.treasury_value -= refund
				SStreasury.log_entries += "-[refund] from treasury (quest scroll destroyed refund to giver [giver.real_name])"
			// Otherwise try quest receiver
			else if(assigned_quest.quest_receiver_reference)
				var/mob/receiver = assigned_quest.quest_receiver_reference.resolve()
				if(receiver && (receiver in SStreasury.bank_accounts))
					SStreasury.bank_accounts[receiver] += refund
					SStreasury.treasury_value -= refund
					SStreasury.log_entries += "-[refund] from treasury (quest scroll destroyed refund to receiver [receiver.real_name])"

		// Clean up the quest
		qdel(assigned_quest)
		assigned_quest = null

	return ..()

/obj/item/paper/scroll/quest/update_icon_state()
	if(open)
		icon_state = info ? "[base_icon_state]_info" : "[base_icon_state]"
	else
		icon_state = "[base_icon_state]_closed"

/obj/item/paper/scroll/quest/examine(mob/user)
	. = ..()
	if(!assigned_quest)
		return
	if(!assigned_quest.quest_receiver_reference)
		. += span_notice("This quest hasn't been claimed yet. Open it to claim it for yourself!")
	else if(assigned_quest.complete)
		. += span_notice("\nThis quest is complete! Return it to the Quest Book to claim your reward.")
		. += span_info("\nPlace it on the marked area next to the book.")
	else
		. += span_notice("\nThis quest is still in progress.")

/obj/item/paper/scroll/quest/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(P.get_sharpness())
		to_chat(user, span_warning("The enchanted scroll resists your attempts to tear it."))
		return
	if(istype(P, /obj/item/paper)) // Prevent merging with other papers/scrolls
		to_chat(user, span_warning("The magical energies prevent you from combining this with other scrolls."))
		return
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(!open)
			to_chat(user, span_warning("You need to open the scroll first."))
			return
		if(!assigned_quest)
			to_chat(user, span_warning("This quest scroll doesn't accept modifications."))
			return
	..()

/obj/item/paper/scroll/quest/fire_act(exposed_temperature, exposed_volume)
	return // Immune to fire

/obj/item/paper/scroll/quest/extinguish()
	return // No fire to extinguish

/obj/item/paper/scroll/quest/attack_self(mob/user)
	. = ..()
	if(.)
		return

	// Only do claim logic if unclaimed
	if(!assigned_quest || assigned_quest.quest_receiver_reference)
		refresh_compass(user) // Refresh compass when opened by claimed user
		update_quest_text()
		return

	// Handle initial claiming of the quest
	if(!assigned_quest.quest_receiver_reference)
		// Custom quests can only be claimed by non-guild-handlers
		if(istype(assigned_quest, /datum/quest/custom) && user.job == "Guild Handler")
			to_chat(user, span_warning("Guild Handlers cannot claim custom quests!"))
			return
			
		assigned_quest.quest_receiver_reference = WEAKREF(user)
		assigned_quest.quest_receiver_name = user.real_name
		to_chat(user, span_notice("You claim this quest for yourself!"))
		refresh_compass(user)
		update_quest_text()
		return

	// Standard behavior for non-custom quests
	if(!assigned_quest.quest_receiver_reference)
		assigned_quest.quest_receiver_reference = WEAKREF(user)
		assigned_quest.quest_receiver_name = user.real_name

		if(assigned_quest.quest_type == "Beacon" && assigned_quest.beacon_connection && length(assigned_quest.possible_beacons))
			var/list/valid_beacons = list()
			for(var/obj/structure/roguemachine/teleport_beacon/beacon in assigned_quest.possible_beacons)
				if(!(user.real_name in beacon.granted_list) && beacon != src)
					valid_beacons += beacon

			if(length(valid_beacons))
				var/list/difficulty_beacons = list()
				for(var/obj/structure/roguemachine/teleport_beacon/beacon in valid_beacons)
					if(beacon.quest_difficulty == assigned_quest.quest_difficulty)
						difficulty_beacons += beacon

				assigned_quest.possible_beacons = length(difficulty_beacons) ? difficulty_beacons : valid_beacons
				assigned_quest.target_beacon = pick(assigned_quest.possible_beacons)
		else
			to_chat(user, span_warning("There are no unconnected beacons available for this quest!"))

		to_chat(user, span_notice("You claim this quest for yourself!"))
		refresh_compass(user)

/obj/item/paper/scroll/quest/proc/update_quest_text()
	if(!assigned_quest)
		return

	var/scroll_text = "<center>[istype(assigned_quest, /datum/quest/custom) ? "CUSTOM QUEST" : "HELP NEEDED"]</center><br>"
	scroll_text += "<center><b>[assigned_quest.title]</b></center><br><br>"
	scroll_text += "<b>Issued by:</b> [assigned_quest.quest_giver_name ? "Guild Handler [assigned_quest.quest_giver_name]" : "The Adventurer's Guild"].<br>"
	scroll_text += "<b>Issued to:</b> [assigned_quest.quest_receiver_name ? assigned_quest.quest_receiver_name : "whoever it may concern"].<br>"
	
	if(istype(assigned_quest, /datum/quest/custom))
		var/datum/quest/custom/custom_quest = assigned_quest
		scroll_text += "<b>Type:</b> Custom assignment<br>"
		scroll_text += "<b>Difficulty:</b> Special<br><br>"
		scroll_text += "<b>Objectives:</b><br>"
		if(custom_quest.objectives && length(custom_quest.objectives))
			scroll_text += jointext(custom_quest.objectives, "<br>")
		else
			scroll_text += "Complete the tasks assigned by the quest giver.<br>"
		scroll_text += "<br>"

		// Add interaction buttons for custom quests
		var/mob/user = usr
		if(user && custom_quest.quest_receiver_reference?.resolve() == user)
			if(!custom_quest.complete)
				if(custom_quest.report_submitted)
					scroll_text += "<br><a href='?src=[REF(src)];withdraw_report=1'>Withdraw Completion Report</a>"
				else
					scroll_text += "<br><a href='?src=[REF(src)];submit_report=1'>Submit Completion Report</a>"
					scroll_text += "<br><a href='?src=[REF(src)];request_changes=1'>Request Quest Modifications</a>"
	else
		scroll_text += "<b>Type:</b> [assigned_quest.quest_type] quest.<br>"
		scroll_text += "<b>Difficulty:</b> [assigned_quest.quest_difficulty].<br><br>"

		if(last_compass_direction)
			scroll_text += "<b>Direction:</b> [last_compass_direction]. "
			if(last_z_level_hint)
				scroll_text += " ([last_z_level_hint])"
			scroll_text += "<br>"

		switch(assigned_quest.quest_type)
			if("Fetch")
				scroll_text += "<b>Objective:</b> Retrieve [assigned_quest.target_amount] [initial(assigned_quest.target_item_type.name)].<br>"
				scroll_text += "<b>Last Seen Location:</b> Reported sighting in [assigned_quest.target_spawn_area] region.<br>"
			if("Kill", "Miniboss")
				scroll_text += "<b>Objective:</b> Slay [assigned_quest.target_amount] [initial(assigned_quest.target_mob_type.name)].<br>"
				scroll_text += "<b>Last Seen Location:</b> [assigned_quest.target_spawn_area ? "Reported sighting in [assigned_quest.target_spawn_area] region." : "Reported sighting in Sunmarch region."]<br>"
			if("Clear Out")
				scroll_text += "<b>Objective:</b> Eliminate [assigned_quest.target_amount] [initial(assigned_quest.target_mob_type.name)].<br>"
				scroll_text += "<b>Infestation Location:</b> [assigned_quest.target_spawn_area ? "Reported sighting in [assigned_quest.target_spawn_area] region." : "Reported infestations in Sunmarch region."]<br>"
			if("Courier")
				scroll_text += "<b>Objective:</b> Deliver [initial(assigned_quest.target_delivery_item.name)] to [initial(assigned_quest.target_delivery_location.name)].<br>"
				scroll_text += "<b>Delivery Instructions:</b> Package must remain intact and be delivered directly to the recipient.<br>"
				scroll_text += "<b>Destination Description:</b> [initial(assigned_quest.target_delivery_location.brief_descriptor)].<br>"
			if("Beacon")
				if(assigned_quest.target_beacon)
					var/area/beacon_area = get_area(assigned_quest.target_beacon)
					scroll_text += "<b>Objective:</b> Activate the Kasmidian beacon in [beacon_area.name]<br>"
					scroll_text += "<b>Beacon Name:</b> [assigned_quest.target_beacon.name]<br>"
					scroll_text += "<b>Location Description:</b> [beacon_area.desc]<br>"
					scroll_text += "<b>Activation Method:</b> Simply interact with the beacon once found<br>"

	scroll_text += "<br><b>Reward:</b> [assigned_quest.reward_amount] marks upon completion<br>"

	if(assigned_quest.complete)
		scroll_text += "<br><center><b>QUEST COMPLETE</b></center>"
		scroll_text += "<br><b>Return this scroll to the Quest Book to claim your reward!</b>"
		scroll_text += "<br><i>Place it on the marked area next to the book.</i>"
	else if(istype(assigned_quest, /datum/quest/custom))
		scroll_text += "<br><i>Report back to the quest giver when completed.</i>"
	else
		scroll_text += "<br><i>The magic in this scroll will update as you progress.</i>"

	info = scroll_text
	update_icon()

/obj/item/paper/scroll/quest/Topic(href, href_list)
	if(!usr || usr.incapacitated())
		return

	if(!(src in usr.contents) && !(isturf(loc) && in_range(src, usr)))
		to_chat(usr, span_warning("You need to hold the scroll to interact with it!"))
		return

	if(href_list["close"])
		var/mob/user = usr
		if(user?.client && user.hud_used)
			if(user.hud_used.reads)
				user.hud_used.reads.destroy_read()
			user << browse(null, "window=reading")

	if(!assigned_quest || !istype(assigned_quest, /datum/quest/custom))
		return

	var/datum/quest/custom/custom_quest = assigned_quest
	var/mob/user = usr

	if(href_list["submit_report"])
		if(custom_quest.report_submitted)
			to_chat(user, span_warning("You've already submitted a completion report!"))
			return

		var/report = input(user, "Describe your completion of this quest:", "Quest Completion Report") as message|null
		if(!report)
			return

		custom_quest.custom_report = report
		custom_quest.report_submitted = TRUE
		custom_quest.report_submitted_by = user.real_name

		// Notify the quest giver
		var/mob/giver = custom_quest.quest_giver_reference?.resolve()
		if(giver)
			to_chat(giver, span_notice("[user.real_name] has submitted a completion report for your quest '[custom_quest.title]'!"))
			to_chat(giver, span_info("Report: [report]"))

		to_chat(user, span_notice("Completion report submitted to [custom_quest.quest_giver_name]!"))
		update_quest_text()

	if(href_list["withdraw_report"])
		if(!custom_quest.report_submitted)
			to_chat(user, span_warning("No report to withdraw!"))
			return

		custom_quest.report_submitted = FALSE
		custom_quest.custom_report = null
		to_chat(user, span_notice("You've withdrawn your completion report."))
		update_quest_text()

	if(href_list["request_changes"])
		if(custom_quest.report_submitted)
			to_chat(user, span_warning("You've already submitted a completion report!"))
			return

		var/request = input(user, "What modifications would you like to request for this quest?", "Quest Modification Request") as message|null
		if(!request)
			return

		var/mob/giver = custom_quest.quest_giver_reference?.resolve()
		if(giver)
			to_chat(giver, span_notice("[user.real_name] has requested modifications to your quest '[custom_quest.title]'!"))
			to_chat(giver, span_info("Request: [request]"))
			to_chat(giver, span_info("You can review and modify the quest at the quest book."))

		to_chat(user, span_notice("Modification request sent to [custom_quest.quest_giver_name]!"))

/obj/item/paper/scroll/quest/proc/refresh_compass(mob/user)
	if(!assigned_quest || assigned_quest.complete)
		return FALSE

	// Update compass with precise directions
	update_compass(user)

	// Only update text if we have a valid direction
	if(last_compass_direction)
		update_quest_text()
		return TRUE

	return FALSE

/obj/item/paper/scroll/quest/proc/update_compass(mob/user)
	if(!assigned_quest || assigned_quest.complete)
		return

	var/turf/user_turf = user ? get_turf(user) : get_turf(src)
	if(!user_turf)
		last_compass_direction = "No signal detected"
		last_z_level_hint = ""
		return

	// Reset compass values
	last_compass_direction = "Searching for target..."
	last_z_level_hint = ""

	var/atom/target
	var/turf/target_turf
	var/min_distance = INFINITY

	// Find the appropriate target based on quest type
	switch(assigned_quest.quest_type)
		if("Fetch")
			// Find the closest fetch item
			for(var/obj/item/I in world)
				if(istype(I, assigned_quest.target_item_type))
					var/datum/component/quest_object/Q = I.GetComponent(/datum/component/quest_object)
					if(Q && Q.quest_ref?.resolve() == assigned_quest)
						var/dist = get_dist(user_turf, I)
						if(!target || dist < min_distance)
							target = I
							min_distance = dist
		if("Courier")
			// Find the delivery location area
			var/area/target_area = assigned_quest.target_delivery_location
			if(target_area)
				var/list/area_turfs = get_area_turfs(target_area)
				if(length(area_turfs))
					var/turf/center_turf = locate(world.maxx/2, world.maxy/2, user_turf.z)
					min_distance = get_dist(user_turf, center_turf)
					target = center_turf
		if("Kill", "Clear Out", "Miniboss")
			// Find the closest target mob
			for(var/mob/living/M in world)
				if(istype(M, assigned_quest.target_mob_type))
					var/datum/component/quest_object/Q = M.GetComponent(/datum/component/quest_object)
					if(Q && Q.quest_ref?.resolve() == assigned_quest)
						var/dist = get_dist(user_turf, M)
						if(!target || dist < min_distance)
							target = M
							min_distance = dist
		if("Beacon")
			if(assigned_quest.target_beacon)
				min_distance = get_dist(user_turf, assigned_quest.target_beacon)
				target = assigned_quest.target_beacon

	if(!target || !(target_turf = get_turf(target)))
		last_compass_direction = "Target location unknown"
		last_z_level_hint = ""
		return

	// Handle Z-level differences first
	if(target_turf.z != user_turf.z)
		var/z_diff = abs(target_turf.z - user_turf.z)
		last_compass_direction = "Target is on another level"
		last_z_level_hint = target_turf.z > user_turf.z ? \
			"[z_diff] level\s above you" : \
			"[z_diff] level\s below you"
		return

	// Calculate direction from user to target
	var/dx = target_turf.x - user_turf.x  // EAST direction
	var/dy = target_turf.y - user_turf.y  // NORTH direction

	var/distance = sqrt(dx*dx + dy*dy)

	// If very close, don't show direction
	if(distance <= 7)
		last_compass_direction = "Target is nearby"
		last_z_level_hint = ""
		return

	// Calculate angle in degrees (0 = east, 90 = north)
	var/angle = ATAN2(dx, dy)

	if(angle < 0)
		angle += 360

	// Get precise direction text
	var/direction_text = get_precise_direction_from_angle(angle)

	// Determine distance description
	var/distance_text
	switch(distance)
		if(0 to 14)
			distance_text = "very close"
		if(15 to 40)
			distance_text = "close"
		if(41 to 100)
			distance_text = ""
		if(101 to INFINITY)
			distance_text = "far away"

	last_compass_direction = "Target is [distance_text] to the [direction_text]"
	last_z_level_hint = "on this level"

/obj/item/paper/scroll/quest/proc/get_precise_direction_from_angle(angle)
	// ATAN2 gives angle from positive x-axis (east) to the vector
	// We need to:
	// 1. Convert to compass degrees (0°=north, 90°=east)
	// 2. Invert the direction (show direction TO target FROM player)

	// Normalize angle first
	angle = (angle + 360) % 360

	// Convert to compass bearing (0°=north, 90°=east)
	var/compass_angle = (450 - angle) % 360  // 450 = 360 + 90

	// Return direction based on inverted compass angle
	switch(compass_angle)
		if(348.75 to 360, 0 to 11.25)
			return "north"
		if(11.25 to 33.75)
			return "north-northeast"
		if(33.75 to 56.25)
			return "northeast"
		if(56.25 to 78.75)
			return "east-northeast"
		if(78.75 to 101.25)
			return "east"
		if(101.25 to 123.75)
			return "east-southeast"
		if(123.75 to 146.25)
			return "southeast"
		if(146.25 to 168.75)
			return "south-southeast"
		if(168.75 to 191.25)
			return "south"
		if(191.25 to 213.75)
			return "south-southwest"
		if(213.75 to 236.25)
			return "southwest"
		if(236.25 to 258.75)
			return "west-southwest"
		if(258.75 to 281.25)
			return "west"
		if(281.25 to 303.75)
			return "west-northwest"
		if(303.75 to 326.25)
			return "northwest"
		if(326.25 to 348.75)
			return "north-northwest"

/obj/item/parcel
	name = "parcel wrapping paper"
	desc = "A sturdy piece of paper used to wrap items for secure delivery. The final size of the parcel depends on the size of the original item."
	icon = 'modular/Neu_food/icons/ration.dmi'
	icon_state = "ration_wrapper"
	w_class = WEIGHT_CLASS_TINY
	grid_height = 32
	grid_width = 32
	dropshrink = 0.6
	var/obj/item/contained_item = null
	var/list/allowed_jobs = list()
	var/delivery_area_type

/obj/item/parcel/Initialize(mapload)
	. = ..()
	var/datum/component/quest_object/courier_quest = GetComponent(/datum/component/quest_object)
	if(courier_quest)
		var/datum/quest/quest = courier_quest.quest_ref?.resolve()
		if(quest && quest.quest_type == "Courier" && quest.target_delivery_location)
			delivery_area_type = quest.target_delivery_location
			allowed_jobs = get_area_jobs(delivery_area_type)
			RegisterSignal(courier_quest, COMSIG_PARENT_QDELETING, PROC_REF(on_quest_component_deleted))

/obj/item/parcel/proc/get_area_jobs(area_type)
	var/static/list/area_jobs = list(
		/area/provincial/indoors/town/tavern = list("Guild Handler", "Innkeeper", "Tapster"),
		/area/provincial/indoors/town/church = list("Guild Handler", "Priest", "Acolyte", "Templar", "Churchling"),
		/area/provincial/indoors/town/farm = list("Guild Handler", "Soilson"),
		/area/provincial/indoors/town/blacksmith = list("Guild Handler", "Blacksmith"),
		/area/provincial/indoors/town/shop = list("Guild Handler", "Merchant", "Shophand"),
		/area/provincial/indoors/town/province_keep = list("Guild Handler", "Nobleman", "Hand", "Knight Captain", "Marshal", "Steward", "Clerk", "Head Mage", "Marquis"),
		/area/provincial/indoors/town/mages_university = list("Guild Handler", "Head Mage", "Archivist", "Artificer", "Apothicant Apprentice", "Apprentice Magician"),
		/area/provincial/indoors/town/mages_university/alchemy_lab = list("Guild Handler", "Head Mage", "Archivist", "Artificer", "Apothicant Apprentice", "Apprentice Magician"),
		/area/provincial/indoors/town/steward = list("Guild Handler", "Steward", "Marquis"),
		/area/provincial/indoors/town = list("Guild Handler")
	)
	return area_jobs[area_type] || list("Guild Handler")

/obj/item/parcel/proc/on_quest_component_deleted(datum/source)
	SIGNAL_HANDLER
	return

/obj/item/parcel/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/parcel) || I.w_class > WEIGHT_CLASS_BULKY || contained_item)
		to_chat(user, span_warning("You can't wrap this in [src]."))
		return

	if(do_after(user, 2 SECONDS, target = src))
		user.transferItemToLoc(I, src)
		contained_item = I
		name = "parcel ([I.name])"
		desc = "A securely wrapped parcel containing [I.name]."
		icon_state = I.w_class >= WEIGHT_CLASS_NORMAL ? "ration_large" : "ration_small"
		dropshrink = 1
		update_icon()
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		to_chat(user, span_notice("You wrap [I] in the parcel wrapper."))

/obj/item/parcel/attack_self(mob/user)
	if(!contained_item)
		return

	if(delivery_area_type)
		var/area/quest_area = delivery_area_type
		if(ispath(quest_area, /area) && !(user.job in allowed_jobs))
			to_chat(user, span_warning("This parcel is sealed for delivery to [initial(quest_area.name)] and can only be opened by: [english_list(allowed_jobs)]!"))
			return FALSE

	if(do_after(user, 2 SECONDS, target = src))
		to_chat(user, span_notice("You unwrap [contained_item] from the parcel."))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		user.put_in_hands(contained_item)
		contained_item.update_icon()
		contained_item = null
		qdel(src)

/obj/item/parcel/examine(mob/user)
	. = ..()
	if(!delivery_area_type)
		return

	var/area/delivery_area = delivery_area_type
	if(!ispath(delivery_area, /area))
		return

	. += span_info("This parcel is addressed to [initial(delivery_area.name)].")
	. += (user.job in allowed_jobs) ? \
		span_notice("As [user.job], you're authorized to open this.") : \
		span_warning("It's sealed with an official guild mark - only authorized personnel should open this!")

/obj/item/guild_upgrade_kit
	name = "guild upgrade kit"
	desc = "A kit containing materials to upgrade guild facilities."
	icon = 'modular/Neu_food/icons/ration.dmi'
	icon_state = "ration_large"
	w_class = WEIGHT_CLASS_NORMAL
	var/datum/guild_upgrade/upgrade_datum

/obj/item/guild_upgrade_kit/Initialize(mapload, upgrade_type)
	. = ..()
	if(upgrade_type)
		upgrade_datum = new upgrade_type()
	else
		upgrade_datum = new /datum/guild_upgrade/hearth()
	
	name = "[upgrade_datum.name] Kit"
	desc = "Install on a [upgrade_datum.category] slot. Provides: [english_list(upgrade_datum.active_effects)]"

/obj/item/guild_upgrade_kit/attack_self(mob/user)
	. = ..()
	if(.)
		return
	
	to_chat(user, span_notice("This is a [upgrade_datum.category] upgrade kit. Look for [upgrade_datum.category] markers on the ground."))
	return FALSE

/obj/item/guild_upgrade_kit/examine(mob/user)
	. = ..()
	. += span_notice("Installation Cost: [upgrade_datum.cost] marks")
	if(upgrade_datum.bonus > 0)
		. += span_green("Immediate Bonus: +[upgrade_datum.bonus] marks (deposited directly to your account)")
	if(upgrade_datum.active_effects.len)
		. += span_info("Creates: [english_list(upgrade_datum.active_effects)]")
	if(upgrade_datum.passive_effects)
		. += span_blue("Passive Effect: [upgrade_datum.passive_effects]")
	. += upgrade_datum.outdoor_only ? span_info("Must be installed OUTSIDE the guild") : span_info("Must be installed INSIDE the guild")
	. += span_notice("Look for [upgrade_datum.category]-marked slots on the ground to install this.")

/obj/item/guild_upgrade_kit/proc/attempt_refund(mob/user)
	if(user.job != "Guild Handler")
		return FALSE
	
	var/refund_amount = round(upgrade_datum.cost * (upgrade_datum.refund_value/100))
	if(refund_amount <= 0)
		return FALSE
	
	if(user in SStreasury.bank_accounts)
		SStreasury.bank_accounts[user] += refund_amount
		SStreasury.treasury_value -= refund_amount
		SStreasury.log_entries += "+[refund_amount] to [user.real_name] (upgrade kit refund)"
		to_chat(user, span_notice("You receive a [refund_amount] mark refund for the [name]."))
		qdel(src)
		return TRUE
	
	// Fallback to physical coins if no bank account
	var/obj/item/roguecoin/gold/gold_coins = new(get_turf(user))
	var/obj/item/roguecoin/silver/silver_coins = new(get_turf(user))
	var/obj/item/roguecoin/copper/copper_coins = new(get_turf(user))

	gold_coins.quantity = FLOOR(refund_amount / 10, 1)
	silver_coins.quantity = FLOOR(refund_amount % 10 / 5, 1)
	copper_coins.quantity = refund_amount % 5

	gold_coins.update_icon()
	silver_coins.update_icon()
	copper_coins.update_icon()

	to_chat(user, span_notice("[refund_amount] marks worth of coins have been dispensed as your refund."))
	qdel(src)
	return TRUE

/obj/structure/fluff/statue/knightalt/r/guild/examine(mob/user)
	. = ..()
	if(user.job == "Adventurer")
		. += span_notice("An imposing statue of a legendary knight. It fills you with [span_red("DETERMINATION")].")
		user.add_stress(/datum/stressevent/meditation)

/obj/structure/well/fountain/town_center
	pixel_x = -18

/obj/machinery/tanningrack/guild
	name = "guild tanning rack"
	desc = "A sturdy drying rack provided by the Adventurers' Guild. It can be used to tan hides as normal, and occasionally provides equipment to adventurers."
	var/list/received_adventurers = list() // Tracks who has received equipment

/obj/machinery/tanningrack/guild/attack_hand(mob/living/user)
	if(!hide && user.job == "Adventurer" && !received_adventurers[user.ckey])

		// Give random equipment
		var/obj/item/new_item
		switch(rand(1,3))
			if(1)
				new_item = new /obj/item/reagent_containers/glass/bottle/waterskin(get_turf(user))
			if(2)
				new_item = new /obj/item/bedroll(get_turf(user))
			if(3)
				new_item = new /obj/item/storage/backpack/rogue/backpack(get_turf(user))

		if(new_item)
			user.put_in_hands(new_item)
			to_chat(user, span_notice("The guild's tanning rack provides you with [new_item.name]!"))
			received_adventurers[user.ckey] = TRUE
			return

	// Fall back to normal behavior
	..()

/obj/machinery/tanningrack/guild/examine(mob/user)
	. = ..()
	if(user.job == "Adventurer" && !received_adventurers[user.ckey])
		. += span_notice("This guild-provided rack might have some equipment for you.")
