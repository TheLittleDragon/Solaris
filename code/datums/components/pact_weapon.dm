/datum/component/pact_weapon
	var/obj/item/rogueweapon/weapon
	var/mob/living/weapon_owner //who owns this pact weapon
	var/patronchoice

/datum/component/pact_weapon/Initialize(mob/living/L, pc)
	if(!istype(parent, /obj/item/rogueweapon))
		return COMPONENT_INCOMPATIBLE
	else
		patronchoice = pc
		weapon_owner = L
		weapon = parent
		weapon.name += " of the [patronchoice]"
		weapon.desc += " It is enchanted to use arcane skill rather than its regular skill."
		weapon.force *= 1.2
		weapon.force_wielded *= 1.2
		weapon.throwforce *= 1.2
		weapon.block_chance *= 1.2
		weapon.armor_penetration *= 1.2
		weapon.wdefense *= 1.2
		weapon.max_blade_int *= 1.2
		weapon.blade_int = weapon.max_blade_int
		weapon.max_integrity *= 2
		weapon.obj_integrity = weapon.max_integrity
		weapon.minstr = 1
		ADD_TRAIT(weapon, TRAIT_NOEMBED, TRAIT_GENERIC)
		weapon.associated_skill = /datum/skill/magic/arcane
		var/mutable_appearance/magic_overlay = mutable_appearance('icons/effects/effects.dmi', "electricity")
		weapon.add_overlay(magic_overlay)

/datum/component/pact_weapon/RegisterWithParent()
	if(istype(parent, /obj/item))
		var/obj/item/weapon_parent = parent
		RegisterSignal(weapon_parent, COMSIG_ITEM_EQUIPPED,PROC_REF(equipped))
		RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(dropped))

/datum/component/pact_weapon/proc/equipped(obj/item/source, mob/user, slot)
	var/mob/living/target = user
	if(target != weapon_owner) //you dont own the weapon
		target.apply_status_effect(/datum/status_effect/buff/pact_weapon_debuff)

/datum/component/pact_weapon/proc/dropped(obj/item/source, mob/user)
	var/mob/living/target = user
	if(target != weapon_owner) //you dont own the weapon
		target.remove_status_effect(/datum/status_effect/buff/pact_weapon_debuff) //remove the debuff

/datum/status_effect/buff/pact_weapon_debuff
	id = "pact weapon debuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/pact_weapon_debuff
	duration = -1

/datum/status_effect/buff/pact_weapon_debuff/tick()
	var/mob/living/target = owner
	var/prompt = pick(1,2,3,4,5)
	if(prompt == 1)
		target.adjustFireLoss(5)
		to_chat(target, span_warning("I am burned by an item I have equipped!"))
		owner.playsound_local(get_turf(owner), 'sound/combat/hits/burn (1).ogg', 35, FALSE, pressure_affected = FALSE)

/atom/movable/screen/alert/status_effect/buff/pact_weapon_debuff
	name = "Cursed Item"
	desc = "An item I have equipped burns me periodically."
	icon_state = "debuff"
