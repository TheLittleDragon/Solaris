/obj/effect/proc_holder/spell/targeted/touch/darkvision
	name = "Darkvision"
	desc = "Enhance the night vision of a target you touch for 15 minutes."
	clothes_req = FALSE
	drawmessage = "I prepare to grant Darkvision."
	dropmessage = "I release my arcane focus."
	school = "transmutation"
	recharge_time = 1 MINUTES
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	hand_path = /obj/item/melee/touch_attack/darkvision
	spell_tier = 1
	invocation = "Nox Oculus"
	invocation_type = "whisper"
	hide_charge_effect = TRUE
	xp_gain = TRUE
	cost = 2

/obj/item/melee/touch_attack/darkvision
	name = "\improper arcane focus"
	desc = "Touch a creature to grant them Darkvision for 15 minutes."
	catchphrase = null
	possible_item_intents = list(INTENT_HELP)
	icon = 'icons/mob/roguehudgrabs.dmi'
	icon_state = "pulling"
	icon_state = "grabbing_greyscale"
	color = "#3FBAFD"
	associated_skill = /datum/skill/magic/arcane

/obj/item/melee/touch_attack/darkvision/attack_self()
	attached_spell.remove_hand()

/obj/item/melee/touch_attack/darkvision/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(isliving(target))
		var/mob/living/spelltarget = target
		if(!do_after(user, 5 SECONDS, target = spelltarget))
			return
		spelltarget.apply_status_effect(/datum/status_effect/buff/darkvision)
		user.rogfat_add(80)
		user.mind.add_sleep_experience(associated_skill, 48, FALSE) // XP Magical number should be 60% of stamina used (so 80*0.6 = 48)
		if(spelltarget != user)
			user.visible_message("[user] draws a glyph in the air and touches [spelltarget] with an arcane focus.")
		else
			user.visible_message("[user] draws a glyph in the air and touches themselves with an arcane focus.")
		attached_spell.remove_hand()
	return
