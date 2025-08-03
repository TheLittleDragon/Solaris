/obj/effect/spawner/lootdrop/roguetown/miningtunnels
	name = "sewer spawner"
	loot = list()
	lootcount = 0

///////////////////////
/// Southern Road   ///
/// Size: X:10 Y:10 ///
///////////////////////

/obj/effect/landmark/map_load_mark/south_mine_road
	name = "South Mines Road"
	templates = list("south_mine_road_1", "south_mine_road_2", "south_mine_road_3")

/// just corpses
/datum/map_template/south_mine_road_1
	name = "South Mines Road Variant 1"
	id = "south_mine_road_1"
	mappath = "_maps/map_files/templates/mining/south_mine_01.dmm"

///  skeletons
/datum/map_template/south_mine_road_2
	name = "South Mines Road Variant 2"
	id = "south_mine_road_2"
	mappath = "_maps/map_files/templates/mining/south_mine_02.dmm"

/// big rats
/datum/map_template/south_mine_road_3
	name = "South Mines Road Variant 3"
	id = "south_mine_road_3"
	mappath = "_maps/map_files/templates/mining/south_mine_03.dmm"
