/datum/map_template
	var/name = "Default Template Name"
	var/id = null //The internal ID of a template, so we don't need to use name
	var/width = 0
	var/height = 0
	var/mappath = null
	var/loaded = 0 // Times loaded this round
	var/datum/parsed_map/cached_map
	var/keep_cached_map = FALSE

	///if true, turfs loaded from this template are placed on top of the turfs already there, defaults to TRUE
	var/should_place_on_top = TRUE

	/// How many z-levels does this template affect (not counting the ceiling if it has one)? 
	var/z_level_count = 1

	///If true, any openspace turfs above the template will be replaced with ceiling_turf when loading. Should probably be FALSE for lower levels of multi-z ruins.
	var/has_ceiling = FALSE
	///What turf to replace openspace with when has_ceiling is true
	var/turf/ceiling_turf = /turf/open/floor/rogue/rooftop
	///What baseturfs to set when replacing openspace when has_ceiling is true
	var/list/ceiling_baseturfs = list()

/datum/map_template/New(path = null, rename = null, cache = FALSE)
	if(path && !mappath)
		mappath = path
	if(!path && mappath)
		path = mappath
	if(mappath)
		preload_size(mappath, cache)
	if(rename)
		name = rename
	if(!name && id) //Make sure nothing is null, just in case
		name = id
	if(!id && name)
		id = name
	ceiling_baseturfs.Insert(1, /turf/baseturf_bottom)

/datum/map_template/proc/preload_size(path, cache = FALSE)
	var/datum/parsed_map/parsed = new(file(path))
	var/bounds = parsed?.bounds
	if(bounds)
		width = bounds[MAP_MAXX] // Assumes all templates are rectangular, have a single Z level, and begin at 1,1,1
		height = bounds[MAP_MAXY]
		if(cache)
			cached_map = parsed
	return bounds

/datum/parsed_map/proc/initTemplateBounds()
	var/list/atom/atoms = list()
	var/list/area/areas = list()

	var/list/turfs = block(	locate(bounds[MAP_MINX], bounds[MAP_MINY], bounds[MAP_MINZ]),
							locate(bounds[MAP_MAXX], bounds[MAP_MAXY], bounds[MAP_MAXZ]))
	var/list/border = block(locate(max(bounds[MAP_MINX]-1, 1),			max(bounds[MAP_MINY]-1, 1),			 bounds[MAP_MINZ]),
							locate(min(bounds[MAP_MAXX]+1, world.maxx),	min(bounds[MAP_MAXY]+1, world.maxy), bounds[MAP_MAXZ])) - turfs
	for(var/L in turfs)
		var/turf/B = L
		atoms += B
		areas |= B.loc
		for(var/A in B)
			atoms += A
	for(var/L in border)
		var/turf/T = L
		T.air_update_turf(TRUE) //calculate adjacent turfs along the border to prevent runtimes

	SSmapping.reg_in_areas_in_z(areas)
	SSatoms.InitializeAtoms(atoms)

/datum/map_template/proc/load_new_z()
	var/x = round((world.maxx - width)/2)
	var/y = round((world.maxy - height)/2)

	var/datum/space_level/level = SSmapping.add_new_zlevel(name, list(ZTRAIT_AWAY = TRUE))
	var/datum/parsed_map/parsed = load_map(
		file(mappath),
		x,
		y,
		level.z_value,
		no_changeturf = (SSatoms.initialized == INITIALIZATION_INSSATOMS),
		place_on_top = TRUE
	)
	var/list/bounds = parsed.bounds
	if(!bounds)
		return FALSE

	repopulate_sorted_areas()

	//initialize things that are normally initialized after map load
	parsed.initTemplateBounds()
	smooth_zlevel(world.maxz)
	log_game("Z-level [name] loaded at [x],[y],[world.maxz]")

	return level

/datum/map_template/proc/load(turf/T, centered = FALSE)
	if(centered)
		T = locate(T.x - round(width/2) , T.y - round(height/2) , T.z)
	if(!T)
		return
	if(T.x+width > world.maxx)
		return
	if(T.y+height > world.maxy)
		return

	var/list/border = block(locate(max(T.x-1, 1),			max(T.y-1, 1),			 T.z),
							locate(min(T.x+width+1, world.maxx),	min(T.y+height+1, world.maxy), T.z))
	for(var/L in border)
		var/turf/turf_to_disable = L
		turf_to_disable.atmos_adjacent_turfs?.Cut()

	// Accept cached maps, but don't save them automatically - we don't want
	// ruins clogging up memory for the whole round.
	var/datum/parsed_map/parsed = cached_map || new(file(mappath))
	cached_map = keep_cached_map ? parsed : null
	if(!parsed.load(T.x, T.y, T.z, crop_map =TRUE, no_changeturf=(SSatoms.initialized == INITIALIZATION_INSSATOMS), place_on_top = TRUE))
		return
	var/list/bounds = parsed.bounds
	if(!bounds)
		return

	repopulate_sorted_areas()

	//initialize things that are normally initialized after map load
	parsed.initTemplateBounds()

	if(has_ceiling)
		var/affected_turfs = get_affected_turfs(T, FALSE)
		generate_ceiling(affected_turfs)

	log_game("[name] loaded at [T.x],[T.y],[T.z]")
	return bounds

/datum/map_template/proc/generate_ceiling(affected_turfs)
	for (var/turf/turf in affected_turfs)
		var/turf/ceiling = get_step_multiz(turf, UP)
		if (ceiling)
			if (istype(ceiling, /turf/open/transparent/openspace) && !istype(ceiling, /turf/open/transparent/openspace/inside))
				ceiling.ChangeTurf(ceiling_turf, ceiling_baseturfs, CHANGETURF_INHERIT_AIR)

/datum/map_template/proc/get_affected_turfs(turf/T, centered = FALSE)
	var/turf/placement = T
	if(centered)
		var/turf/corner = locate(placement.x - round(width/2), placement.y - round(height/2), placement.z)
		if(corner)
			placement = corner
	return block(placement, locate(placement.x+width-1, placement.y+height-1, placement.z + (z_level_count - 1)))

/// Returns the amount of z-levels that are affected by this template, based on whether it has a
/// ceiling or not. Not included in z_level_count so that it's agnostic from ceilings being a thing.
/datum/map_template/proc/get_affected_z_level_count()
	return has_ceiling ? z_level_count + 1 : z_level_count

//for your ever biggening badminnery kevinz000
//❤ - Cyberboss
/proc/load_new_z_level(file, name)
	var/datum/map_template/template = new(file, name)
	template.load_new_z()
