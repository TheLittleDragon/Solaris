/datum/advclass/warlock
	name = "Warlock"
	tutorial = "Warlocks are wielders of arcane power drawn from obscure and often inexplicable sources.\
		Some claim to have heard whispers in dreams, others channel ancient rites passed through shadowed traditions.\
		Whether their strength stems from long-forgotten pacts, deep instinct, or something stranger still, \
		warlocks tap into forces that lie beyond conventional spellcraft, unpredictable, potent, and rarely understood."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/warlock
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	cmode_music = 'sound/music/combat_bandit_mage.ogg'

/datum/outfit/job/roguetown/adventurer/warlock


/datum/outfit/job/roguetown/adventurer/warlock/pre_equip(mob/living/carbon/human/human)
	..()

	human.adjust_blindness(-3)
	if(human.mind)
		human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/eldritchblast)
		ADD_TRAIT(human, TRAIT_MAGEARMOR, TRAIT_GENERIC)
	backr = /obj/item/storage/backpack/rogue/satchel
	neck = null
	human.mind.adjust_spellpoints(6)
	human.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 1, TRUE)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 1, TRUE)
	backpack_contents += list(
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/roguekey/adventurers_guild = 1,
		/obj/item/rogueweapon/huntingknife = 1
	)
	var/patrons = list(
		"The Verdant Court",        // Formerly "archfey"
		"The Radiant Ember",        // Formerly "celestial"
		"The Drowned Choir",        // Formerly "fathomless"
		"The Ashen Pact",           // Formerly "fiend" 
		"The Bound Whisper",        // Formerly "genie"
		"The Hollow Voice",         // Formerly "great old one"
		"The Wakened Blade",        // Formerly "hexblade"
		"The Pale Crown",           // Formerly "undead"
	)

	var/patronchoice = input("Choose your otherworldly patron", "Available patrons") as anything in patrons
	human.patronchoice = patronchoice

	switch(patronchoice)
		if("The Verdant Court")
			archfeypatron(human, patronchoice)
		if("The Radiant Ember")
			celestialpatron(human, patronchoice)
		if("The Drowned Choir")
			fathomlesspatron(human, patronchoice)
		if("The Ashen Pact")
			fiendpatron(human, patronchoice)
		if("The Bound Whisper")
			geniepatron(human, patronchoice)
		if("The Hollow Voice")
			goopatron(human, patronchoice)
		if("The Wakened Blade")
			hexbladepatron(human, patronchoice)
		if("The Pale Crown")
			undeadpatron(human, patronchoice)

	switch(patronchoice)
		if("The Verdant Court", "The Radiant Ember", "The Drowned Choir", "The Ashen Pact", "The Hollow Voice", "The Wakened Blade", "The Pale Crown")
			backpack_contents += list(/obj/item/storage/belt/rogue/pouch/coins/poor = 1)
		if("The Bound Whisper")
			backpack_contents += list(/obj/item/storage/belt/rogue/pouch/coins/rich = 1)

	var/boons = list( //what did you trade away a piece of yourself for?
		"A sharper edge",        // strength / blade pact
		"Secrets best left buried", // knowledge / tome pact
		"A body that won't break",  // health
		"Gold that never feels warm", // wealth / talisman
		"A voice that answers",      // friendship / chain pact
		"A name the world must fear",// power
		"A reason to keep breathing",// purpose / star chain
		"A wound that must be answered", // revenge / curse
	)

	var/boonchoice = input("What did you trade away a piece of yourself for?", "The Boon") as anything in boons

	switch(boonchoice)
		if("A sharper edge") //Pact of the Blade
			human.put_in_hands(giveweapon(human,patronchoice), FALSE)
			human.set_blindness(0)
		if("A voice that answers") //Pact of the Chain
			human.mind.AddSpell(new /obj/effect/proc_holder/spell/self/findfamiliar/empowered)
			human.change_stat("perception", 1)
			human.set_blindness(0)
		if("Secrets best left buried") //Pact of the Tome
			human.put_in_hands(givebook(patronchoice, human), FALSE)
			human.mind.adjust_spellpoints(3)
			human.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		if("A name the world must fear") //empowered eldritch blast
			human.mind.RemoveSpell(/obj/effect/proc_holder/spell/invoked/projectile/eldritchblast)
			human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/eldritchblast/empowered)
			human.mind.adjust_spellpoints(3)
		if("A body that won't break") //make healthier
			givehealing(human, patronchoice)
			human.change_stat("constitution", 1)
			human.set_blindness(0)
			human.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			human.mind.adjust_skillrank_by_up_to(/datum/skill/combat/swords, 3, SKILL_LEVEL_EXPERT)
		if("Gold that never feels warm") //Pact of the Talisman
			human.put_in_hands(giveamulet(patronchoice), FALSE)
			backpack_contents += list(/obj/item/storage/belt/rogue/pouch/coins/rich = 1)
			ADD_TRAIT(human,TRAIT_SEEPRICES, TRAIT_GENERIC)
			human.set_blindness(0)
		if("A reason to keep breathing") //Pact of the Star Chain
			wrists = /obj/item/rope/chain/constellation
			human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/guidance)
			human.set_blindness(0)
		if("A wound that must be answered") //give curse
			givecurse(human, patronchoice)
			human.change_stat("speed", 1)
			human.set_blindness(0)
		

/datum/outfit/job/roguetown/adventurer/warlock/proc/archfeypatron(mob/living/carbon/human/human, patronchoice)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 2, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	human.mind.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
	human.mind.adjust_skillrank_by_up_to(/datum/skill/magic/arcane, 3, SKILL_LEVEL_EXPERT)

	head = /obj/item/clothing/head/roguetown/helmet/heavy/elven_helm
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
	shoes = /obj/item/clothing/shoes/roguetown/sandals
	r_hand = /obj/item/rogueweapon/woodstaff
	belt = /obj/item/storage/belt/rogue/leather/rope

	//caster stats (must be 5 stat point total)
	human.change_stat("intelligence", 2)
	human.change_stat("perception", 2)
	human.change_stat("constitution", 1)

	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/entangling_vines)
	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/blink)
	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/verdant_blessing)
	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mischievous_whispers)
	
	ADD_TRAIT(human, TRAIT_WILDMAGIC, TRAIT_GENERIC)
	ADD_TRAIT(human, TRAIT_WILDMAGIC_BENEFIC, TRAIT_GENERIC)
	ADD_TRAIT(human, TRAIT_ARCANE_T3, TRAIT_GENERIC) //Caster Subclass
	human.mind.adjust_spellpoints(6) //Caster subclass

	human.visible_message(span_info("I brushed against the glimmering court beneath leaf and moon, and it whispered secrets into my soul."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/celestialpatron(mob/living/carbon/human/human, patronchoice)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 1, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/medicine, 2,   TRUE)
	human.mind.adjust_skillrank_by_up_to(/datum/skill/magic/arcane, 3, SKILL_LEVEL_EXPERT)

	// armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	belt = /obj/item/storage/belt/rogue/leather
	r_hand = /obj/item/rogueweapon/spear

	//caster stats (must be 5 stat point total)
	human.change_stat("intelligence", 2)
	human.change_stat("perception", 2)
	human.change_stat("constitution", 1)

	givehealing(human, patronchoice, TRUE)
	ADD_TRAIT(human, TRAIT_ARCANE_T3, TRAIT_GENERIC) //Caster subclass
	human.mind.adjust_spellpoints(6) //Caster subclass

	human.visible_message(span_info("Something bright found me in the dark. It left a spark that hasn't gone out."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/fathomlesspatron(mob/living/carbon/human/human, patronchoice) // a watery creature
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 3, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	human.mind.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
	human.mind.adjust_skillrank(/datum/skill/labor/fishing, 3, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	backl = /obj/item/fishingrod
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/carapacecap
	else
		head = /obj/item/clothing/head/roguetown/fisherhat
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
	cloak = /obj/item/clothing/cloak/raincloak/yellow
	wrists = /obj/item/rope
	r_hand = /obj/item/rogueweapon/pitchfork
	belt =/obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes

	backpack_contents += list(/obj/item/rope)

	//melee stats (must be 5 stat point total)
	human.change_stat("perception", 1)
	human.change_stat("strength", 1)
	human.change_stat("constitution", 2)
	human.change_stat("endurance", 2)
	human.change_stat("speed", -1)

	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/acidsplash)
	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/frostbite) // "water" and ice magic, less arcane power because armor and dodge training

	ADD_TRAIT(human, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(human, TRAIT_WATERBREATHING, TRAIT_GENERIC)
	ADD_TRAIT(human, TRAIT_ARCANE_T2, TRAIT_GENERIC) //Melee subclass
	human.mind.capped_arcane_melee = SKILL_LEVEL_CAPPED_ARCANE_MELEE

	human.visible_message(span_info("The sea sang to me once. I haven't been able to stop hearing it since."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/fiendpatron(mob/living/carbon/human/human, patronchoice) //hellish fiend
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 1, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	human.mind.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
	human.mind.adjust_skillrank_by_up_to(/datum/skill/magic/arcane, 3, SKILL_LEVEL_EXPERT)
	human.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)

	head = /obj/item/clothing/head/roguetown/roguehood/red
	mask = /obj/item/clothing/mask/rogue/facemask/goldmask
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/magered
	cloak = /obj/item/clothing/cloak/raincloak/red
	r_hand = /obj/item/rogueweapon/woodstaff
	belt = /obj/item/storage/belt/rogue/leather/rope
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes

	//caster stats (must be 5 stat point total)
	human.change_stat("intelligence", 2)
	human.change_stat("perception", 2)
	human.change_stat("constitution", 1)

	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball) // fireball is a very strong spell, fiendkiss makes it even stronger
	ADD_TRAIT(human, TRAIT_NOFIRE, TRAIT_GENERIC)
	ADD_TRAIT(human, TRAIT_FIENDKISS, TRAIT_GENERIC)
	ADD_TRAIT(human, TRAIT_ARCANE_T3, TRAIT_GENERIC) //Caster subclass
	human.mind.adjust_spellpoints(6) //Caster subclass

	human.visible_message(span_info("I reached into a cold fire that never dies. It remembers me now."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/geniepatron(mob/living/carbon/human/human, patronchoice) //a desert entity
	human.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 2, TRUE)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 2, TRUE)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 2, TRUE)

	head = /obj/item/clothing/head/roguetown/roguehood/shalal
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	gloves = /obj/item/clothing/gloves/roguetown/angle
	beltr = /obj/item/wisp_lantern
	beltl = /obj/item/rogueweapon/sword/sabre
	belt = /obj/item/storage/belt/rogue/leather/shalal
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	id = /obj/item/clothing/ring/gold/signet

	//lucky stats (must be 5 stat point total)
	human.change_stat("endurance", 1) //
	human.change_stat("speed", 1)
	human.change_stat("fortune", 2)

	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/haste)
	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/repulse) // going with wind theme, speed and airblast, possibly eventual picker for "which type of genie did you make a deal with"

	ADD_TRAIT(human, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(human, TRAIT_ARCANE_T2, TRAIT_GENERIC) //Melee Subclass
	human.mind.capped_arcane_melee = SKILL_LEVEL_CAPPED_ARCANE_MELEE


	human.visible_message(span_info("There was a voice in a jar, a bottle, a name. I let it out. Or it let me in."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/goopatron(mob/living/carbon/human/human, patronchoice)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 1, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	human.mind.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
	human.mind.adjust_skillrank_by_up_to(/datum/skill/magic/arcane, 3, SKILL_LEVEL_EXPERT)
	human.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)

	head = /obj/item/clothing/head/roguetown/roguehood/mage
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/tsoridys
	beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
	belt = /obj/item/storage/belt/rogue/leather/rope
	r_hand = /obj/item/rogueweapon/woodstaff

	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/gravity)
	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/ensnare)
	human.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/encodethoughts)
	human.mind.AddSpell(new /obj/effect/proc_holder/spell/self/unquiet_mind)

	//caster stats (must be 5 stat point total)
	human.change_stat("intelligence", 2)
	human.change_stat("perception", 2)
	human.change_stat("constitution", 1)

	ADD_TRAIT(human, TRAIT_ARCANE_T3, TRAIT_GENERIC) //Caster subclass
	human.mind.adjust_spellpoints(6) //Caster subclass

	human.visible_message(span_info("I heard a silence too loud to bear. Now it's inside me, humming."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/hexbladepatron(mob/living/carbon/human/human, patronchoice)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 1, TRUE)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 1, TRUE)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/axes, 1, TRUE)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 1, TRUE)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 1, TRUE)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 1, TRUE)
	// human.mind.adjust_skillrank_up_to(/datum/skill/magic/arcane, 1, TRUE) // This gets overwritten by the 3 arcane given by the giveweapon proc
	human.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	shoes = /obj/item/clothing/shoes/roguetown/boots
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson

	human.put_in_hands(giveweapon(human,patronchoice), FALSE)

	//melee stats (must be 5 stat point total)
	human.change_stat("perception", 1)
	human.change_stat("constitution", 1)
	human.change_stat("endurance", 1)
	human.change_stat("speed", 1)

	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/greenflameblade) // put that new weapon to work! martial focus means less magic
	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mending)
	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/warlock/summon_weapon)

	ADD_TRAIT(human, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(human, TRAIT_ARCANE_T2, TRAIT_GENERIC) //Melee Subclass
	human.mind.capped_arcane_melee = SKILL_LEVEL_CAPPED_ARCANE_MELEE

	human.visible_message(span_info("The weapon spoke first. I only answered. Now it never leaves."))

/datum/outfit/job/roguetown/adventurer/warlock/proc/undeadpatron(mob/living/carbon/human/human, patronchoice)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/shields, 2, TRUE)
	human.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 2, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	human.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	cloak = /obj/item/clothing/cloak/raincloak/brown
	gloves = /obj/item/clothing/gloves/roguetown/angle
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	wrists = /obj/item/clothing/wrists/roguetown/vambraces
	neck = /obj/item/clothing/neck/roguetown/gorget
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/iron
	head = /obj/item/clothing/head/roguetown/helmet/skullcap
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/sword/iron/short
	backl = /obj/item/rogueweapon/shield/tower

	human.change_stat("strength", 1)
	human.change_stat("endurance", 2)
	human.change_stat("constitution", 1)

	human.mind.AddSpell(new /obj/effect/proc_holder/spell/self/cloakofflies)
	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/infestation)
	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/chilltouch)

	ADD_TRAIT(human, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(human, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(human, TRAIT_ARCANE_T2, TRAIT_GENERIC) //Melee subclass
	human.mind.capped_arcane_melee = SKILL_LEVEL_CAPPED_ARCANE_MELEE

	human.visible_message(span_info("I stepped into a place no longer remembered, and something followed me out."))

///////////////////////////////
//	Faithless Healing
///////////////////////////////

/datum/outfit/job/roguetown/adventurer/warlock/proc/givehealing(mob/living/carbon/human/human, patronname = "", ignore_faithless = FALSE)
	var/obj/effect/proc_holder/spell/invoked/eldritchhealing/eldritchhealing = new /obj/effect/proc_holder/spell/invoked/eldritchhealing
	if(ignore_faithless)
		eldritchhealing.ignore_faithless = TRUE
	eldritchhealing.patronname = patronname
	switch(patronname) //god damn put this in a datum or something....
		if("The Verdant Court")
			eldritchhealing.targetnotification = "I am surrounded in a puff of glittery dust."
			eldritchhealing.othernotification = "is surrounded in a puff of glittery dust."
		if("The Radiant Ember")
			eldritchhealing.targetnotification = "I am encircled in a tapestry of glittering starlight."
			eldritchhealing.othernotification = "is encircled in a tapestry of glittering starlight."
		if("The Drowned Choir")
			eldritchhealing.targetnotification = "My pain is siphoned away by an inky tendril!"
			eldritchhealing.othernotification = "'s injuries are siphoned away by an inky tendril!"
		if("The Bound Whisper")
			eldritchhealing.targetnotification = "I just feel better all of a sudden."
			eldritchhealing.othernotification = "looks better."
		if("The Hollow Voice")
			eldritchhealing.targetnotification = "My wounds distort and fade away."
			eldritchhealing.othernotification = "'s injuries distort and fade away."
		if("The Wakened Blade")
			eldritchhealing.targetnotification = "My wounds close leaving scars."
			eldritchhealing.othernotification = "'s wounds close leaving scars."
		if("The Pale Crown")
			eldritchhealing.targetnotification = "Maggots eat away my dead flesh!"
			eldritchhealing.othernotification = "'s wounds are healed by... Maggots?"
	human.mind.AddSpell(eldritchhealing)
	human.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular) // If you get healing, you get diagnose

///////////////////////////////
//	Curse
///////////////////////////////

/datum/outfit/job/roguetown/adventurer/warlock/proc/givecurse(mob/living/carbon/human/human, patronname = "")
	var/obj/effect/proc_holder/spell/invoked/eldritchcurse/curse = new /obj/effect/proc_holder/spell/invoked/eldritchcurse

	switch(patronname) //god damn put this in a datum or something....
		if("The Verdant Court")
			curse.curse = /datum/status_effect/buff/eldritchcurse/archfey
		if("The Radiant Ember")
			curse.curse = /datum/status_effect/buff/eldritchcurse/celestial
		if("The Drowned Choir")
			curse.curse = /datum/status_effect/buff/eldritchcurse/fathomless
		if("The Bound Whisper")
			curse.curse = /datum/status_effect/buff/eldritchcurse/genie
		if("The Hollow Voice")
			curse.curse = /datum/status_effect/buff/eldritchcurse/goo
		if("The Wakened Blade")
			curse.curse = /datum/status_effect/buff/eldritchcurse/hexblade
		if("The Pale Crown")
			curse.curse = /datum/status_effect/buff/eldritchcurse/undead
		if("The Ashen Pact")
			curse.curse = /datum/status_effect/buff/eldritchcurse/fiend
	curse.name += patronname
	curse.patronname = patronname
	human.mind.AddSpell(curse)

///////////////////////////////
//	Pact Book
///////////////////////////////

/datum/outfit/job/roguetown/adventurer/warlock/proc/givebook(patronchoice, mob/living/carbon/user)
	var/type_map = list(
		"The Verdant Court" = /obj/item/book/spellbook/warlock/verdant_court,
		"The Radiant Ember" = /obj/item/book/spellbook/warlock/radiant_ember,
		"The Drowned Choir" = /obj/item/book/spellbook/warlock/drowned_choir,
		"The Ashen Pact" = /obj/item/book/spellbook/warlock/ashen_pact,
		"The Bound Whisper" = /obj/item/book/spellbook/warlock/bound_whisper,
		"The Hollow Voice" = /obj/item/book/spellbook/warlock/hollow_voice,
		"The Wakened Blade" = /obj/item/book/spellbook/warlock/wakened_blade,
		"The Pale Crown" = /obj/item/book/spellbook/warlock/pale_crown
	)

	var/type = type_map[patronchoice]
	if (!type)
		return null // Fallback in case something's wrong

	var/obj/item/book/spellbook/warlock/book = new type
	book.owner = user
	return book

///////////////////////////////
//	Weapon of X
///////////////////////////////

/datum/outfit/job/roguetown/adventurer/warlock/proc/giveweapon(mob/living/carbon/human/human, patronchoice)
	human.mind.adjust_skillrank_up_to(/datum/skill/magic/arcane, 3, TRUE)

	var/weapons_choice = list(
		"Axe", "Battleaxe", "Cleaver", "Dagger", "Flail", "Goden",
		"Greatsword", "Halberd", "Longsword", "Mace", "Peasant war flail",
		"Rapier", "Scythe", "Spear", "Whip"
	)

	var/weapon_chosen = input("Choose your sentient weapon", "Available weapons") as anything in weapons_choice
	var/item_type

	switch(weapon_chosen)
		if("Axe") item_type = /obj/item/rogueweapon/stoneaxe/woodcut/steel
		if("Battleaxe") item_type = /obj/item/rogueweapon/stoneaxe/battle
		if("Cleaver") item_type = /obj/item/rogueweapon/huntingknife/cleaver
		if("Dagger") item_type = /obj/item/rogueweapon/huntingknife/idagger/steel
		if("Flail") item_type = /obj/item/rogueweapon/flail/sflail
		if("Goden") item_type = /obj/item/rogueweapon/mace/goden/steel
		if("Greatsword") item_type = /obj/item/rogueweapon/greatsword
		if("Halberd") item_type = /obj/item/rogueweapon/halberd
		if("Longsword") item_type = /obj/item/rogueweapon/sword/long
		if("Mace") item_type = /obj/item/rogueweapon/mace/steel
		if("Peasant war flail") item_type = /obj/item/rogueweapon/flail/peasantwarflail
		if("Rapier") item_type = /obj/item/rogueweapon/sword/rapier
		if("Scythe") item_type = /obj/item/rogueweapon/sickle/scythe
		if("Spear") item_type = /obj/item/rogueweapon/spear
		if("Whip") item_type = /obj/item/rogueweapon/whip

	var/obj/item/item = new item_type
	item.AddComponent(/datum/component/pact_weapon, human, patronchoice)
	item.AddComponent(/datum/component/singing_item, human, patronchoice, item)

	// Make sure the lists exist
	if(!islist(human.mind.warlock_weapons))
		human.mind.warlock_weapons = list()
	if(!islist(human.mind.warlock_weapon_types))
		human.mind.warlock_weapon_types = list()

	human.mind.warlock_weapons += item
	human.mind.warlock_weapon_types += item_type

	return item

///////////////////////////////
//	Signet Ring
///////////////////////////////

/obj/item/clothing/ring/gold/signet
	name = "signet ring"
	desc = "A ring that denotes nobility."
	var/active_item

/obj/item/clothing/ring/gold/signet/equipped(mob/living/user)
	. = ..()
	if(active_item)
		return
	else
		active_item = TRUE
		to_chat(user, span_notice("You feel noble."))
		ADD_TRAIT(user, TRAIT_NOBLE, TRAIT_GENERIC)
		return

/obj/item/clothing/ring/gold/signet/dropped(mob/living/user)
	. = ..()
	if(active_item)
		to_chat(user, span_notice("You feel like a peasant."))
		REMOVE_TRAIT(user, TRAIT_NOBLE, TRAIT_GENERIC)
		active_item = FALSE
		return

///////////////////////////////
//	TALISMAN OF X
///////////////////////////////

/datum/outfit/job/roguetown/adventurer/warlock/proc/giveamulet(patronchoice)
	var/obj/item/item
	var/item_type = /obj/item/clothing/neck/roguetown/psicross/eldritch
	item = new item_type
	item.name += patronchoice
	return item

/obj/item/clothing/neck/roguetown/psicross/eldritch
	name = "talisman of the "
	desc = "An earie glowing talisman."
	icon_state = "eldritch"
	var/active_item

/obj/item/clothing/neck/roguetown/psicross/eldritch/equipped(mob/living/user)
	. = ..()
	if(active_item)
		return
	else
		active_item = TRUE
		to_chat(user, span_notice("You feel lucky."))
		user.change_stat("fortune", 3)
		return

/obj/item/clothing/neck/roguetown/psicross/eldritch/dropped(mob/living/user)
	. = ..()
	if(active_item)
		to_chat(user, span_notice("Your stroke of luck has ended."))
		user.change_stat("fortune", -3)
		active_item = FALSE
		return

///////////////////////////////
//	CONSTELLATION CHAIN
///////////////////////////////

/obj/item/rope/chain/constellation
	desc = "A strange chain resembling a constellation."
	icon_state = "starchain"
	force = 20
	throwforce = 10
	breakouttime = 2 MINUTES
	var/active_item

/obj/item/rope/chain/constellation/equipped(mob/living/user)
	. = ..()
	if(active_item)
		return
	else
		active_item = TRUE

		var/obj/item/organ/eyes/eyes = user.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.see_in_dark = 8
			eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
			eyes.sight_flags = initial(eyes.sight_flags)
			eyes.sight_flags &= ~SEE_BLACKNESS
			eyes.owner.update_sight()

		to_chat(user, span_notice("Your purpose seems clearer now"))
		user.change_stat("intelligence", 1)
		user.change_stat("fortune", 1)
		return

/obj/item/rope/chain/constellation/dropped(mob/living/user)
	. = ..()
	if(active_item)
		to_chat(user, span_notice("Your purpose is scattered to the wind"))

		var/obj/item/organ/eyes/eyes = user.getorganslot(ORGAN_SLOT_EYES)
		eyes.see_in_dark = 2
		eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_VISIBLE
		eyes.sight_flags = 0
		eyes.owner.update_sight()

		user.change_stat("intelligence", -1)
		user.change_stat("fortune", -1)
		active_item = FALSE
		return
