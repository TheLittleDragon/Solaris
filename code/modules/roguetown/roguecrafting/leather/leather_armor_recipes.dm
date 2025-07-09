/datum/crafting_recipe/roguetown/leather/armor
	abstract_type = /datum/crafting_recipe/roguetown/leather/armor
	category = "Armor"


/datum/crafting_recipe/roguetown/leather/armor/lgorget
	name = "hardened leather gorget (1 fibers, 1 leather)"
	result = /obj/item/clothing/neck/roguetown/leather
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/leather/armor/heavybracers
	name = "hardened leather bracers (1 fibers, 2 leather)"
	result = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/leather/armor/bracers
	name = "leather bracers (1 leather)"
	result = list(/obj/item/clothing/wrists/roguetown/bracers/leather,
			/obj/item/clothing/wrists/roguetown/bracers/leather)
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/armor/pants
	name = "leather pants (2 leather)"
	result = list(/obj/item/clothing/under/roguetown/trou/leather)
	reqs = list(/obj/item/natural/hide/cured = 2)
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/armor/wolfhelm
	name = "wolf helm (1 leather, 1 fur, 1 wolf head)"
	result = list(/obj/item/clothing/head/roguetown/helmet/leather/wolfhelm)
	reqs = list(/obj/item/natural/hide/cured = 1, /obj/item/natural/fur = 2, /obj/item/natural/head/wolf = 1)
	sellprice = 20

/datum/crafting_recipe/roguetown/leather/armor/wolfmantle
	name = "wolf mantle (2 leather, 1 wolf head)"
	result = /obj/item/clothing/cloak/wolfmantle
	reqs = list(
		/obj/item/natural/hide/cured = 2,
		/obj/item/natural/head/wolf = 1,
	)
	craftdiff = 2

/datum/crafting_recipe/roguetown/leather/armor/heavy_leather_pants
	name = "hardened leather pants (1 fibers, 3 leather, 1 tallow)"
	result = list(/obj/item/clothing/under/roguetown/heavy_leather_pants)
	reqs = list(
		/obj/item/natural/hide/cured = 3,
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 1,
		)
	sellprice = 20
	craftdiff = 3

/datum/crafting_recipe/roguetown/leather/armor/heavy_leather_pants/shorts
	name = "hardened leather shorts (1 fibers, 2 leather, 1 tallow)"
	result = list(/obj/item/clothing/under/roguetown/heavy_leather_pants/shorts)
	reqs = list(
		/obj/item/natural/hide/cured = 1, //they cover less, you see
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 1,
		)
	sellprice = 20


/datum/crafting_recipe/roguetown/leather/armor/helmet
	name = "leather helmet (1 leather)"
	result = /obj/item/clothing/head/roguetown/helmet/leather
	reqs = list(/obj/item/natural/hide/cured = 1)
	sellprice = 27

/datum/crafting_recipe/roguetown/leather/armor/helmet/advanced
	name = "hardened leather helmet (1 fibers, 1 leather, 1 tallow)"
	result = /obj/item/clothing/head/roguetown/helmet/leather/advanced
	reqs = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/reagent_containers/food/snacks/tallow = 1)
	craftdiff = 4
	sellprice = 40

	
/datum/crafting_recipe/roguetown/leather/armor/armor
	name = "leather armor (2 leather)"
	result = /obj/item/clothing/suit/roguetown/armor/leather
	reqs = list(/obj/item/natural/hide/cured = 2)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/armor/cuirass
	name = "leather cuirass"
	name = "leather armor (2 leather)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/cuirass
	reqs = list(/obj/item/natural/hide/cured = 2)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/armor/bikini
	name = "leather bikini armor (2 leather)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/bikini
	reqs = list(/obj/item/natural/hide/cured = 2)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/armor/hidearmor
	name = "hide armor (2 leather, 1 fur)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/hide
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1)
	sellprice = 26
	craftdiff = 1

/datum/crafting_recipe/roguetown/leather/armor/heavy_leather_armor
	name = "hardened leather armor (1 fibers, 2 leather, 1 tallow)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/heavy
	reqs = list(
		/obj/item/natural/hide/cured = 2,
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 1,
		)
	sellprice = 26
	craftdiff = 3

/datum/crafting_recipe/roguetown/leather/armor/heavy_leather_armor/coat
	name = "hardened leather coat (1 fibers, 3 leather, 1 tallow)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	reqs = list(
		/obj/item/natural/hide/cured = 3,
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 1,
		)
	sellprice = 36
	craftdiff = 4

/datum/crafting_recipe/roguetown/leather/armor/heavy_leather_armor/jacket
	name = "hardened leather jacket (1 fibers, 3 leather, 1 tallow)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/heavy/jacket
	reqs = list(
		/obj/item/natural/hide/cured = 3,
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/natural/fibers = 1,
		)
	sellprice = 36
	craftdiff = 4

/datum/crafting_recipe/roguetown/leather/armor/hidebikini
	name = "hide bikini armor (2 leather, 1 tallow)"
	result = /obj/item/clothing/suit/roguetown/armor/leather/hide/bikini
	reqs = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fur = 1)
	sellprice = 26

/datum/crafting_recipe/roguetown/leather/armor/carapacecuirass
	name = "carapace cuirass"
	result = list(/obj/item/clothing/suit/roguetown/armor/carapace/cuirass)
	reqs = list(/obj/item/natural/carapace = 2,
				/obj/item/natural/fibers = 4)
	craftdiff = 3
	sellprice = 22

/datum/crafting_recipe/roguetown/leather/armor/carapacearmor
	name = "carapace armor"
	result = list(/obj/item/clothing/suit/roguetown/armor/carapace)
	reqs = list(/obj/item/natural/carapace = 4,
				/obj/item/natural/fibers = 6)
	craftdiff = 3
	sellprice = 42

/datum/crafting_recipe/roguetown/leather/armor/carapacelegs
	name = "carapace chausses"
	result = list(/obj/item/clothing/under/roguetown/carapacelegs)
	reqs = list(/obj/item/natural/carapace = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 3
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/armor/carapaceskirt
	name = "carapace skirt"
	result = list(/obj/item/clothing/under/roguetown/carapacelegs/skirt)
	reqs = list(/obj/item/natural/carapace = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 3
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/armor/carapacecap
	name = "carapace cap"
	result = list(/obj/item/clothing/head/roguetown/helmet/carapacecap)
	reqs = list(/obj/item/natural/carapace = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 3
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/armor/carapacehelm
	name = "carapace helmet"
	result = list(/obj/item/clothing/head/roguetown/helmet/carapacehelm)
	reqs = list(/obj/item/natural/carapace = 2,
				/obj/item/natural/fibers = 4)
	craftdiff = 3
	sellprice = 22

/datum/crafting_recipe/roguetown/leather/armor/carapaceboots
	name = "carapace boots"
	result = list(/obj/item/clothing/shoes/roguetown/boots/carapace)
	reqs = list(/obj/item/natural/carapace = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 3
	sellprice = 20

/datum/crafting_recipe/roguetown/leather/armor/carapacegloves
	name = "carapace gauntlets"
	result = list(/obj/item/clothing/gloves/roguetown/carapace)
	reqs = list(/obj/item/natural/carapace = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 3
	sellprice = 20

/datum/crafting_recipe/roguetown/leather/armor/carapacebracers
	name = "carapace bracers"
	result = list(/obj/item/clothing/wrists/roguetown/bracers/carapace)
	reqs = list(/obj/item/natural/carapace = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 3
	sellprice = 20

/datum/crafting_recipe/roguetown/leather/armor/carapacecuirass/dragon
	name = "dragon cuirass"
	result = list(/obj/item/clothing/suit/roguetown/armor/carapace/dragon/cuirass)
	reqs = list(/obj/item/natural/carapace/dragon = 2,
				/obj/item/natural/fibers = 4)
	craftdiff = 6
	sellprice = 22

/datum/crafting_recipe/roguetown/leather/armor/carapacearmor/dragon
	name = "dragon armor"
	result = list(/obj/item/clothing/suit/roguetown/armor/carapace/dragon)
	reqs = list(/obj/item/natural/carapace/dragon = 4,
				/obj/item/natural/fibers = 6)
	craftdiff = 6
	sellprice = 42

/datum/crafting_recipe/roguetown/leather/armor/carapacelegs/dragon
	name = "dragon chausses"
	result = list(/obj/item/clothing/under/roguetown/carapacelegs/dragon)
	reqs = list(/obj/item/natural/carapace/dragon = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 6
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/armor/carapaceskirt/dragon
	name = "dragon skirt"
	result = list(/obj/item/clothing/under/roguetown/carapacelegs/dragon/skirt)
	reqs = list(/obj/item/natural/carapace/dragon = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 6
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/armor/carapacecap/dragon
	name = "dragon cap"
	result = list(/obj/item/clothing/head/roguetown/helmet/carapacecap/dragon)
	reqs = list(/obj/item/natural/carapace/dragon = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 6
	sellprice = 10

/datum/crafting_recipe/roguetown/leather/armor/carapacehelm/dragon
	name = "dragon helmet"
	result = list(/obj/item/clothing/head/roguetown/helmet/carapacehelm/dragon)
	reqs = list(/obj/item/natural/dragon_head = 1,
				/obj/item/natural/fibers = 4)
	craftdiff = 6
	sellprice = 22

/datum/crafting_recipe/roguetown/leather/armor/carapaceboots/dragon
	name = "dragon boots"
	result = list(/obj/item/clothing/shoes/roguetown/boots/carapace/dragon)
	reqs = list(/obj/item/natural/carapace/dragon = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 6
	sellprice = 20

/datum/crafting_recipe/roguetown/leather/armor/carapacegloves/dragon
	name = "dragon gauntlets"
	result = list(/obj/item/clothing/gloves/roguetown/carapace/dragon)
	reqs = list(/obj/item/natural/carapace/dragon = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 6
	sellprice = 20

/datum/crafting_recipe/roguetown/leather/armor/carapacebracers/dragon
	name = "dragon bracers"
	result = list(/obj/item/clothing/wrists/roguetown/bracers/carapace/dragon)
	reqs = list(/obj/item/natural/carapace/dragon = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 6
	sellprice = 20
