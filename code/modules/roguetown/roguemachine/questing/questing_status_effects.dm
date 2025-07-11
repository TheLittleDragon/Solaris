/datum/status_effect/free_teleport_guild
	id = "free_teleport_guild"
	duration = -1 // Lasts until manually removed
	alert_type = /atom/movable/screen/alert/status_effect/free_teleport_guild

/datum/status_effect/free_teleport_guild/tick()
	if(station_time() == SSnightshift.nightshift_dawn_start)
		owner.remove_status_effect(src.type)
		to_chat(owner, span_notice("Your free teleport from the Beacon Statue has expired with the dawn."))

/atom/movable/screen/alert/status_effect/free_teleport_guild
	name = "Guild Teleport Privilege"
	desc = "The Beacon Statue grants you one free teleport until dawn."
	icon = 'icons/mob/screen_alert.dmi'
	icon_state = "mail"
