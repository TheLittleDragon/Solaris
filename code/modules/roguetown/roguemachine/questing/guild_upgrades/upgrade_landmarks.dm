/obj/effect/landmark/guild_upgrade
	name = "guild upgrade slot"
	icon = 'code/modules/roguetown/roguemachine/questing/questing.dmi'
	icon_state = "upgrade_slot"
	var/upgrade_category = "utility"

/obj/effect/landmark/guild_upgrade/Initialize()
	. = ..()
	// Spawn appropriate visual marker
	var/obj/effect/decal/questing/marker_upgrade/marker
	switch(upgrade_category)
		if("utility")
			marker = new /obj/effect/decal/questing/marker_upgrade/utility(get_turf(src))
		if("convenience")
			marker = new /obj/effect/decal/questing/marker_upgrade/convenience(get_turf(src))
		if("storage")
			marker = new /obj/effect/decal/questing/marker_upgrade/storage(get_turf(src))
		else
			marker = new /obj/effect/decal/questing/marker_upgrade(get_turf(src))
	
	marker.upgrade_category = upgrade_category
	marker.desc = "Accepts [upgrade_category] upgrade kits."

/obj/effect/landmark/guild_upgrade/Crossed(atom/movable/AM)
	. = ..()
	if(!istype(AM, /obj/item/guild_upgrade_kit))
		return
	var/obj/item/guild_upgrade_kit/kit = AM
	if(kit.upgrade_datum.category == upgrade_category)
		// Apply directional pixel shift before installation
		if(kit.upgrade_datum.direction)
			switch(kit.upgrade_datum.direction)
				if("north")
					kit.pixel_y += 32
				if("south")
					kit.pixel_y -= 32
				if("east")
					kit.pixel_x += 32
				if("west")
					kit.pixel_x -= 32

		var/mob/user = null
		if(ismob(AM.loc))
			user = AM.loc
		try_install_upgrade(kit, user)

/obj/effect/landmark/guild_upgrade/Destroy()
	// Clean up our marker if it exists
	for(var/obj/effect/decal/questing/marker_upgrade/deleting_marker in get_turf(src))
		if(deleting_marker.upgrade_category == upgrade_category)
			qdel(deleting_marker)
	return ..()

/obj/effect/landmark/guild_upgrade/proc/try_install_upgrade(obj/item/guild_upgrade_kit/kit, mob/user)
	// Check area restrictions first
	var/area/install_area = get_area(src)
	if(kit.upgrade_datum.outdoor_only && istype(install_area, /area/provincial/indoors/town/adventurers_guild))
		if(user)
			to_chat(user, span_warning("This upgrade must be installed outside the guild hall!"))
		return FALSE
	if(!kit.upgrade_datum.outdoor_only && !istype(install_area, /area/provincial/indoors/town/adventurers_guild))
		if(user)
			to_chat(user, span_warning("This upgrade must be installed inside the guild hall!"))
		return FALSE

	// Check for conflicting upgrades
	for(var/datum/guild_upgrade/existing in SSroguemachine.guild_upgrades)
		if(kit.upgrade_datum.type in existing.conflicts_with)
			if(user)
				to_chat(user, span_warning("This upgrade conflicts with [existing.name] which is already installed!"))
			return FALSE

	// Get directional shifts from the upgrade datum
	var/list/shifts = list(0, 0)
	if(kit.upgrade_datum.direction)
		switch(kit.upgrade_datum.direction)
			if("north")
				shifts = list(0, 32)
			if("south")
				shifts = list(0, -32)
			if("east")
				shifts = list(32, 0)
			if("west")
				shifts = list(-32, 0)

	var/pixel_x_shift = shifts[1]
	var/pixel_y_shift = shifts[2]

	// Apply the upgrade
	var/turf/install_turf = get_turf(src)
	if(!kit.upgrade_datum.apply_upgrade(install_turf, user))
		if(user)
			to_chat(user, span_warning("Failed to install [kit]!"))
		return FALSE

	// Apply pixel shifts to spawned objects
	for(var/obj/O in install_turf)
		if(O.type in kit.upgrade_datum.active_effects)
			O.pixel_x = pixel_x_shift
			O.pixel_y = pixel_y_shift

	// Cleanup and feedback
	SSroguemachine.guild_upgrades += kit.upgrade_datum
	if(user)
		user.visible_message(
			span_notice("[user] installs [kit] into [src]!"), 
			span_notice("You install [kit] into [src]!")
		)
		user.temporarilyRemoveItemFromInventory(kit)
	else
		visible_message(span_notice("[kit] snaps into place in [src]!"))

	qdel(kit)
	qdel(src)
	return TRUE

// Category-specific subtypes
/obj/effect/landmark/guild_upgrade/utility
	name = "utility upgrade slot"
	upgrade_category = "utility"
	icon_state = "upgrade_slot_utility"

/obj/effect/landmark/guild_upgrade/convenience
	name = "convenience upgrade slot"
	upgrade_category = "convenience"
	icon_state = "upgrade_slot_convenience"

/obj/effect/landmark/guild_upgrade/storage
	name = "storage upgrade slot"
	upgrade_category = "storage"
	icon_state = "upgrade_slot_storage"
