
//newtree

/obj/structure/flora/roguetree
	name = "old tree"
	desc = "An old, wicked tree that not even elves could love."
	icon = 'icons/roguetown/misc/foliagetall.dmi'
	icon_state = "t1"
	opacity = 1
	density = 1
	max_integrity = 200
	blade_dulling = DULLING_CUT
	pixel_x = -16
	layer = 4.81
	plane = GAME_PLANE_UPPER
	attacked_sound = 'sound/misc/woodhit.ogg'
	destroy_sound = 'sound/misc/woodhit.ogg'
	debris = list(/obj/item/grown/log/tree/stick = 2)
	static_debris = list(/obj/item/grown/log/tree = 1)
	alpha = 200
	var/stump_type = /obj/structure/flora/roguetree/stump

/obj/structure/flora/roguetree/attack_right(mob/user)
	if(user.mind && isliving(user))
		if(user.mind.special_items && user.mind.special_items.len)
			var/item = input(user, "What will I take?", "STASH") as null|anything in user.mind.special_items
			if(item)
				if(user.Adjacent(src))
					if(user.mind.special_items[item])
						var/path2item = user.mind.special_items[item]
						user.mind.special_items -= item
						var/obj/item/I = new path2item(user.loc)
						user.put_in_hands(I)
			return

/obj/structure/flora/roguetree/fire_act(added, maxstacks)
	if(added <= 5)
		return
	return ..()

/obj/structure/flora/roguetree/obj_destruction(damage_flag)
	if(stump_type)
		new stump_type(loc)
	playsound(src, 'sound/misc/treefall.ogg', 100, FALSE)
	. = ..()

/obj/structure/flora/roguetree/Initialize()
	. = ..()
	icon_state = "t[rand(1,16)]"

/obj/structure/flora/roguetree/evil/Initialize()
	. = ..()
	icon_state = "wv[rand(1,2)]"
	soundloop = new(src, FALSE)
	soundloop.start()

/obj/structure/flora/roguetree/evil/Destroy()
	soundloop.stop()
	if(controller)
		controller.endvines()
		controller.tree = null
	controller = null
	. = ..()

/obj/structure/flora/roguetree/evil
	var/datum/looping_sound/boneloop/soundloop
	var/datum/spacevine_controller/controller

/obj/structure/flora/roguetree/wise
	name = "sacred tree"
	desc = "A blessed primordial tree, ancient beyond years. Said to be the very embodiment of the Tree Father himself--his very presence imbuing druids with wild energies."
	icon_state = "mystical"
	max_integrity = 400

/obj/structure/flora/roguetree/wise/Initialize()
	. = ..()
	icon_state = "mystical"
/*
/obj/structure/flora/roguetree/wise/examine(mob/user)
	. = ..()
	user.play_priomusic('sound/music/tree.ogg', MUSIC_PRIO_DEFAULT)
*/

/obj/structure/flora/roguetree/burnt
	name = "young tree"
	desc = "A young, growing tree. Past its time as a sapling, but not yet worth climbing."
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "t1"
	stump_type = /obj/structure/flora/roguetree/stump/burnt
	pixel_x = -32

/obj/structure/flora/roguetree/burnt/Initialize()
	. = ..()
	icon_state = "t[rand(1,4)]"

/obj/structure/flora/roguetree/stump/burnt
	name = "tree stump"
	desc = "Youth cut away before it could reach its prime."
	icon_state = "st1"
	icon = 'icons/roguetown/misc/96x96.dmi'
	stump_type = null
	pixel_x = -32

/obj/structure/flora/roguetree/stump/burnt/Initialize()
	. = ..()
	icon_state = "st[rand(1,2)]"

/obj/structure/flora/roguetree/underworld
	name = "screaming tree"
	desc = "Human faces everywhere."
	icon = 'icons/roguetown/misc/foliagetall.dmi'
	icon_state = "screaming1"
	opacity = 1
	density = 1

/obj/structure/flora/roguetree/underworld/Initialize()
	. = ..()
	icon_state = "screaming[rand(1,3)]"

/obj/structure/flora/roguetree/stump
	name = "tree stump"
	desc = "Someone cut this tree down."
	icon_state = "t1stump"
	opacity = 0
	max_integrity = 100
	climbable = TRUE
	climb_time = 0
	layer = TABLE_LAYER
	plane = GAME_PLANE
	blade_dulling = DULLING_CUT
	// debris = list(/obj/item/grown/log/tree/stick = 1) // Removed for lumberjacking/handcart upgrade PR
	static_debris = list(/obj/item/grown/log/tree/small = 1)
	alpha = 255
	pixel_x = -16
	climb_offset = 14
	stump_type = FALSE

/obj/structure/flora/roguetree/stump/Initialize()
	. = ..()
	icon_state = "t[rand(1,4)]stump"

/obj/structure/flora/roguetree/stump/log
	name = "ancient log"
	desc = "Rotten remains of a tree that suffered nature's cruelty ages ago."
	icon_state = "log1"
	opacity = 0
	max_integrity = 200
	blade_dulling = DULLING_CUT
	static_debris = list(/obj/item/grown/log/tree = 1)
	climb_offset = 14
	stump_type = FALSE

/obj/structure/flora/roguetree/stump/log/Initialize()
	. = ..()
	icon_state = "log[rand(1,2)]"


//newbushes

/obj/structure/flora/roguegrass
	name = "grass"
	desc = "Green, soft and lively."
	icon = 'icons/roguetown/misc/foliage.dmi'
	icon_state = "grass1"
	attacked_sound = "plantcross"
	destroy_sound = "plantcross"
	max_integrity = 5
	blade_dulling = DULLING_CUT
	debris = list(/obj/item/natural/fibers = 1)


/obj/structure/flora/roguegrass/spark_act()
	fire_act()

/obj/structure/flora/roguegrass/Initialize()
	update_icon()
	AddComponent(/datum/component/roguegrass)
	. = ..()

/obj/structure/flora/roguegrass/update_icon()
	icon_state = "grass[rand(1, 6)]"

/obj/structure/flora/roguegrass/water
	name = "grass"
	desc = "This grass is sodden and muddy."
	icon_state = "swampgrass"
	max_integrity = 5

/obj/structure/flora/roguegrass/water/reeds
	name = "reeds"
	desc = "This plant thrives in water, and shelters dangers."
	icon_state = "reeds"
	opacity = 1
	max_integrity = 10
	layer = 4.1
	blade_dulling = DULLING_CUT

/obj/structure/flora/roguegrass/water/update_icon()
	dir = pick(GLOB.cardinals)

/datum/component/roguegrass/Initialize()
	RegisterSignal(parent, list(COMSIG_MOVABLE_CROSSED), PROC_REF(Crossed))

/datum/component/roguegrass/proc/Crossed(datum/source, atom/movable/AM)
	var/atom/A = parent

	if(isliving(AM))
		var/mob/living/L = AM
		if(L.is_flying())
			return
		if(L.m_intent == MOVE_INTENT_SNEAK)
			return
		else
			if(!(HAS_TRAIT(L, TRAIT_SUNMARCHNATIVE) && L.m_intent != MOVE_INTENT_RUN))
				playsound(A.loc, "plantcross", 100, FALSE, -1)
			var/oldx = A.pixel_x
			animate(A, pixel_x = oldx+1, time = 0.5)
			animate(pixel_x = oldx-1, time = 0.5)
			animate(pixel_x = oldx, time = 0.5)
			L.consider_ambush()
	return


/obj/structure/flora/roguegrass/bush
	name = "bush"
	desc = "A bush, I think I can see some spiders crawling in it."
	icon_state = "bush1"
	layer = ABOVE_ALL_MOB_LAYER
	var/res_replenish
	blade_dulling = DULLING_CUT
	max_integrity = 35
	climbable = FALSE
	dir = SOUTH
	debris = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 1)
	var/list/looty = list()
	var/bushtype

/obj/structure/flora/roguegrass/bush/Initialize()
	if(prob(88))
		bushtype = pickweight(list(/obj/item/reagent_containers/food/snacks/grown/berries/rogue=5,
					/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison=3,
					/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed=1))
	loot_replenish()
	pixel_x += rand(-3,3)
	return ..()

/obj/structure/flora/roguegrass/bush/proc/loot_replenish()
	if(bushtype)
		looty += bushtype
	if(prob(66))
		looty += /obj/item/natural/thorn
	looty += /obj/item/natural/fibers


/obj/structure/flora/roguegrass/bush/Crossed(atom/movable/AM)
	..()
	if(isliving(AM))
		var/mob/living/L = AM
		if(L.m_intent == MOVE_INTENT_RUN && (L.mobility_flags & MOBILITY_STAND))
			if(!ishuman(L))
				to_chat(L, span_warning("I'm cut on a thorn!"))
				L.apply_damage(5, BRUTE)

			else
				var/mob/living/carbon/human/H = L
				if(prob(20))
					if(!HAS_TRAIT(src, TRAIT_PIERCEIMMUNE))
//						H.throw_alert("embeddedobject", /atom/movable/screen/alert/embeddedobject)
						var/obj/item/bodypart/BP = pick(H.bodyparts)
						var/obj/item/natural/thorn/TH = new(src.loc)
						BP.add_embedded_object(TH, silent = TRUE)
						BP.receive_damage(10)
						to_chat(H, span_danger("\A [TH] impales my [BP.name]!"))
				else
					var/obj/item/bodypart/BP = pick(H.bodyparts)
					to_chat(H, span_warning("A thorn [pick("slices","cuts","nicks")] my [BP.name]."))
					BP.receive_damage(10)

/obj/structure/flora/roguegrass/bush/attack_hand(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		user.changeNext_move(CLICK_CD_MELEE)
		playsound(src.loc, "plantcross", 50, FALSE, -1)
		if(do_after(L, rand(1,5), target = src))
			if(!looty.len && (world.time > res_replenish))
				loot_replenish()
			if(looty.len)
				if(looty.len == 1)
					res_replenish = world.time + 8 MINUTES
				var/obj/item/loot = pick_n_take(looty)
				if(loot)
					var/obj/item/B = new loot.type(user.loc)
					user.put_in_hands(B)
					if(HAS_TRAIT(user, TRAIT_WOODWALKER))
						var/obj/item/C = new loot.type(user.loc)
						user.put_in_hands(C)
					user.visible_message(span_notice("[user] finds [HAS_TRAIT(user, TRAIT_WOODWALKER) ? "two " : ""][loot.name] in [src]."))
					return
			user.visible_message(span_warning("[user] searches through [src]."))
			if((looty.len) && do_after(user, CLICK_CD_MELEE))
				attack_hand(user)
			if(!looty.len)
				to_chat(user, span_warning("Picked clean... I should try later."))
/obj/structure/flora/roguegrass/bush/update_icon()
	icon_state = "bush[rand(1, 4)]"

/obj/structure/flora/roguegrass/bush/CanAStarPass(ID, travel_dir, caller)
	if(ismovableatom(caller))
		var/atom/movable/mover = caller
		if(mover.pass_flags & PASSGRILLE)
			return TRUE
	if(travel_dir == dir)
		return FALSE // just don't even try, not even if you can climb it
	return ..()

/obj/structure/flora/roguegrass/bush/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSGRILLE))
		return 1
	if(get_dir(loc, target) == dir)
		return 0
	return 1

/obj/structure/flora/roguegrass/bush/CheckExit(atom/movable/mover as mob|obj, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSGRILLE))
		return 1
	if(get_dir(mover.loc, target) == dir)
		return 0
	return 1

/obj/structure/flora/roguegrass/bush/red
	icon_state = "bush1red"

/obj/structure/flora/roguegrass/bush/red/Initialize()
	. = ..()
	icon_state = "bush[rand(1,4)]red"

/obj/structure/flora/roguegrass/bush/winter
	icon_state = "bush1winter"

/obj/structure/flora/roguegrass/bush/winter/Initialize()
	. = ..()
	icon_state = "bush[rand(1,4)]winter"

/obj/structure/flora/roguegrass/bush/wall
	name = "great bush"
	desc = "A bush, this one's roots are thick and block the way."
	opacity = TRUE
	density = 1
	climbable = FALSE
	icon_state = "bushwall1"
	max_integrity = 150
	debris = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 1, /obj/item/natural/thorn = 1)
	attacked_sound = 'sound/misc/woodhit.ogg'

/obj/structure/flora/roguegrass/bush/wall/Initialize()
	. = ..()
	icon_state = "bushwall[pick(1,2)]"

/obj/structure/flora/roguegrass/bush/wall/update_icon()
	return

/obj/structure/flora/roguegrass/bush/wall/CanAStarPass(ID, travel_dir, caller)
	if(ismovableatom(caller))
		var/atom/movable/mover = caller
		if(mover.pass_flags & PASSGRILLE)
			return TRUE
	return climbable || !density

/obj/structure/flora/roguegrass/bush/wall/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSGRILLE))
		return TRUE
	return FALSE

/obj/structure/flora/roguegrass/bush/wall/CheckExit(atom/movable/O, turf/target)
	if(istype(O) && (O.pass_flags & PASSGRILLE))
		return TRUE
	return FALSE

/obj/structure/flora/roguegrass/bush/wall/red
	icon_state = "bushwall1red"

/obj/structure/flora/roguegrass/bush/wall/red/Initialize()
	. = ..()
	icon_state = "bushwall[pick(1,2)]red"

/obj/structure/flora/roguegrass/bush/wall/winter
	icon_state = "bushwall1winter"

/obj/structure/flora/roguegrass/bush/wall/winter/Initialize()
	. = ..()
	icon_state = "bushwall[pick(1,2)]winter"

/obj/structure/flora/roguegrass/bush/wall/tall
	icon = 'icons/roguetown/misc/foliagetall.dmi'
	icon_state = "tallbush1"
	opacity = 1
	pixel_x = -16
	debris = null
	static_debris = null

/obj/structure/flora/roguegrass/bush/wall/tall/Initialize()
	. = ..()
	icon_state = "tallbush[pick(1,2)]"

/obj/structure/flora/roguegrass/bush/wall/tall/red
	icon_state = "tallbush1red"

/obj/structure/flora/roguegrass/bush/wall/tall/red/Initialize()
	. = ..()
	icon_state = "tallbush[pick(1,2)]red"


/obj/structure/flora/rogueshroom
	name = "mushroom"
	desc = "Mushrooms are the only happy beings in this island."
	icon = 'icons/roguetown/misc/foliagetall.dmi'
	icon_state = "mush1"
	opacity = 0
	density = 0
	max_integrity = 120
	blade_dulling = DULLING_CUT
	pixel_x = -16
	layer = 4.81
	attacked_sound = 'sound/misc/woodhit.ogg'
	destroy_sound = 'sound/misc/woodhit.ogg'
	static_debris = list( /obj/item/grown/log/tree/small = 1)
	dir = SOUTH

/obj/structure/flora/rogueshroom/attack_right(mob/user)
	if(user.mind && isliving(user))
		if(user.mind.special_items && user.mind.special_items.len)
			var/item = input(user, "What will I take?", "STASH") as null|anything in user.mind.special_items
			if(item)
				if(user.Adjacent(src))
					if(user.mind.special_items[item])
						var/path2item = user.mind.special_items[item]
						user.mind.special_items -= item
						var/obj/item/I = new path2item(user.loc)
						user.put_in_hands(I)
			return


/obj/structure/flora/rogueshroom/Initialize()
	. = ..()
	icon_state = "mush[rand(1,5)]"
	if(icon_state == "mush5")
		static_debris = list(/obj/item/natural/thorn=1, /obj/item/grown/log/tree/small = 1)
	pixel_x += rand(8,-8)

/obj/structure/flora/rogueshroom/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSGRILLE))
		return 1
	if(get_dir(loc, target) == dir)
		return 0
	return 1

/obj/structure/flora/rogueshroom/CanAStarPass(ID, travel_dir, caller)
	if(ismovableatom(caller))
		var/atom/movable/mover = caller
		if(mover.pass_flags & PASSGRILLE)
			return TRUE
	if(travel_dir == dir)
		return FALSE // just don't even try, not even if you can climb it
	return ..()

/obj/structure/flora/rogueshroom/CheckExit(atom/movable/mover as mob|obj, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSGRILLE))
		return 1
	if(get_dir(mover.loc, target) == dir)
		return 0
	return 1

/obj/structure/flora/rogueshroom/fire_act(added, maxstacks)
	if(added <= 5)
		return
	return ..()

/obj/structure/flora/rogueshroom/obj_destruction(damage_flag)
	var/obj/structure/S = new /obj/structure/flora/shroomstump(loc)
	S.icon_state = "[icon_state]stump"
	. = ..()


/obj/structure/flora/shroomstump
	name = "shroom stump"
	desc = "It was a very happy shroom. Not anymore."
	icon_state = "mush1stump"
	opacity = 0
	max_integrity = 100
	climbable = TRUE
	climb_time = 0
	density = TRUE
	icon = 'icons/roguetown/misc/foliagetall.dmi'
	layer = TABLE_LAYER
	blade_dulling = DULLING_PICK
	static_debris = null
	debris = null
	alpha = 255
	pixel_x = -16
	climb_offset = 14

/obj/structure/flora/shroomstump/Initialize()
	. = ..()
	icon_state = "t[rand(1,4)]stump"

/obj/structure/roguerock
	name = "rock"
	desc = "A rock protuding from the ground."
	icon_state = "rock1"
	icon = 'icons/roguetown/misc/foliage.dmi'
	opacity = 0
	max_integrity = 50
	climbable = TRUE
	climb_time = 30
	density = TRUE
	layer = TABLE_LAYER
	blade_dulling = DULLING_BASH
	static_debris = null
	debris = null
	alpha = 255
	climb_offset = 14
	destroy_sound = 'sound/foley/smash_rock.ogg'
	attacked_sound = 'sound/foley/hit_rock.ogg'
	static_debris = list(/obj/item/natural/stone = 1)

/obj/structure/roguerock/Initialize()
	. = ..()
	icon_state = "rock[rand(1,4)]"

//Thorn bush

/obj/structure/flora/roguegrass/thorn_bush
    name = "thorn bush"
    desc = "A thorny bush, watch your step!"
    icon_state = "thornbush"
    layer = ABOVE_ALL_MOB_LAYER
    blade_dulling = DULLING_CUT
    max_integrity = 35
    climbable = FALSE
    dir = SOUTH
    debris = list(/obj/item/natural/thorn = 3, /obj/item/grown/log/tree/stick = 1)

/obj/structure/flora/roguegrass/thorn_bush/update_icon()
	icon_state = "thornbush"
//WIP

// fyrituis bush -- STONEKEEP PORT
/obj/structure/flora/roguegrass/pyroclasticflowers
	name = "odd group of flowers"
	desc = "A cluster of dangerously combustible flowers."
	icon_state = "pyroflower1"
	layer = ABOVE_ALL_MOB_LAYER
	max_integrity = 1
	climbable = FALSE
	dir = SOUTH
	debris = list(/obj/item/natural/fibers = 1)
	var/list/looty = list()
	var/bushtype
	var/res_replenish

/obj/structure/flora/roguegrass/pyroclasticflowers/update_icon()
	icon_state = "pyroflower[rand(1,3)]"

/obj/structure/flora/roguegrass/pyroclasticflowers/Initialize()
	. = ..()
	if(prob(88))
		bushtype = pickweight(list(/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 1))
	loot_replenish2()
	pixel_x += rand(-3,3)

/obj/structure/flora/roguegrass/pyroclasticflowers/proc/loot_replenish2()
	if(bushtype)
		looty += bushtype
	if(prob(66))
		looty += /obj/item/reagent_containers/food/snacks/grown/rogue/fyritius

// pyroflower cluster looting
/obj/structure/flora/roguegrass/pyroclasticflowers/attack_hand(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		user.changeNext_move(CLICK_CD_MELEE)
		playsound(src.loc, "plantcross", 80, FALSE, -1)
		if(do_after(L, rand(1,5), target = src))
			if(!looty.len && (world.time > res_replenish))
				loot_replenish2()
			if(prob(50) && looty.len)
				if(looty.len == 1)
					res_replenish = world.time + 8 MINUTES
				var/obj/item/B = pick_n_take(looty)
				if(B)
					B = new B(user.loc)
					user.put_in_hands(B)
					user.visible_message("<span class='notice'>[user] finds [B] in [src].</span>")
					return
			user.visible_message("<span class='warning'>[user] searches through [src].</span>")
			if(!looty.len)
				to_chat(user, "<span class='warning'>Picked clean... I should try later.</span>")

// swarmpweed bush -- STONEKEEP PORT
/obj/structure/flora/roguegrass/swampweed
	name = "bunch of swampweed"
	desc = "a green root good for smoking."
	icon_state = "swampweed1"
	layer = ABOVE_ALL_MOB_LAYER
	max_integrity = 1
	climbable = FALSE
	dir = SOUTH
	debris = list(/obj/item/natural/fibers = 1)
	var/list/looty = list()
	var/bushtype
	var/res_replenish

/obj/structure/flora/roguegrass/swampweed/Initialize()
	. = ..()
	icon_state = "swampweed[rand(1,3)]"
	if(prob(88))
		bushtype = pickweight(list(/obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf = 1))
	loot_replenish3()
	pixel_x += rand(-3,3)

/obj/structure/flora/roguegrass/swampweed/proc/loot_replenish3()
	if(bushtype)
		looty += bushtype
	if(prob(66))
		looty += /obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf

/obj/structure/flora/roguegrass/swampweed/attack_hand(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		user.changeNext_move(CLICK_CD_MELEE)
		playsound(src.loc, "plantcross", 80, FALSE, -1)
		if(do_after(L, rand(1,5), target = src))
			if(!looty.len && (world.time > res_replenish))
				loot_replenish3()
			if(prob(50) && looty.len)
				if(looty.len == 1)
					res_replenish = world.time + 8 MINUTES
				var/obj/item/B = pick_n_take(looty)
				if(B)
					B = new B(user.loc)
					user.put_in_hands(B)
					if(HAS_TRAIT(user, TRAIT_WOODWALKER))
						var/obj/item/C = new B(user.loc)
						user.put_in_hands(C)
					user.visible_message("<span class='notice'>[user] finds [HAS_TRAIT(user, TRAIT_WOODWALKER) ? "two " : ""][B] in [src].</span>")
					return
			user.visible_message("<span class='warning'>[user] searches through [src].</span>")
			if(!looty.len)
				to_chat(user, "<span class='warning'>Picked clean... I should try later.</span>")

// cute underdark mushrooms from dreamkeep

/obj/structure/flora/rogueshroom/happy
	name = "underdark mushroom"
	icon_state = "happymush1"
	icon = 'icons/roguetown/misc/foliagetall.dmi'
	desc = "Mushrooms might be the happiest beings in this god forsaken place."

/obj/structure/flora/rogueshroom/happy/mushroom2
	icon_state = "happymush2"

/obj/structure/flora/rogueshroom/happy/mushroom3
	icon_state = "happymush3"

/obj/structure/flora/rogueshroom/happy/mushroom4
	icon_state = "happymush4"

/obj/structure/flora/rogueshroom/happy/mushroom5
	icon_state = "happymush5"

/obj/structure/flora/rogueshroom/happy/random

/obj/structure/flora/rogueshroom/happy/random/Initialize()
	. = ..()
	icon_state = "happymush[rand(1,5)]"

/obj/structure/flora/rogueshroom/happy/New(loc)
	..()
	set_light(3, 3, 3, l_color ="#5D3FD3")

/obj/structure/flora/mushroomcluster
	name = "mushroom cluster"
	desc = "A cluster of mushrooms native to the underdark."
	icon = 'icons/roguetown/misc/foliage.dmi'
	icon_state = "mushroomcluster"
	density = TRUE

/obj/structure/flora/mushroomcluster/New(loc)
	..()
	set_light(1.5, 1.5, 1.5, l_color ="#5D3FD3")

/obj/structure/flora/tinymushrooms
	name = "small mushroom cluster"
	desc = "A cluster of tiny mushrooms native to the underdark."
	icon = 'icons/roguetown/misc/foliage.dmi'
	icon_state = "tinymushrooms"
