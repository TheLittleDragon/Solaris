/obj/item/clothing/shoes/roguetown
	name = "shoes"
	icon = 'icons/roguetown/clothing/feet.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/feet.dmi'
	desc = ""
	gender = PLURAL
	slot_flags = ITEM_SLOT_SHOES
	body_parts_covered = FEET
	body_parts_inherent = FEET
	sleeved = 'icons/roguetown/clothing/onmob/feet.dmi'
	sleevetype = "leg"
	bloody_icon_state = "shoeblood"
	equip_delay_self = 30
	resistance_flags = FIRE_PROOF
	experimental_inhand = FALSE

/obj/item/clothing/shoes/roguetown/boots
	name = "dark boots"
	//dropshrink = 0.75
	color = "#d5c2aa"
	desc = ""
	gender = PLURAL
	icon_state = "blackboots"
	item_state = "blackboots"
	max_integrity = 80
	sewrepair = TRUE
	var/atom/movable/holdingknife = null
	armor = ARMOR_BOOTS_BAD

/obj/item/clothing/shoes/roguetown/boots/attackby(obj/item/W, mob/living/carbon/user, params)
	if(istype(W, /obj/item/rogueweapon/huntingknife/throwingknife))
		if(holdingknife == null)
			for(var/obj/item/clothing/shoes/roguetown/boots/B in user.get_equipped_items(TRUE))
				to_chat(loc, span_warning("I quickly slot [W] into [B]!"))
				user.transferItemToLoc(W, holdingknife)
				holdingknife = W
				playsound(loc, 'sound/foley/equip/swordsmall1.ogg')
		else
			to_chat(loc, span_warning("My boot already holds a throwing knife."))
		return
	. = ..()

/obj/item/clothing/shoes/roguetown/boots/attack_right(mob/user)
	if(holdingknife != null)
		if(!user.get_active_held_item())
			user.put_in_active_hand(holdingknife, user.active_hand_index)
			holdingknife = null
			playsound(loc, 'sound/foley/equip/swordsmall1.ogg')
			return TRUE

/obj/item/clothing/shoes/roguetown/boots/nobleboot
	name = "noble boots"
	//dropshrink = 0.75
	color = "#d5c2aa"
	desc = "Fine dark leather boots."
	gender = PLURAL
	icon_state = "nobleboots"
	item_state = "nobleboots"
	sewrepair = TRUE
	armor = ARMOR_BOOTS_BAD
	salvage_amount = 2
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/shoes/roguetown/shortboots
	name = "shortboots"
	color = "#d5c2aa"
	desc = ""
	gender = PLURAL
	icon_state = "shortboots"
	item_state = "shortboots"
	sewrepair = TRUE
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/shoes/roguetown/ridingboots
	name = "riding boots"
	color = "#d5c2aa"
	desc = ""
	gender = PLURAL
	icon_state = "ridingboots"
	item_state = "ridingboots"
	sewrepair = TRUE
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

///obj/item/clothing/shoes/roguetown/ridingboots/Initialize()
//	. = ..()
//	AddComponent(/datum/component/squeak, list('sound/foley/spurs (1).ogg'sound/blank.ogg'=1), 50)

/obj/item/clothing/shoes/roguetown/simpleshoes
	name = "shoes"
	desc = ""
	gender = PLURAL
	icon_state = "simpleshoe"
	item_state = "simpleshoe"
	sewrepair = TRUE
	resistance_flags = null
	color = "#473a30"
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/shoes/roguetown/simpleshoes/white
	color = null


/obj/item/clothing/shoes/roguetown/simpleshoes/buckle
	name = "shoes"
	icon_state = "buckleshoes"
	color = null

/obj/item/clothing/shoes/roguetown/simpleshoes/lord
	name = "shoes"
	desc = ""
	gender = PLURAL
	icon_state = "simpleshoe"
	item_state = "simpleshoe"
	resistance_flags = null
	color = "#cbcac9"

/obj/item/clothing/shoes/roguetown/gladiator
	name = "leather sandals"
	desc = ""
	gender = PLURAL
	icon_state = "gladiator"
	item_state = "gladiator"
	sewrepair = TRUE

/obj/item/clothing/shoes/roguetown/sandals
	name = "sandals"
	desc = ""
	gender = PLURAL
	icon_state = "sandals"
	item_state = "sandals"
	sewrepair = TRUE

/obj/item/clothing/shoes/roguetown/shalal
	name = "babouche"
	desc = ""
	gender = PLURAL
	icon_state = "shalal"
	item_state = "shalal"
	sewrepair = TRUE

/obj/item/clothing/shoes/roguetown/boots/leather
	name = "leather boots"
	//dropshrink = 0.75
	desc = ""
	gender = PLURAL
	icon_state = "leatherboots"
	item_state = "leatherboots"
	sewrepair = TRUE
	armor = ARMOR_BOOTS_BAD
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/shoes/roguetown/boots/armor
	name = "plated boots"
	desc = "Boots forged of a set of steel plates to protect your fragile toes."
	body_parts_covered = FEET
	icon_state = "armorboots"
	item_state = "armorboots"
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	color = null
	blocksound = PLATEHIT
	resistance_flags = FIRE_PROOF
	max_integrity = 300
	armor = ARMOR_BOOTS_PLATED
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/shoes/roguetown/boots/armor/iron
	name = "iron plated boots"
	desc = "Boots with iron for added protection."
	body_parts_covered = FEET
	icon_state = "armorironboots"
	item_state = "armorironboots"
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	color = null
	blocksound = PLATEHIT
	max_integrity = 200
	armor = ARMOR_BOOTS_PLATED_IRON
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/shoes/roguetown/jester
	name = "funny shoes"
	icon_state = "jestershoes"
	resistance_flags = null
	sewrepair = TRUE

/obj/item/clothing/shoes/roguetown/jester/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_JINGLE_BELLS)

/obj/item/clothing/shoes/roguetown/boots/furlinedboots
	name = "fur lined boots"
	desc = "Leather boots lined with fur."
	gender = PLURAL
	icon_state = "furlinedboots"
	item_state = "furlinedboots"
	sewrepair = TRUE
	max_integrity = 160
	armor = ARMOR_BOOTS_BAD
	salvage_amount = 1
	salvage_result = /obj/item/natural/fur

/obj/item/clothing/shoes/roguetown/boots/furlinedanklets
	name = "fur lined anklets"
	desc = "Leather anklets lined with fur, foot remains bare."
	gender = PLURAL
	icon_state = "furlinedanklets"
	item_state = "furlinedanklets"
	sewrepair = TRUE
	armor = ARMOR_BOOTS_BAD
	is_barefoot = TRUE
	salvage_amount = 1
	salvage_result = /obj/item/natural/fur

/obj/item/clothing/shoes/roguetown/boots/clothlinedanklets
	name = "cloth lined anklets"
	desc = "Cloth anklets lined with with fibers, foot remains bare."
	gender = PLURAL
	icon_state = "clothlinedanklets"
	item_state = "furlinedanklets"
	is_barefoot = TRUE
	sewrepair = TRUE
	armor = ARMOR_BOOTS_BAD


// ----------------- BLACKSTEEL -----------------------

/obj/item/clothing/shoes/roguetown/boots/blacksteel/plateboots
	name = "blacksteel plate boots"
	desc = "Boots forged of durable blacksteel."
	body_parts_covered = FEET
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bkboots"
	item_state = "bkboots"
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	color = null
	blocksound = PLATEHIT
	max_integrity = 400
	armor = ARMOR_BOOTS_PLATED
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/blacksteel
	resistance_flags = FIRE_PROOF

// ----------------- BLACKSTEEL END -----------------------

/obj/item/clothing/shoes/roguetown/anklets
	name = "golden anklets"
	desc = "Luxurious anklets made of the finest gold. They leave the feet bare while adding an exotic flair."
	gender = PLURAL
	icon_state = "anklets"
	item_state = "anklets"
	is_barefoot = TRUE
	sewrepair = TRUE
	armor = ARMOR_BOOTS_BAD

/obj/item/clothing/shoes/roguetown/boots/leather/elven_boots
	name = "woad elven boots"
	desc = "The living trunks still blossom in the spring. They let water through, but it is never cold."
	armor = list("blunt" = 100, "slash" = 10, "stab" = 100, "piercing" = 20, "fire" = 0, "acid" = 0) //Resistant to blunt and stab, but very weak to slash.
	prevent_crits = list(BCLASS_BLUNT, BCLASS_SMASH, BCLASS_TWIST, BCLASS_PICK)
	icon = 'icons/roguetown/clothing/special/race_armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/race_armor.dmi'
	icon_state = "welfshoes"
	item_state = "welfshoes"

/obj/item/clothing/shoes/roguetown/boots/carapace
	name = "carapace boots"
	desc = "Boots made from carapace for added protection."
	body_parts_covered = FEET
	icon_state = "carapaceboots"
	item_state = "carapaceboots"
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	color = null
	blocksound = PLATEHIT
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	armor = list("blunt" = 60, "slash" = 90, "stab" = 60, "piercing" = 60, "fire" = 30, "acid" = 0) //Sidegrade to plated boots. (Worse for most situation, better against fire or pierce.)
	max_integrity = 225
	anvilrepair = null
	smeltresult = /obj/item/ash
	sewrepair = TRUE
/obj/item/clothing/shoes/roguetown/boots/carapace/dragon
	name = "dragonscale boots"
	desc = "Boots made from dragonscale for added protection."
	color = "#9e5761"
	armor = list("blunt" = 80, "slash" = 100, "stab" = 80, "piercing" = 100, "fire" = 60, "acid" = 0) //Sidegrade to Blacksteel
