/obj/structure/flora/newtree
	name = "tree"
	desc = "The thick core of a tree."
	icon = 'icons/roguetown/misc/tree.dmi'
	icon_state = "tree1"
	var/tree_type = 1
	var/base_state
	blade_dulling = DULLING_CUT
	opacity = 1
	density = 1
	attacked_sound = 'sound/misc/woodhit.ogg'
	destroy_sound = 'sound/misc/woodhit.ogg'
	climbable = FALSE
	static_debris = list(/obj/item/grown/log/tree = 1)
	obj_flags = CAN_BE_HIT | BLOCK_Z_IN_UP | BLOCK_Z_OUT_DOWN
	max_integrity = 400
	/// The tree trunk below this one, if any.
	var/obj/structure/flora/newtree/trunk_below = null

/obj/structure/flora/newtree/fire_act(added, maxstacks)
	if(added <= 5)
		return
	return ..()

/obj/structure/flora/newtree/attack_right(mob/user)
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

/obj/structure/flora/newtree/obj_destruction(damage_flag)//this proc is stupidly long for a destruction proc
	var/turf/NT = get_turf(src)
	var/turf/UPNT = get_step_multiz(src, UP)
	src.obj_flags = CAN_BE_HIT | BLOCK_Z_IN_UP //so the logs actually fall when pulled by zfall

	for(var/obj/structure/flora/newtree/D in UPNT)//theoretically you'd be able to break trees through a floor but no one is building floors under a tree so this is probably fine
		D.obj_destruction(damage_flag)
	for(var/obj/item/grown/log/tree/I in UPNT)
		UPNT.zFall(I)

	for(var/DI in GLOB.cardinals)
		var/turf/B = get_step(src, DI)
		for(var/obj/structure/flora/newbranch/BRANCH in B)//i straight up can't use locate here, it does not work
			if(BRANCH.dir == DI)
				var/turf/BI = get_step(B, DI)
				for(var/obj/structure/flora/newbranch/bi in BI)//2 tile end branch
					if(bi.dir == DI)
						bi.obj_flags = CAN_BE_HIT
						bi.obj_destruction(damage_flag)
					for(var/atom/bio in BI)
						BI.zFall(bio)
				for(var/obj/structure/flora/newleaf/bil in BI)//2 tile end leaf
					bil.obj_destruction(damage_flag)
				BRANCH.obj_flags = CAN_BE_HIT 
				BRANCH.obj_destruction(damage_flag)
			for(var/atom/BRA in B)//unload a sack of rocks on a branch and stand under it, it'll be funny bro
				B.zFall(BRA)

	for(var/turf/DIA in block(get_step(src, SOUTHWEST), get_step(src, NORTHEAST)))
		for(var/obj/structure/flora/newleaf/LEAF in DIA)
			LEAF.obj_destruction(damage_flag)

	if(!istype(NT, /turf/open/transparent/openspace) && !(locate(/obj/structure/flora/roguetree/stump) in NT))//if i don't add the stump check it spawns however many zlevels it goes up because of src recursion
		new /obj/structure/flora/roguetree/stump(NT)
	playsound(src, 'sound/misc/treefall.ogg', 100, FALSE)
	. = ..()

/obj/structure/flora/newtree/attack_hand(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(L.stat != CONSCIOUS || L.incapacitated() || !(L.mobility_flags & MOBILITY_STAND))
			return
		var/turf/target = get_step_multiz(user, UP)
		if(!istype(target, /turf/open/transparent/openspace))
			to_chat(user, span_warning("I can't climb here."))
			return
		if(!L.can_zTravel(target, UP))
			to_chat(user, span_warning("I can't climb there."))
			return
		var/used_time = 3 SECONDS
		var/exp_to_gain = 0
		var/myskill = SKILL_LEVEL_NOVICE // default for NPCs
		if(L.mind)
			myskill = L.mind.get_skill_level(/datum/skill/misc/climbing)
			if(HAS_TRAIT(L, TRAIT_WOODWALKER))
				exp_to_gain = L.STAINT
			else
				exp_to_gain = L.STAINT/2
			var/obj/structure/table/TA = locate() in L.loc
			if(TA)
				myskill += 1
			else
				var/obj/structure/chair/CH = locate() in L.loc
				if(CH)
					myskill += 1
			used_time = max(70 - (myskill * 10) - (L.STASPD * 3), (HAS_TRAIT(L, TRAIT_WOODWALKER) ? 15 : 30))
		playsound(user, 'sound/foley/climb.ogg', 100, TRUE)
		user.visible_message(span_warning("[user] starts to climb [src]."), span_warning("I start to climb [src]..."))
		if(do_after(L, used_time, target = src))
			var/pulling = user.pulling
			if(ismob(pulling))
				user.pulling.forceMove(target)
			user.forceMove(target)
			user.start_pulling(pulling,supress_message = TRUE)
			playsound(user, 'sound/foley/climb.ogg', 100, TRUE)
			if(L.mind) // idk just following whats going on above
				L.mind.add_sleep_experience(/datum/skill/misc/climbing, exp_to_gain, FALSE)

/obj/structure/flora/newtree/update_icon()
	icon_state = ""
	cut_overlays()
	var/mutable_appearance/M
	if(base_state)
		M = mutable_appearance(icon, "[base_state]")
		add_overlay(M)
	M = mutable_appearance(icon, "tree[tree_type]")
	M.dir = dir
	add_overlay(M)

/obj/structure/flora/newtree/Initialize(mapload, obj/structure/flora/newtree/trunk_below)
	. = ..()
	tree_type = rand(1,2)
	dir = pick(GLOB.cardinals)
	SStreesetup.initialize_me |= src

	if(trunk_below)
		RegisterSignal(trunk_below, COMSIG_PARENT_QDELETING, PROC_REF(on_trunk_below_deleting))
		RegisterSignal(trunk_below, COMSIG_OBJ_DECONSTRUCT, PROC_REF(on_trunk_below_deconstructing))
		src.trunk_below = trunk_below

	build_trees()
	update_icon()
	if(istype(loc, /turf/open/floor/rogue/grass))
		var/turf/my_turf = loc
		my_turf.ChangeTurf(/turf/open/floor/rogue/dirt)

/obj/structure/flora/newtree/Destroy()
	UnregisterSignal(trunk_below, list(COMSIG_OBJ_DECONSTRUCT, COMSIG_PARENT_QDELETING))
	trunk_below = null
	return ..()

/// Handler to make sure the trunks above get deleted at the same time as the trunk below.
/obj/structure/flora/newtree/proc/on_trunk_below_deleting(datum/source, force)
	SIGNAL_HANDLER
	UnregisterSignal(trunk_below, list(COMSIG_OBJ_DECONSTRUCT, COMSIG_PARENT_QDELETING))
	qdel(src, force)

/// Handler to make sure the trunks above get deconstructed at the same time as the trunk below.
/obj/structure/flora/newtree/proc/on_trunk_below_deconstructing(datum/source, disassembled)
	SIGNAL_HANDLER
	UnregisterSignal(trunk_below, list(COMSIG_OBJ_DECONSTRUCT, COMSIG_PARENT_QDELETING))
	deconstruct(disassembled)

/obj/structure/flora/newtree/proc/build_trees()
	var/turf/target = get_step_multiz(src, UP)
	if(istype(target, /turf/open/transparent/openspace))
		var/obj/structure/flora/newtree/next_tree_segment = new(target, src)
		next_tree_segment.base_state = "center-leaf[rand(1,2)]"
		next_tree_segment.update_icon()

/obj/structure/flora/newtree/proc/build_branches()
	for(var/D in GLOB.cardinals)
		var/turf/NT = get_step(src, D)
		if(istype(NT, /turf/open/transparent/openspace))
			var/turf/NB = get_step(NT, D)
			if(istype(NB, /turf/open/transparent/openspace) && prob(50))//make an ending branch
				if(prob(50))
					if(!locate(/obj/structure) in NB)
						var/obj/structure/flora/newbranch/T = new(NB, src)
						T.dir = D
					if(!locate(/obj/structure) in NT)
						var/obj/structure/flora/newbranch/connector/TC = new(NT, src)
						TC.dir = D
				else
					if(!locate(/obj/structure) in NB)
						new /obj/structure/flora/newleaf(NB, src)
					if(!locate(/obj/structure) in NT)
						var/obj/structure/flora/newbranch/TC = new(NT, src)
						TC.dir = D
			else
				if(!locate(/obj/structure) in NT)
					var/obj/structure/flora/newbranch/TC = new(NT, src)
					TC.dir = D
		else
			if(prob(70))
				if(isopenturf(NT))
					if(!istype(loc, /turf/open/transparent/openspace)) //must be lowest
						if(!locate(/obj/structure) in NT)
							var/obj/structure/flora/newbranch/leafless/T = new(NT, src)
							T.dir = D


/obj/structure/flora/newtree/proc/build_leafs()
	for(var/D in GLOB.diagonals)
		var/turf/NT = get_step(src, D)
		if(istype(NT, /turf/open/transparent/openspace))
			if(!locate(/obj/structure) in NT)
				var/obj/structure/flora/newleaf/corner/T = new(NT, src)
				T.dir = D


///BRANCHES

/obj/structure/flora/newbranch
	name = "branch"
	desc = "A stable branch, should be safe to walk on."
	icon = 'icons/roguetown/misc/tree.dmi'
	icon_state = "branch-end1"
	attacked_sound = 'sound/misc/woodhit.ogg'
//	var/tree_type = 1
	var/base_state = TRUE
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN
	static_debris = list(/obj/item/grown/log/tree/stick = 1)
	density = FALSE
	max_integrity = 30
	/// The tree trunk this branch is attached to, if any.
	var/obj/structure/flora/newtree/parent_trunk = null

/obj/structure/flora/newbranch/update_icon()
	icon_state = ""
	cut_overlays()
	var/mutable_appearance/M
	if(base_state)
		M = mutable_appearance(icon, "[base_state]")
		M.dir = pick(GLOB.cardinals)
		add_overlay(M)
	M = mutable_appearance(icon, "branch-end[rand(1,2)]")
	M.dir = dir
	add_overlay(M)

/obj/structure/flora/newbranch/Initialize(mapload, obj/structure/flora/newtree/parent_trunk)
	. = ..()
	if(base_state)
		AddComponent(/datum/component/squeak, list('sound/foley/plantcross1.ogg','sound/foley/plantcross2.ogg','sound/foley/plantcross3.ogg','sound/foley/plantcross4.ogg'), 100)
		base_state = "center-leaf[rand(1,2)]"

	if(parent_trunk)
		RegisterSignal(parent_trunk, COMSIG_PARENT_QDELETING, PROC_REF(on_trunk_deleting))
		src.parent_trunk = parent_trunk

	update_icon()

/obj/structure/flora/newbranch/Destroy()
	UnregisterSignal(parent_trunk, COMSIG_PARENT_QDELETING)
	parent_trunk = null
	return ..()

/// Signal handler for when the trunk this is connected to gets deleted.
/obj/structure/flora/newbranch/proc/on_trunk_deleting(datum/source)
	SIGNAL_HANDLER
	if(QDELETED(src))
		return

	var/turf/my_turf = get_turf(src)

	for(var/atom/stuff in my_turf)
		if(stuff == src)
			continue

		my_turf.zFall(stuff)

	qdel(src)

/obj/structure/flora/newbranch/connector
	icon_state = "branch-extend"

/obj/structure/flora/newbranch/connector/update_icon()
	icon_state = ""
	cut_overlays()
	var/mutable_appearance/M
	if(base_state)
		M = mutable_appearance(icon, "[base_state]")
		M.dir = pick(GLOB.cardinals)
		add_overlay(M)
	M = mutable_appearance(icon, "branch-extend")
	M.dir = dir
	add_overlay(M)

/obj/structure/flora/newbranch/leafless
	base_state = FALSE

/obj/structure/flora/newbranch/leafless/update_icon()
	icon_state = ""
	cut_overlays()
	var/mutable_appearance/M = mutable_appearance(icon, "branch-end[rand(1,2)]")
	M.dir = dir
	add_overlay(M)

/// LEAF


/obj/structure/flora/newleaf/corner
	icon = 'icons/roguetown/misc/tree.dmi'
	icon_state = "corner-leaf1"


/obj/structure/flora/newleaf/corner/Initialize(mapload, obj/structure/flora/newtree/parent_trunk)
	. = ..()
	icon_state = "corner-leaf[rand(1,2)]"
	update_icon()

/obj/structure/flora/newleaf
	name = "leaves"
	desc = "A bunch of lavees from a nearby tree."
	icon = 'icons/roguetown/misc/tree.dmi'
	icon_state = "center-leaf1"
	density = FALSE
	max_integrity = 10
	/// The tree trunk these leaves are attached to, if any.
	var/obj/structure/flora/newtree/parent_trunk = null
	/// How many acorns can be harvested from these leaves?
	var/acorn_count = NONE
	/// The chance that these leaves spawn with acorns in them.
	var/acorn_chance = 50
	/// The maximum amount of acorns that can be found in these leaves.
	var/max_acorn_count = 4
	/// Which acorn types can be found in these leaves, as a weighted list.
	var/list/possible_acorns = list(
		/obj/item/acorn = 45,
		/obj/item/acorn/small = 30,
		/obj/item/acorn/large = 10,
		/obj/item/acorn/tall = 15,
	)

/obj/structure/flora/newleaf/Initialize(mapload, obj/structure/flora/newtree/parent_trunk)
	. = ..()
	if(parent_trunk)
		RegisterSignal(parent_trunk, COMSIG_PARENT_QDELETING, PROC_REF(on_trunk_deleting))
		src.parent_trunk = parent_trunk

	if(prob(acorn_chance))
		acorn_count = rand(1, max_acorn_count)

	icon_state = "center-leaf[rand(1,2)]"
	update_icon()

/obj/structure/flora/newleaf/Destroy()
	UnregisterSignal(parent_trunk, COMSIG_PARENT_QDELETING)
	parent_trunk = null
	return ..()

/obj/structure/flora/newleaf/examine(mob/user)
	. = ..()
	if(acorn_count <= 0)
		return
	
	. += "These seem to be hiding <b>[acorn_count]</b> acorn[acorn_count > 1 ? "s" : ""]."

/// Signal handler for when the trunk this is connected to gets deleted.
/obj/structure/flora/newleaf/proc/on_trunk_deleting(datum/source)
	SIGNAL_HANDLER
	if(QDELETED(src))
		return

	qdel(src)

/obj/structure/flora/newleaf/attack_right(mob/user)
	. = ..()
	if(.)
		return
	
	if(acorn_count <= 0)
		return

	acorn_count -= 1
	var/acorn_type = pickweight(possible_acorns)
	var/obj/item/acorn/acorn = new acorn_type(src)
	playsound(src, 'sound/items/seedextract.ogg', 75, TRUE)
	var/grabbed_it = user.put_in_hands(acorn)

	if(grabbed_it)
		user.visible_message(span_notice("You grab \an [acorn] from [src]."))
	else
		visible_message(span_warning("[user] dislodges \an [acorn] from [src], but it falls down because [user.p_they()] didn't have a free hand to catch it!"))
		var/turf/current_turf = get_turf(src)
		acorn.forceMove(current_turf)
	
	return TRUE
