#define TOPAZ_CAST_TIME_REDUCTION 0.1
#define EMERALD_CAST_TIME_REDUCTION 0.15
#define SAPPHIRE_CAST_TIME_REDUCTION 0.2
#define QUARTZ_CAST_TIME_REDUCTION 0.25
#define RUBY_CAST_TIME_REDUCTION 0.3
#define DIAMOND_CAST_TIME_REDUCTION 0.35
#define RIDDLE_OF_STEEL_CAST_TIME_REDUCTION 0.4

//we use discrete staff objs so that they can be easily thrown into loot tables and maps without complex varediting

/obj/item/rogueweapon/woodstaff
	force = 10
	force_wielded = 15
	possible_item_intents = list(SPEAR_BASH)
	gripped_intents = list(SPEAR_BASH,/datum/intent/mace/smash/wood)
	name = "wooden staff"
	desc = "Not so heavy, perfect for beggars, pilgrims and mages."
	icon_state = "woodstaff"
	icon = 'icons/obj/staffs.dmi'
	wlength = WLENGTH_LONG
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	blade_dulling = DULLING_SHAFT_WOOD
	sharpness = IS_BLUNT
	walking_stick = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	wdefense = 10
	bigboy = TRUE
	gripsprite = TRUE
	associated_skill = /datum/skill/combat/polearms
	resistance_flags = FLAMMABLE
	var/cast_time_reduction = null

/obj/item/rogueweapon/woodstaff/Initialize()
	. = ..()
	var/static/list/slapcraft_recipe_list = list(
		/datum/crafting_recipe/toper_staff,
		/datum/crafting_recipe/amethyst_staff,
		/datum/crafting_recipe/emerald_staff,
		/datum/crafting_recipe/sapphire_staff,
		/datum/crafting_recipe/quartz_staff,
		/datum/crafting_recipe/ruby_staff,
		/datum/crafting_recipe/diamond_staff,
		/datum/crafting_recipe/riddle_of_steel_staff,
		)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/rogueweapon/woodstaff/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = -1,"nx" = 8,"ny" = 0,"wx" = -4,"wy" = 0,"ex" = 2,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 4,"sy" = -2,"nx" = -3,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/woodstaff/wise
	name = "wise staff"
	desc = "A staff for keeping the wolfs at bay..."

/obj/item/rogueweapon/woodstaff/aries
	name = "staff of the shepherd"
	desc = "This staff makes you look important to any peasante."
	force = 25
	force_wielded = 28
	icon_state = "aries"
	icon = 'icons/roguetown/weapons/32.dmi'
	pixel_y = 0
	pixel_x = 0
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = FALSE
	gripsprite = FALSE
	gripped_intents = null

/obj/item/rogueweapon/woodstaff/aries/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 2,"nx" = 8,"ny" = 2,"wx" = -4,"wy" = 2,"ex" = 1,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 300,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 100,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 4,"sy" = -2,"nx" = -3,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/rogueweapon/woodstaff/topaz
	name = "topaz-focused staff"
	desc = "An amber focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "topazstaff"
	cast_time_reduction = TOPAZ_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF //imagine the salt
	static_debris = list(/obj/item/roguegem/yellow = 1)

/obj/item/rogueweapon/woodstaff/amethyst
	name = "amethyst-focused staff"
	desc = "A purple focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "amethyststaff"
	cast_time_reduction = TOPAZ_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF
	static_debris = list(/obj/item/roguegem/amethyst = 1)

/obj/item/rogueweapon/woodstaff/emerald
	name = "emerald-focused staff"
	desc = "A glistening green focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "emeraldstaff"
	cast_time_reduction = EMERALD_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF
	static_debris = list(/obj/item/roguegem/green = 1)

/obj/item/rogueweapon/woodstaff/sapphire
	name = "sapphire-focused staff"
	desc = "A beautiful blue focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "sapphirestaff"
	cast_time_reduction = SAPPHIRE_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF
	static_debris = list(/obj/item/roguegem/violet = 1)

/obj/item/rogueweapon/woodstaff/quartz
	name = "quartz-focused staff"
	desc = "A crystal-clear focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "quartzstaff"
	cast_time_reduction = QUARTZ_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF
	static_debris = list(/obj/item/roguegem/blue = 1)

/obj/item/rogueweapon/woodstaff/ruby
	name = "ruby-focused staff"
	desc = "A sanguine focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "rubystaff"
	cast_time_reduction = RUBY_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF
	static_debris = list(/obj/item/roguegem = 1)

/obj/item/rogueweapon/woodstaff/diamond
	name = "diamond-focused staff"
	desc = "A beautifully faceted focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "diamondstaff"
	cast_time_reduction = DIAMOND_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF
	static_debris = list(/obj/item/roguegem/diamond = 1)

/obj/item/rogueweapon/woodstaff/riddle_of_steel
	name = "\improper Staff of the Riddle-Steel"
	desc = "Flame dances within the focus-gem of this mighty staff at a rhythm and intensity to match the \
	mage that wields it."
	icon_state = "riddlestaff"
	cast_time_reduction = RIDDLE_OF_STEEL_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF
	static_debris = list(/obj/item/riddleofsteel = 1)

/obj/item/rogueweapon/woodstaff/riddle_of_steel/head_mage
	name = "\improper Staff of the Head Mage"
	icon_state = "courtstaff"
	static_debris = list(/obj/item/riddleofsteel = 1)

/obj/item/rogueweapon/woodstaff/halfs_moon
	name = "staff of the halfs-moon"
	icon_state = "naledistaff"
	cast_time_reduction = DIAMOND_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF
	static_debris = list(/obj/item/roguegem/diamond = 1)

//crafting datums

/datum/crafting_recipe/toper_staff
	name = "topez-focused staff"
	result = /obj/item/rogueweapon/woodstaff/topaz
	reqs = list(/obj/item/rogueweapon/woodstaff = 1,
				/obj/item/roguegem/yellow = 1)
	craftdiff = 0

/datum/crafting_recipe/amethyst_staff
	name = "amethyst-focused staff"
	result = /obj/item/rogueweapon/woodstaff/amethyst
	reqs = list(/obj/item/rogueweapon/woodstaff = 1,
				/obj/item/roguegem/amethyst = 1)
	craftdiff = 0

/datum/crafting_recipe/emerald_staff
	name = "gemerald-focused staff"
	result = /obj/item/rogueweapon/woodstaff/emerald
	reqs = list(/obj/item/rogueweapon/woodstaff = 1,
				/obj/item/roguegem/green = 1)
	craftdiff = 0

/datum/crafting_recipe/sapphire_staff
	name = "saffira-focused staff"
	result = /obj/item/rogueweapon/woodstaff/sapphire
	reqs = list(/obj/item/rogueweapon/woodstaff = 1,
				/obj/item/roguegem/violet = 1)
	craftdiff = 0

/datum/crafting_recipe/quartz_staff
	name = "blortz-focused staff"
	result = /obj/item/rogueweapon/woodstaff/quartz
	reqs = list(/obj/item/rogueweapon/woodstaff = 1,
				/obj/item/roguegem/blue = 1)
	craftdiff = 0

/datum/crafting_recipe/ruby_staff
	name = "rontz-focused staff"
	result = /obj/item/rogueweapon/woodstaff/ruby
	reqs = list(/obj/item/rogueweapon/woodstaff = 1,
				/obj/item/roguegem/ruby = 1)
	craftdiff = 0

/datum/crafting_recipe/diamond_staff
	name = "dorpel-focused staff"
	result = /obj/item/rogueweapon/woodstaff/diamond
	reqs = list(/obj/item/rogueweapon/woodstaff = 1,
				/obj/item/roguegem/diamond = 1)
	craftdiff = 0

/datum/crafting_recipe/riddle_of_steel_staff
	name = "Staff of the Riddlesteel"
	result = /obj/item/rogueweapon/woodstaff/riddle_of_steel
	reqs = list(/obj/item/rogueweapon/woodstaff = 1,
				/obj/item/riddleofsteel = 1)
	craftdiff = 0
