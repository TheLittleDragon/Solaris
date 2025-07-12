/obj/effect/landmark/quest_spawner
	name = "quest landmark"
	icon = 'code/modules/roguetown/roguemachine/questing/questing.dmi'
	icon_state = "quest_marker"
	var/quest_difficulty = list("Easy", "Medium", "Hard")
	var/quest_type = list("Fetch", "Courier", "Clear Out", "Kill", "Beacon", "Miniboss")
	var/list/fetch_items = list(
		/obj/item/rogueweapon/huntingknife/throwingknife/steel,
		/obj/item/rogueweapon/huntingknife,
		/obj/item/reagent_containers/glass/bottle/rogue/whitewine
	)
	var/list/kill_mobs = list(
		/mob/living/carbon/human/species/goblin/npc/ambush/sea,
		/mob/living/carbon/human/species/skeleton/npc/ambush,
		/mob/living/carbon/human/species/human/northern/searaider/ambush,
		/mob/living/carbon/human/species/human/bandit_quest/ambush
	)
	var/miniboss_mob = list(
		/mob/living/simple_animal/hostile/boss/lost_swordsman,
		/mob/living/simple_animal/hostile/boss/bandit_leader,
		/mob/living/simple_animal/hostile/boss/archer_asshole
		)

/obj/effect/landmark/quest_spawner/proc/generate_quest(datum/quest/new_quest, mob/user)
	new_quest.quest_receiver_reference = user ? WEAKREF(user) : null
	new_quest.quest_receiver_name = user ? user.real_name : null
	new_quest.target_spawn_area = get_area_name(get_turf(src))

	switch(new_quest.quest_difficulty)
		if("Easy")
			new_quest.reward_amount = rand(15, 25)
		if("Medium")
			new_quest.reward_amount = rand(30, 50)
		if("Hard")
			new_quest.reward_amount = rand(60, 100)

	switch(new_quest.quest_type)
		if("Fetch")
			new_quest.title = "Retrieve [pick("an ancient", "a rare", "a stolen", "a magical")] [pick("artifact", "relic", "doohickey", "treasure")]"
			new_quest.target_item_type = pick(fetch_items)
			new_quest.target_amount = rand(1, 3)
			spawn_fetch_items(new_quest.target_item_type, new_quest.target_amount, new_quest)
		if("Kill")
			new_quest.title = "Slay [pick("a dangerous", "a fearsome", "a troublesome", "an elusive")] [pick("beast", "monster", "brigand", "creature")]"
			new_quest.target_mob_type = pick(kill_mobs)
			new_quest.target_amount = 1
			spawn_kill_mob(new_quest.target_mob_type, new_quest)
		if("Clear Out")
			new_quest.title = "Clear out [pick("a nest of", "a den of", "a group of", "a pack of")] [pick("monsters", "bandits", "creatures", "vermin")]"
			new_quest.target_mob_type = pick(kill_mobs)
			new_quest.target_amount = rand(3, 6)
			spawn_clear_out_mobs(new_quest.target_mob_type, new_quest.target_amount, new_quest)
		if("Courier")
			new_quest.title = "Deliver [pick("an important", "a sealed", "a confidential", "a valuable")] [pick("package", "parcel", "letter", "delivery")]"
			new_quest.target_delivery_location = pick(
			/area/provincial/indoors/town/tavern,
			/area/provincial/indoors/town/church,
			/area/provincial/indoors/town/farm,
			/area/provincial/indoors/town/blacksmith,
			/area/provincial/indoors/town/shop,
			/area/provincial/indoors/town/province_keep,
			/area/provincial/indoors/town/mages_university,
			/area/provincial/indoors/town/mages_university/alchemy_lab,
			/area/provincial/indoors/town/steward,
			)
			spawn_courier_item(new_quest, new_quest.target_delivery_location)
		if("Beacon")
			new_quest.title = "Activate [pick("an ancient", "a dormant", "a forgotten", "a mysterious")] Kasmidian beacon"
			new_quest.beacon_connection = TRUE
			if(user)
				var/list/unconnected_beacons = list()
				for(var/obj/structure/roguemachine/teleport_beacon/beacon in SSroguemachine.teleport_beacons)
					if(!(user.real_name in beacon.granted_list) && beacon != src)
						unconnected_beacons += beacon
				
				if(length(unconnected_beacons))
					var/list/difficulty_beacons = list()
					for(var/obj/structure/roguemachine/teleport_beacon/beacon in unconnected_beacons)
						if(beacon.quest_difficulty == new_quest.quest_difficulty)
							difficulty_beacons += beacon
				
					new_quest.target_beacon = pick(length(difficulty_beacons) ? difficulty_beacons : unconnected_beacons)
					new_quest.target_amount = 1
					new_quest.possible_beacons = unconnected_beacons
			else
				new_quest.possible_beacons = SSroguemachine.teleport_beacons.Copy()
				new_quest.target_amount = 1
		if("Miniboss")
			new_quest.title = "Defeat [pick("the terrible", "the dreadful", "the monstrous", "the infamous")] [pick("warlord", "beast", "sorcerer", "abomination")]"
			new_quest.target_mob_type = pick(miniboss_mob)
			new_quest.target_amount = 1
			spawn_miniboss(new_quest)

	// Initialize compass data for the quest
	if(new_quest.quest_scroll_ref)
		var/obj/item/paper/scroll/quest/scroll = new_quest.quest_scroll_ref.resolve()
		if(scroll)
			scroll.update_compass(user)

	return new_quest

/obj/effect/landmark/quest_spawner/proc/spawn_fetch_items(item_type, amount, datum/quest/quest)
	var/turf/spawn_turf = get_safe_spawn_turf()
	if(!spawn_turf)
		return

	for(var/i in 1 to amount)
		var/obj/item/new_item = new item_type(spawn_turf)
		new_item.AddComponent(/datum/component/quest_object, quest)

/obj/effect/landmark/quest_spawner/proc/spawn_kill_mob(mob_type, datum/quest/quest)
	var/turf/spawn_turf = get_safe_spawn_turf()
	if(!spawn_turf)
		return
	
	var/mob/living/new_mob = new mob_type(spawn_turf)
	new_mob.faction |= "quest"
	new_mob.AddComponent(/datum/component/quest_object, quest)
	add_quest_faction_to_nearby_mobs(spawn_turf)

/obj/effect/landmark/quest_spawner/proc/add_quest_faction_to_nearby_mobs(turf/center)
	for(var/mob/living/M in view(7, center))
		if(!M.ckey && !("quest" in M.faction))
			M.faction |= "quest"

/obj/effect/landmark/quest_spawner/proc/get_safe_spawn_turf()
	var/list/possible_landmarks = list()
	for(var/obj/effect/landmark/quest_spawner/landmark in GLOB.landmarks_list)
		if((quest_difficulty in landmark.quest_difficulty) || (landmark.quest_difficulty in quest_difficulty))
			possible_landmarks += landmark

	if(!length(possible_landmarks))
		possible_landmarks += src
	
	var/obj/effect/landmark/quest_spawner/selected_landmark = pick(possible_landmarks)
	var/list/possible_turfs = list()

	for(var/turf/open/T in view(7, selected_landmark))
		if(!T.density)
			for(var/mob/M in view(9, T))
				if(!M.ckey)
					possible_turfs += T
					break

	return length(possible_turfs) ? pick(possible_turfs) : get_turf(src)

/obj/effect/landmark/quest_spawner/proc/spawn_courier_item(datum/quest/quest, area/delivery_area)
	if(!quest || !delivery_area)
		return null

	// Get the turf where the scroll is located
	var/obj/item/paper/scroll/quest/scroll = quest.quest_scroll_ref?.resolve()
	if(!scroll)
		return null

	var/turf/scroll_turf = get_turf(scroll)
	if(!scroll_turf)
		return null

	var/obj/item/parcel/delivery_parcel = new(scroll_turf)
	var/static/list/area_delivery_items = list(
		/area/provincial/indoors/town/tavern = list(
			/obj/item/cooking/pan,
			/obj/item/reagent_containers/glass/bottle/rogue/beer/aurorian,
			/obj/item/reagent_containers/food/snacks/rogue/cheddar,
		),
		/area/provincial/indoors/town/church = list(
			/obj/item/natural/cloth,
			/obj/item/reagent_containers/powder/ozium,
			/obj/item/reagent_containers/food/snacks/rogue/crackerscooked,
		),
		/area/provincial/indoors/town/farm = list(
			/obj/item/seeds/wheat,
			/obj/item/reagent_containers/food/snacks/egg,
			/obj/item/reagent_containers/food/snacks/egg/mothcat,
		),
		/area/provincial/indoors/town/blacksmith = list(
			/obj/item/ingot/iron,
			/obj/item/ingot/bronze,
			/obj/item/rogueore/coal,
		),
		/area/provincial/indoors/town/shop = list(
			/obj/item/roguecoin/gold,
			/obj/item/clothing/ring/silver,
			/obj/item/scomstone/bad,
		),
		/area/provincial/indoors/town/province_keep = list(
			/obj/item/clothing/cloak/raincloak/furcloak,
			/obj/item/reagent_containers/glass/bottle/rogue/whitewine,
			/obj/item/reagent_containers/food/snacks/rogue/cheddar/aged,
		),
		/area/provincial/indoors/town/mages_university = list(
			/obj/item/book/spellbook,
			/obj/item/roguegem/yellow,
			/obj/item/reagent_containers/glass/bottle/rogue/manapot,
		),
		/area/provincial/indoors/town/mages_university/alchemy_lab = list(
			/obj/item/alch/waterdust,
			/obj/item/alch/viscera,
			/obj/item/alch/seeddust,
		),
		/area/provincial/indoors/town/steward = list(
			/obj/item/clothing/ring/silver,
			/obj/item/reagent_containers/glass/cup/silver,
			/obj/item/reagent_containers/glass/cup/golden,
		),
		/area/provincial/indoors/town = list(
			/obj/item/ration,
		)
	)

	var/list/possible_items = area_delivery_items[delivery_area] || list(
		/obj/item/natural/cloth,
		/obj/item/ration,
		/obj/item/reagent_containers/food/snacks/rogue/crackerscooked,
	)

	var/contained_item_type = pick(possible_items)
	var/obj/item/contained_item = new contained_item_type(delivery_parcel)
	delivery_parcel.contained_item = contained_item
	delivery_parcel.delivery_area_type = delivery_area
	delivery_parcel.allowed_jobs = delivery_parcel.get_area_jobs(delivery_area)
	delivery_parcel.name = "Delivery for [initial(delivery_area.name)]"
	delivery_parcel.desc = "A securely wrapped parcel addressed to [initial(delivery_area.name)]. [pick("Handle with care.", "Do not bend.", "Confidential contents.", "Urgent delivery.")]"
	delivery_parcel.icon_state = contained_item.w_class >= WEIGHT_CLASS_NORMAL ? "ration_large" : "ration_small"
	delivery_parcel.dropshrink = 1
	delivery_parcel.update_icon()

	quest.target_delivery_item = contained_item_type
	delivery_parcel.AddComponent(/datum/component/quest_object, quest)
	contained_item.AddComponent(/datum/component/quest_object, quest)

	return delivery_parcel

/obj/effect/landmark/quest_spawner/proc/spawn_clear_out_mobs(mob_type, amount, datum/quest/quest)
	for(var/i in 1 to amount)
		var/turf/spawn_turf = get_safe_spawn_turf()
		if(!spawn_turf)
			return
		
		var/mob/living/new_mob = new mob_type(spawn_turf)
		new_mob.faction |= "quest"
		new_mob.AddComponent(/datum/component/quest_object, quest)
		add_quest_faction_to_nearby_mobs(spawn_turf)
		sleep(1)

/obj/effect/landmark/quest_spawner/proc/spawn_miniboss(datum/quest/quest)
	var/turf/spawn_turf = get_safe_spawn_turf()
	if(!spawn_turf)
		return

	// Pick a random mob type from the miniboss_mob list
	var/mob_type = pick(miniboss_mob)
	quest.target_mob_type = mob_type // Set the quest's target mob type BEFORE spawning
	quest.target_spawn_area = get_area_name(spawn_turf) // Set the actual spawn area

	var/mob/living/new_mob = new mob_type(spawn_turf)
	new_mob.faction |= "quest"
	new_mob.AddComponent(/datum/component/quest_object, quest)
	add_quest_faction_to_nearby_mobs(spawn_turf)

	// Immediately update the quest scroll if it exists
	if(quest.quest_scroll_ref)
		var/obj/item/paper/scroll/quest/scroll = quest.quest_scroll_ref.resolve()
		if(scroll)
			scroll.update_quest_text()

/obj/effect/landmark/quest_spawner/easy
	name = "easy quest landmark"
	icon_state = "quest_marker_low"
	quest_difficulty = "Easy"
	quest_type = list("Fetch", "Courier", "Kill", "Beacon")

/obj/effect/landmark/quest_spawner/medium
	name = "medium quest landmark"
	icon_state = "quest_marker_mid"
	quest_difficulty = "Medium"
	quest_type = list("Kill", "Clear Out", "Beacon")

/obj/effect/landmark/quest_spawner/hard
	name = "hard quest landmark"
	icon_state = "quest_marker_high"
	quest_difficulty = "Hard"
	quest_type = list("Clear Out", "Beacon", "Miniboss")
