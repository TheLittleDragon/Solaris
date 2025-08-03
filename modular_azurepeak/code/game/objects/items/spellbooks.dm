#define ROCK_CHARGE_REDUCTION 0.15
#define GEM_CHARGE_REDUCTION 0.25

/* Spellbook
Intended to be a reward or a goal for pure mage, allowing them to reset and swap out 2 spells per day, and
decreases charge time if held opened in hand, for pure mage build + aesthetics.
*/

/obj/item/book/spellbook
	var/open = FALSE
	icon = 'icons/roguetown/items/books.dmi'
	icon_state = "spellbookbrown_0"
	slot_flags = ITEM_SLOT_HIP
	var/base_icon_state = "spellbookbrown"
	unique = TRUE
	firefuel = 2 MINUTES
	dropshrink = 0.6
	drop_sound = 'sound/foley/dropsound/book_drop.ogg'
	force = 5
	associated_skill = /datum/skill/misc/reading
	name = "\improper tome of the arcane"
	desc = "A crackling, glowing book, filled with runes and symbols that hurt the mind to stare at."
	var/picked // if the book has had it's style picked or not
	var/born_of_rock = FALSE // Was a magical stone used to make it; instead of a gem?

/obj/item/book/spellbook/getonmobprop(tag)
	. = ..()
	if(tag)
		if(open)
			switch(tag)
				if("gen")
					return list("shrink" = 0.4,
	"sx" = -2,
	"sy" = -3,
	"nx" = 10,
	"ny" = -2,
	"wx" = 1,
	"wy" = -3,
	"ex" = 5,
	"ey" = -3,
	"northabove" = 0,
	"southabove" = 1,
	"eastabove" = 1,
	"westabove" = 0,
	"nturn" = 0,
	"sturn" = 0,
	"wturn" = 0,
	"eturn" = 0,
	"nflip" = 0,
	"sflip" = 0,
	"wflip" = 0,
	"eflip" = 0)
				if("onbelt")
					return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
		else
			switch(tag)
				if("gen")
					return list("shrink" = 0.4,
	"sx" = -2,
	"sy" = -3,
	"nx" = 10,
	"ny" = -2,
	"wx" = 1,
	"wy" = -3,
	"ex" = 5,
	"ey" = -3,
	"northabove" = 0,
	"southabove" = 1,
	"eastabove" = 1,
	"westabove" = 0,
	"nturn" = 0,
	"sturn" = 0,
	"wturn" = 0,
	"eturn" = 0,
	"nflip" = 0,
	"sflip" = 0,
	"wflip" = 0,
	"eflip" = 0)
				if("onbelt")
					return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/book/spellbook/examine(mob/user)
	. = ..()
	. += span_notice("Reading it once per day allows you to unbind two spells and refund its spell point.")
	if (istype(src, /obj/item/book/spellbook/warlock))
		. += span_notice("This warlock grimoire hums with eldritch power. Holding it open reduces spell charge time by 30%!")
	else
		if(born_of_rock)
			. += span_notice("This tome was made from a magical stone, instead of a proper gem. Holding it in your hand with it open reduces spell charge time by [ROCK_CHARGE_REDUCTION * 100]%!")
		else
			. += span_notice("This tome was made from a gem. Holding it in your hand with it open reduces spell charge time by [GEM_CHARGE_REDUCTION * 100]%!")


/obj/item/book/spellbook/attack_self(mob/user)
	if(!open)
		attack_right(user)
		return
	..()
	user.update_inv_hands()

/obj/item/book/spellbook/rmb_self(mob/user)
	attack_right(user)
	return

// Override
/obj/item/book/spellbook/read(mob/user)
	change_spells()
	return FALSE

/obj/item/book/spellbook/proc/change_spells(mob/user = usr)
	var/datum/mind/user_mind = user.mind
	if(!user_mind) return // How??
	if(user_mind.has_changed_spell)
		to_chat(user, span_warning("I have already unbinded my spells today!"))
		return
	var/list/resettable_spells = list()
	var/list/spell_list = user_mind.spell_list
	for(var/i = 1, i <= spell_list.len, i++)
		var/obj/effect/proc_holder/spell/spell = spell_list[i]
		if(spell.refundable == TRUE)
			if(spell.cost > 0)
				resettable_spells["[spell.name]: [spell.cost]"] = spell_list[i]
	if(!resettable_spells.len)
		to_chat(user, span_warning("I have no spells to unbind!"))
		return
	for(var/i = 1, i <= 2, i++)
		var/choice = input(user, "Choose up to two spells to unbind. Cancel both to not use up your daily unbinding.") as null|anything in resettable_spells
		var/obj/effect/proc_holder/spell/item = resettable_spells[choice]
		if(!item)
			continue
		if(!resettable_spells.len)
			return
		resettable_spells.Remove(choice)
		user_mind.used_spell_points -= item.cost
		user_mind.RemoveSpell(item)
		user_mind.check_learnspell()
		user_mind.has_changed_spell = TRUE

/obj/item/book/spellbook/proc/get_cdr()
	if(born_of_rock)
		return ROCK_CHARGE_REDUCTION
	else
		return GEM_CHARGE_REDUCTION

/obj/item/book/spellbook/attack_right(mob/user)
	// Ownership check for warlock books
	if(istype(src, /obj/item/book/spellbook/warlock))
		var/obj/item/book/spellbook/warlock/warlock_book = src
		if(user != warlock_book.owner)
			to_chat(user, span_warning("The book squirms in your hand, refusing your touch."))
			return

	if(!picked)
		var/list/designlist = list("green", "yellow", "brown")
		var/mob/living/carbon/human/gamer = user
		if(gamer.job == "Court Magician")
			designlist = list("steel", "gem", "skin", "mimic")
		var/the_time = world.time
		var/design = input(user, "Select a design.","Spellbook Design") as null|anything in designlist
		if(!design)
			return
		if(world.time > (the_time + 30 SECONDS))
			return
		base_icon_state = "spellbook[design]"
		update_icon()
		picked = TRUE
		return

	if(!open)
		slot_flags &= ~ITEM_SLOT_HIP
		open = TRUE
		playsound(loc, 'sound/items/book_open.ogg', 100, FALSE, -1)
	else
		slot_flags |= ITEM_SLOT_HIP
		open = FALSE
		playsound(loc, 'sound/items/book_close.ogg', 100, FALSE, -1)

	curpage = 1
	update_icon()
	user.update_inv_hands()

/obj/item/book/spellbook/update_icon()
	icon_state = "[base_icon_state]_[open]"

/// Book slapcrafting

/obj/item/spellbook_unfinished
	var/pages_left = 4
	name = "bound scrollpaper"
	dropshrink = 0.6
	icon = 'icons/roguetown/items/books.dmi'
	icon_state ="basic_book_0"
	desc = "Thick scroll paper bound at the spine. It lacks pages."
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL		 //upped to three because books are, y'know, pretty big. (and you could hide them inside eachother recursively forever)
	attack_verb = list("bashed", "whacked", "educated")
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/foley/dropsound/book_drop.ogg'
	pickup_sound =  'sound/blank.ogg'

/obj/item/spellbook_unfinished/pre_arcane
	name = "tome in waiting"
	icon_state = "spellbook_unfinished"
	desc = "A fully bound tome of scroll paper. It's lacking a certain arcane energy."
	grid_width = 32
	grid_height = 64

/obj/item/natural/hide/attackby(obj/item/P, mob/living/carbon/human/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/paper/scroll))
		if(isturf(loc)&& (found_table))
			var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				playsound(loc, 'sound/items/book_close.ogg', 100, TRUE)
				to_chat(user, span_notice("I add the first few pages to the leather cover..."))
				new /obj/item/spellbook_unfinished(loc)
				qdel(P)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put the [src] on a table to work on it.</span>")
	else
		return ..()

/obj/item/spellbook_unfinished/attackby(obj/item/P, mob/living/carbon/human/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/paper/scroll))
		if(isturf(loc)&& (found_table))
			var/crafttime = (60 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				if(pages_left > 0)
					playsound(loc, 'sound/items/book_page.ogg', 100, TRUE)
					pages_left -= 1
					to_chat(user, span_notice("[pages_left+1] left..."))
					qdel(P)
				else
					playsound(loc, 'sound/items/book_open.ogg', 100, TRUE)
					if(isarcane(user))
						to_chat(user, span_notice("The book is bound. I must find a catalyst to channel the arcane into it now."))
					else
						to_chat(user, span_notice("I've made an empty book of thick, useless scroll paper. I can't even thumb through it!"))
					new /obj/item/spellbook_unfinished/pre_arcane(loc)
					qdel(P)
					qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put the [src] on a table to work on it.</span>")
	else
		return ..()

/obj/item/spellbook_unfinished/pre_arcane/attackby(obj/item/P, mob/living/carbon/human/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/roguegem))
		if(isturf(loc)&& (found_table))
			var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				if(isarcane(user))
					playsound(loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
					user.visible_message(span_warning("[user] crushes [user.p_their()] [P]! Its powder seeps into the [src]."), \
						span_notice("I run my arcane energy into the crystal. It shatters and seeps into the cover of the tome! Runes and symbols of an unknowable language cover its pages now..."))
					var/obj/item/book/spellbook/newbook = new /obj/item/book/spellbook(loc)
					newbook.desc += " Traces of [P] dust linger in its margins."
					qdel(P)
					qdel(src)
				else
					if(prob(1))
						playsound(loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
						user.visible_message(span_warning("[user] crushes [user.p_their()] [P]! Its powder seeps into the [src]."), \
							span_notice("By the Nine! That gem just exploded -- and my useless tome is filled with gleaming energy and strange letters!"))
						var/obj/item/book/spellbook/newbook = new /obj/item/book/spellbook(loc)
						newbook.desc += " Traces of [P] dust linger in its margins."
						qdel(P)
						qdel(src)
					else
						playsound(loc, 'modular_azurepeak/sound/spellbooks/icicle.ogg', 100, TRUE)
						user.visible_message(span_warning("[user] crushes [user.p_their()] [P]! Its powder just kind of sits on top of the [src]. Awkward."), \
							span_notice("... why and how did I just crush this gem into a worthless scroll-book? What a WASTE of sunmarks!"))
						qdel(P)
					return ..()
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a table to work on it.</span>")
	else if (istype(P, /obj/item/natural/stone))
		var/obj/item/natural/stone/the_rock = P
		if (the_rock.magic_power)
			if(isturf(loc) && (found_table))
				var/crafttime = ((130 - the_rock.magic_power) - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
				if(do_after(user, crafttime, target = src))
					if (isarcane(user))
						playsound(loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
						user.visible_message(span_warning("[user] crushes [user.p_their()] [P]! Its powder seeps into the [src]."), \
							span_notice("I join my arcane energy with that of the magical stone in my hands, which shudders briefly before dissolving into motes of ash. Runes and symbols of an unknowable language cover its pages now..."))
						to_chat(user, span_notice("...yet even for an enigma of the arcane, these characters are unlike anything I've seen before. They're going to be -much- harder to understand..."))
						var/obj/item/book/spellbook/newbook = new /obj/item/book/spellbook(loc)
						newbook.born_of_rock = TRUE
						newbook.desc += " Traces of multicolored stone limn its margins."
						qdel(P)
						qdel(src)
					else
						if (prob(the_rock.magic_power)) // for reference, this is never higher than 15 and usually significantly lower
							playsound(loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
							user.visible_message(span_warning("[user] carefully sets down [the_rock] upon [src]. Nothing happens for a moment or three, then suddenly, the glow surrounding the stone becomes as liquid, seeps down and soaks into the tome!"), \
							span_notice("I knew this stone was special! Its colourful magick has soaked into my tome and given me gift of mystery!"))
							to_chat(user, span_notice("...what in the world does any of this scribbling possibly mean?"))
							var/obj/item/book/spellbook/newbook = new /obj/item/book/spellbook(loc)
							newbook.born_of_rock = TRUE
							newbook.desc += " Traces of multicolored stone limn its margins."
							qdel(P)
							qdel(src)
						else
							user.visible_message(span_warning("[user] sets down [the_rock] upon the surface of [src] and watches expectantly. Without warning, the rock violently pops like a squashed gourd!"), \
							span_notice("No! My precious stone! It musn't have wanted to share its mysteries with me..."))
							user.electrocute_act(5, src)
							qdel(P)
		else
			to_chat(user, span_notice("This is a mere rock - it has no arcane potential. Bah!"))
			return ..()
	else
		return ..()

// Leaving this in for now for aesthetics, but they're now useless
/obj/effect/roguerune
	name = "arcane rune"
	desc = "Strange symbols pulse upon the ground..."
	anchored = TRUE
	icon = 'icons/obj/rune.dmi'
	icon_state = "6"
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	layer = SIGIL_LAYER
	color = "#3A0B61"
	
// helper proc
/proc/isarcane(mob/living/carbon/human/A)
	return istype(A) && A.mind && (A.mind?.get_skill_level(/datum/skill/magic/arcane) > SKILL_LEVEL_NONE)

//Warlock's

/obj/item/book/spellbook/warlock
	icon = 'icons/roguetown/items/books.dmi'
	force = 20
	throwforce = 10
	associated_skill = /datum/skill/misc/reading
	name = "whispering tome"
	desc = "A dark tome bound in some unknown hide. Its pages whisper softly when opened."
	breakouttime = 2 MINUTES
	picked = 1
	var/active_item
	var/spell1
	var/spell2
	var/spell3
	var/corresponding_patron
	var/mob/living/carbon/owner

/obj/item/book/spellbook/warlock/attack_right(mob/user)
	if(owner && user != owner)
		to_chat(user, span_warning("The tome shudders in your hand. It refuses to obey you."))
		return FALSE
	. = ..()

/obj/item/book/spellbook/warlock/get_cdr()
	return 0.3 //The old forgotten tome you got as your side of the contract is slightly better than a gem book.

/obj/item/book/spellbook/warlock/Initialize()
	. = ..()

	var/list/tier_1_spells = list()
	var/list/tier_2_spells = list()
	var/list/tier_3_spells = list()

	for (var/spell_path in GLOB.learnable_spells)
		if (!ispath(spell_path, /obj/effect/proc_holder/spell)) continue
		var/obj/effect/proc_holder/spell/S = spell_path
		var/tier = initial(S.spell_tier)
		switch (tier)
			if (1)
				tier_1_spells += spell_path
			if (2)
				tier_2_spells += spell_path
			if (3)
				tier_3_spells += spell_path

	if (length(tier_1_spells))
		spell1 = pick(tier_1_spells)
	if (length(tier_2_spells))
		spell2 = pick(tier_2_spells)
	if (length(tier_3_spells))
		spell3 = pick(tier_3_spells)

/obj/item/book/spellbook/warlock/equipped(mob/living/user)
	. = ..()
	if(owner != user)
		to_chat(user, span_warning("The tome stays inert in your hands. Its secrets are not meant for you."))
		return
	if(active_item)
		return
	active_item = TRUE
	to_chat(user, span_notice("Your mind swells with knowledge"))
	user.change_stat("intelligence", 1)
	user.mind.AddSpell(new spell1)
	user.mind.AddSpell(new spell2)
	user.mind.AddSpell(new spell3)

/obj/item/book/spellbook/warlock/dropped(mob/living/user)
	. = ..()
	if(owner != user)
		return
	if(active_item)
		to_chat(user, span_notice("Your intellect shrinks away"))
		user.change_stat("intelligence", -1)
		user.mind.RemoveSpell(spell1)
		user.mind.RemoveSpell(spell2)
		user.mind.RemoveSpell(spell3)
		active_item = FALSE

/obj/item/book/spellbook/warlock/verdant_court
	icon_state = "wyrdbark_0"
	base_icon_state = "wyrdbark"
	name = "wyrdbark codex"
	desc = "Bound in living wood and leaf-vein vellum, this tome hums softly. Its ink smells faintly of moss, and the runes twist like vines when read aloud."
	corresponding_patron = "The Verdant Court"

/obj/item/book/spellbook/warlock/radiant_ember
	icon_state = "sunfire_0"
	base_icon_state = "sunfire"
	name = "sunfire lexicon"
	desc = "A tome gilded with divine warmth, its pages almost too bright to read. Words blaze with radiant clarity, offering guidance and judgment in equal measure."

/obj/item/book/spellbook/warlock/drowned_choir
	icon_state = "abyssal_psalter_0"
	base_icon_state = "abyssal_psalter"
	name = "abyssal psalter"
	desc = "Waterlogged and salt-stained, this book sings in whispers only its bearer can truly understand. Each page feels wet to the touch, yet never smears."

/obj/item/book/spellbook/warlock/ashen_pact
	icon_state = "cindergrasp_0"
	base_icon_state = "cindergrasp"
	name = "cindergrasp testament"
	desc = "This scorched tome crackles with heatless flame. The margins are seared with forgotten contracts, and the ink burns red when read."

/obj/item/book/spellbook/warlock/bound_whisper
	icon_state = "vessel_concord_0"
	base_icon_state = "vessel_concord"
	name = "vessel's concord"
	desc = "Cork-sealed and whisper-bound, this book flickers with promises. Pages turn themselves, eager to bargain, to bargain, to bargain..."
	pickup_sound = 'sound/items/glass_pick_up.ogg'
	drop_sound = 'sound/items/glass_drop.ogg'

/obj/item/book/spellbook/warlock/hollow_voice
	icon_state = "silence_that_0"
	base_icon_state = "silence_that"
	name = "silence that listens"
	desc = "A hollow book that never fully opens, filled with inkless script that imprints directly onto the mind. Reading it always leaves you with the sensation of being watched."

/obj/item/book/spellbook/warlock/wakened_blade
	icon_state = "edgebound_0"
	base_icon_state = "edgebound"
	name = "edgebound chronicle"
	desc =  "Bound in leather stretched over a blade's tang, this tome shimmers faintly. Diagrams shift between warforms and invocations depending on who reads it"

/obj/item/book/spellbook/warlock/pale_crown
	icon_state = "sovereign_remnant_0"
	base_icon_state = "sovereign_remnant"
	name = "sovreign's remnant"
	desc =  "This regal tome's pages are made of ancient looking vellum, adorned with silver thread binding and glyphs. Its pages whisper of ancient thrones and the price of eternity."
