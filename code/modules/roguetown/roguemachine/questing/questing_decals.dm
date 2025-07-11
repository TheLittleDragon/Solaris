/obj/effect/decal/questing
	icon = 'code/modules/roguetown/roguemachine/questing/questing.dmi'

/obj/effect/decal/questing/marker_export
	icon_state = "marker_export"

/obj/effect/decal/questing/marker_upgrade
	name = "upgrade slot marker"
	var/upgrade_category = "utility"
	icon_state = "marker_export"

/obj/effect/decal/questing/marker_upgrade/attackby(obj/item/I, mob/user)
	if(!istype(I, /obj/item/guild_upgrade_kit))
		return ..()

	var/obj/item/guild_upgrade_kit/kit = I
	if(kit.upgrade_datum.category != upgrade_category)
		to_chat(user, span_warning("This upgrade kit is for [kit.upgrade_datum.category] slots, but this is a [upgrade_category] slot!"))
		return

	// Show hologram preview
	show_upgrade_preview(kit.upgrade_datum, user)
	return TRUE

/obj/effect/decal/questing/marker_upgrade/proc/show_upgrade_preview(datum/guild_upgrade/upgrade, mob/user)
	// Clear any existing preview
	clear_preview()

	// Create temporary holograms for each active effect
	for(var/path in upgrade.active_effects)
		var/obj/effect/temp_visual/hologram/holo = new(get_turf(src), path)
		holo.color = "#00FFFF"
		holo.alpha = 150
		holo.layer = ABOVE_MOB_LAYER
		// Adjust position based on landmark direction
		adjust_holo_position(holo)
		QDEL_IN(holo, 3 SECONDS)

	// Show upgrade info
	var/list/info_lines = list()
	info_lines += span_notice("[upgrade.name] Preview:")
	info_lines += span_info("Cost: [upgrade.cost] marks")
	if(upgrade.bonus > 0)
		info_lines += span_green("Bonus: +[upgrade.bonus] marks")
	if(upgrade.passive_effects)
		info_lines += span_blue("Passive: [upgrade.passive_effects]")
	info_lines += upgrade.outdoor_only ? span_info("Must be installed OUTSIDE") : span_info("Must be installed INSIDE")

	to_chat(user, jointext(info_lines, "\n"))

/obj/effect/decal/questing/marker_upgrade/proc/adjust_holo_position(obj/effect/temp_visual/hologram/holo)
	// Get the upgrade datum from the preview
	var/datum/guild_upgrade/upgrade = locate() in GLOB.all_guild_upgrades
	if(!upgrade || !upgrade.direction)
		return

	// Apply pixel shifts based on direction
	switch(upgrade.direction)
		if("north")
			holo.pixel_y += 32
		if("south")
			holo.pixel_y -= 32
		if("east")
			holo.pixel_x += 32
		if("west")
			holo.pixel_x -= 32

/obj/effect/decal/questing/marker_upgrade/proc/clear_preview()
	for(var/obj/effect/temp_visual/hologram/H in get_turf(src))
		qdel(H)

/obj/effect/decal/questing/marker_upgrade/utility
	icon_state = "marker_utility"
	upgrade_category = "utility"

/obj/effect/decal/questing/marker_upgrade/convenience
	icon_state = "marker_convenience"
	upgrade_category = "convenience"

/obj/effect/decal/questing/marker_upgrade/storage
	icon_state = "marker_storage"
	upgrade_category = "storage"
