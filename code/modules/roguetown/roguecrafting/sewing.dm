/datum/crafting_recipe/roguetown/sewing
	abstract_type = /datum/crafting_recipe/roguetown/sewing
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing

/* craftdif of 0 */

/datum/crafting_recipe/roguetown/sewing/headband
	name = "headband (1 cloth)"
	result = list(/obj/item/clothing/head/roguetown/headband)
	reqs = list(/obj/item/natural/cloth = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/sewing/peasantcap
	name = "peasant cap (1 cloth)"
	result = list(/obj/item/clothing/head/roguetown/armingcap)
	reqs = list(/obj/item/natural/cloth = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/sewing/apron_waist
	name = "waist apron (3 cloth)"
	result = list(/obj/item/clothing/cloak/apron/waist)
	reqs = list(/obj/item/natural/cloth = 3) // 3 because it thas a storage, but it really just a apron.
	craftdiff = 0

/datum/crafting_recipe/roguetown/sewing/apron/blacksmith
	name = "leather apron (2 cloth, 1 leather)"
	result = list(/obj/item/clothing/cloak/apron/blacksmith)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/hide/cured = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/sewing/rags
	name = "rags (2 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/rags)
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 0

/datum/crafting_recipe/roguetown/sewing/burial_shroud
	name = "winding sheet (2 cloth)"
	result = list(/obj/item/burial_shroud)
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/loincloth
	name = "loincloth (1 cloth)"
	result = list(/obj/item/clothing/under/roguetown/loincloth)
	reqs = list(/obj/item/natural/cloth = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/sewing/brownloincloth
	name = "brown loincloth (1 cloth)"
	result = list(/obj/item/clothing/under/roguetown/loincloth/brown)
	reqs = list(/obj/item/natural/cloth = 1)
	craftdiff = 0


/datum/crafting_recipe/roguetown/sewing/linedanklet
	name = "cloth anklet (2 fibers, 2 cloth)"
	result = list(/obj/item/clothing/shoes/roguetown/boots/clothlinedanklets)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 0

/* craftdif of 1 */

/datum/crafting_recipe/roguetown/sewing/clothgloves
	name = "cloth gloves (1 fibers, 1 cloth)"
	result = list(/obj/item/clothing/gloves/roguetown/fingerless)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/brimmed
	name = "brimmed hat (2 fibers, 1 cloth)"
	result = list(/obj/item/clothing/head/roguetown/brimmed)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/tunic
	name = "tunic (2 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/tunic/white)
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/lowcut_shirt
	name = "low cut tunic (1 fibers, 2 cloth)"
	reqs = list(
		/obj/item/natural/cloth = 2,
		/obj/item/natural/fibers = 1,
	)
	result = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut

/datum/crafting_recipe/roguetown/sewing/noblecoat
	name = "fancy coat (1 silk)"
	result = /obj/item/clothing/suit/roguetown/shirt/tunic/noblecoat
	reqs = list(/obj/item/natural/cloth = 3,
			/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/shadowshirt
	name = "silk shirt (2 cloth, 3 silk)"
	result = /obj/item/clothing/suit/roguetown/shirt/shadowshirt
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 3)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/clothshirt
	name = "cloth shirt (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/undershirt)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/clothtrou
	name = "cloth trousers (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/under/roguetown/trou)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/longcoat
	name = "longcoat (2 fibers, 2 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/armor/longcoat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/workervest
	name = "striped tunic (2 fibers, 2 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/armor/workervest)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/tights
	name = "tights (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/under/roguetown/tights/random)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/Reyepatch
	name = "right eye patch (1 fibers, 1 cloth)"
	result = list(/obj/item/clothing/mask/rogue/eyepatch)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/Leyepatch
	name = "left eye patch (1 fibers, 1 cloth)"
	result = list(/obj/item/clothing/mask/rogue/eyepatch/left)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/knitcap
	name = "knit cap (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/knitcap)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/strawhat
	name = "straw hat (3 fibers)"
	result = list(/obj/item/clothing/head/roguetown/strawhat)
	reqs = list(/obj/item/natural/fibers = 3)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/sack
	name = "sack hood (3 cloth)"
	result = list(/obj/item/clothing/head/roguetown/menacing)
	reqs = list(/obj/item/natural/cloth = 3,)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/basichood
	name = "hood (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/roguehood)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/lgambeson
    name = "light gambeson (1 fibers, 2 cloth)"
    result = list(/obj/item/clothing/suit/roguetown/armor/gambeson/light)
    reqs = list(/obj/item/natural/cloth = 2,
                /obj/item/natural/fibers = 1)
    craftdiff = 1

/* craftdif of 2+ */

/datum/crafting_recipe/roguetown/sewing/singlebedsheet
	name = "Single Bedsheet (2 cloth)"
	result = list(/obj/item/bedsheet/rogue/cloth)
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/doublebedsheet
	name = "Double Bedsheet (4 cloth)"
	result = list(/obj/item/bedsheet/rogue/double_pelt)
	reqs = list(/obj/item/natural/cloth = 4)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/wrappings
	name = "solar wrappings (2 cloth)"
	result = list(/obj/item/clothing/wrists/roguetown/wrappings)
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/zirawrappings
	name = "moon wrappings (2 cloth)"
	result = list(/obj/item/clothing/wrists/roguetown/zirawrappings)
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/nunveil
	name = "nun veil (1 cloth)"
	result = list(/obj/item/clothing/head/roguetown/nun)
	reqs = list(/obj/item/natural/cloth = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/nunhabit
	name = "nun habit (2 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/nun)
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/tsoridysmask
	name = "death mask (1 fibers, 2 cloth, 1 bone)"
	result = list(/obj/item/clothing/head/roguetown/tsoridysmask)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/bone = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/coif
	name = "coif (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/neck/roguetown/coif)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/tabard
	name = "tabard (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/tabard)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stabard
	name = "surcoat (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/stabard)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/cinellatemplartabard
	name = "tabard, cinellian templar (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/cinellatabard)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/aeternus
	name = "tabard, aeternus (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/templar/aeternus)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/zira
	name = "tabard, zira (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/templar/zira)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/tamari
	name = "tabard, tamari (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/templar/tamari)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/tsoridys
	name = "tabard, tsoridys (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/templar/tsoridys)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/cinella
	name = "tabard, cinella (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/templar/cinella)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/nunos
	name = "tabard, nunos (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/templar/nunos)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/varielle
	name = "tabard, varielle (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/templar/varielle)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/carthus
	name = "tabard, carthus (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/templar/carthus)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/kasmidian
	name = "tabard, kasmidian (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/templar/kasmidian)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stabard/guard
	name = "surcoat, guard"
	result = list(/obj/item/clothing/cloak/stabard/guard)

/datum/crafting_recipe/roguetown/sewing/stabard/bog
	name = "surcoat, bog"
	result = list(/obj/item/clothing/cloak/stabard/bog)

/datum/crafting_recipe/roguetown/sewing/robe
	name = "robes (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/bardress
	name = "bar dress (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/stockdress
	name = "dress (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

//datum/crafting_recipe/roguetown/sewing/Bladress
//	name = "black dress"
//	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/black)
//	reqs = list(/obj/item/natural/cloth = 3,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 4

//datum/crafting_recipe/roguetown/sewing/Bludress
//	name = "blue dress"
//	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/blue)
//	reqs = list(/obj/item/natural/cloth = 3,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 4

//datum/crafting_recipe/roguetown/sewing/Purdress
//	name = "purple dress"
//	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/purple)
//	reqs = list(/obj/item/natural/cloth = 3,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/fancyhat
	name = "fancy hat (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/fancyhat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4
	sellprice = 14

/datum/crafting_recipe/roguetown/sewing/gambeson
	name = "gambeson (1 fibers, 4 cloth)"
	result = /obj/item/clothing/suit/roguetown/armor/gambeson
	reqs = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	tools = list(/obj/item/needle)
	craftdiff = 3
	sellprice = 20

/datum/crafting_recipe/roguetown/sewing/armingjacket
	name = "arming jacket (1 fibers, 4 cloth)"
	result = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	reqs = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	tools = list(/obj/item/needle)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/paddedcap
	name = "padded Cap (5 fibers)"
	result = /obj/item/clothing/head/roguetown/paddedcap
	reqs = list(/obj/item/natural/fibers = 5)
	tools = list(/obj/item/needle)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/bardhat
	name = "bard hat (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/bardhat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4
	sellprice = 14

/datum/crafting_recipe/roguetown/sewing/bucklehat
	name = "buckle hat (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/bucklehat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4
	sellprice = 14

/datum/crafting_recipe/roguetown/sewing/archer
	name = "archer cap (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/archercap)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4
	sellprice = 14

/datum/crafting_recipe/roguetown/sewing/duelist
	name = "duelist hat (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/duelhat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4
	sellprice = 14

/datum/crafting_recipe/roguetown/sewing/witchhat
	name = "witch hat (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/apothecaryhat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4
	sellprice = 14

/datum/crafting_recipe/roguetown/sewing/hgambeson
    name = "padded gambeson (4 fibers, 6 cloth)"
    result = list(/obj/item/clothing/suit/roguetown/armor/gambeson/heavy)
    reqs = list(/obj/item/natural/cloth = 6,
                /obj/item/natural/fibers = 4)
    craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/chaperon
	name = "chaperon hat (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/chaperon)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4
	sellprice = 14

/datum/crafting_recipe/roguetown/sewing/jupon
	name = "jupon (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/stabard/surcoat)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/armordress
	name = "armored dress (1 fibers, 2 cloth, 1 leather)"
	result = list(/obj/item/clothing/suit/roguetown/armor/armordress)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/hide/cured = 1)
	craftdiff = 3
	sellprice = 30

/datum/crafting_recipe/roguetown/sewing/ragmask
	name = "rag mask (1 cloth)"
	result = list(/obj/item/clothing/mask/rogue/ragmask)
	reqs = list(/obj/item/natural/cloth = 1)
	craftdiff = 0
	sellprice = 3

/datum/crafting_recipe/roguetown/sewing/cape
	name = "cape (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/cloak/cape)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	sellprice = 12

/datum/crafting_recipe/roguetown/sewing/sexydress
	name = "sheer dress (3 fibers, 6 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy)
	reqs = list(/obj/item/natural/cloth = 6,
				/obj/item/natural/fibers = 3)
	craftdiff = 5
	sellprice = 20

/datum/crafting_recipe/roguetown/sewing/wizhatblue
	name = "blue wizard hat (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/wizhat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	sellprice = 12

/datum/crafting_recipe/roguetown/sewing/wizhatred
	name = "red wizard hat (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/wizhat/red)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	sellprice = 12

/datum/crafting_recipe/roguetown/sewing/wizhatyellow
	name = "yellow wizard hat (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/wizhat/yellow)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	sellprice = 12

/datum/crafting_recipe/roguetown/sewing/wizhatgreen
	name = "green wizard hat (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/wizhat/green)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	sellprice = 12

/datum/crafting_recipe/roguetown/sewing/wizhatblack
	name = "black wizard hat (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/wizhat/black)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	sellprice = 12

/datum/crafting_recipe/roguetown/sewing/cape/desert
	name = "desert cape (2 fibers, 4 cloth)"
	result = list(/obj/item/clothing/cloak/cape/crusader)
	reqs = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/cape/rider
	name = "rider cloak (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/half/rider)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/cape/half
	name = "half cloak (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/cloak/half)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/undervestments
	name = "undervestments (1 fibers, 3 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/undershirt/priest)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/keffiyeh
	name = "keffiyeh (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/roguehood/shalal)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/hijab
	name = "hijab (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/roguehood/shalal/hijab)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/heavyhood
	name = "heavy hood (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/roguehood/shalal/heavyhood)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/royalgown
	name = "royal gown (2 fibers, 3 cloth, 3 silk)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/royal)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 3)
	tools = list(/obj/item/needle)
	craftdiff = 6
	sellprice = 45

/datum/crafting_recipe/roguetown/sewing/royaldress
	name = "royal dress (2 fibers, 3 cloth, 2 silk)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/royal/noblewoman)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 2)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 30

/datum/crafting_recipe/roguetown/sewing/royalshirt
	name = "royal shirt (2 fibers, 3 cloth, 2 silk)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/royal/nobleman)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 2)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 30

/datum/crafting_recipe/roguetown/sewing/regalrobes
	name = "regal robes (2 fibers, 2 cloth, 2 silk)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/vampire)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 2)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 30

/datum/crafting_recipe/roguetown/sewing/silktunic
	name = "ornate silk tunic (2 fibers, 2 cloth, 2 silk)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/tunic/silktunic)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 2)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 25
	
/datum/crafting_recipe/roguetown/sewing/silkdress
	name = "ornate silk dress (2 fibers, 2 cloth, 2 silk)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/silkdress/steward)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 2)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 30

/datum/crafting_recipe/roguetown/sewing/archivist
	name = "voluminous robes (2 fibers, 2 cloth, 1 silk)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/archivist)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 1)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 25

/datum/crafting_recipe/roguetown/sewing/apothshirt
	name = "knitted sweater (2 fibers, 3 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/apothshirt)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	craftdiff = 4
	sellprice = 15

/datum/crafting_recipe/roguetown/sewing/artificer
	name = "shirt and doublet (2 fibers, 3 cloth, 1 leather)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/undershirt/artificer)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/hide/cured = 1)
	tools = list(/obj/item/needle)
	craftdiff = 4
	sellprice = 20

/datum/crafting_recipe/roguetown/sewing/winterdress
	name = "winter dress (2 fibers, 4 cloth, 2 silk)"
	result = list(/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/winterdress)
	reqs = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 2)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 25

/datum/crafting_recipe/roguetown/sewing/skirt
	name = "skirt (2 fibers, 1 cloth)"
	result = list(/obj/item/clothing/under/roguetown/skirt)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	craftdiff = 4
	sellprice = 10

/datum/crafting_recipe/roguetown/sewing/clothshorts
	name = "cloth shorts (1 fibers, 1 cloth)"
	result = list(/obj/item/clothing/under/roguetown/tights/sailor)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	tools = list(/obj/item/needle)
	craftdiff = 3
	sellprice = 5

/datum/crafting_recipe/roguetown/sewing/shadowpants
	name = "silk pants (2 fibers, 2 cloth)"
	result = list(/obj/item/clothing/under/roguetown/trou/shadowpants)
	reqs = list(/obj/item/natural/cloth = 2,
	            /obj/item/natural/silk = 2)
	tools = list(/obj/item/needle)
	craftdiff = 4
	sellprice = 18

/datum/crafting_recipe/roguetown/sewing/apothpants
	name = "knitted pants (2 fibers, 2 cloth)"
	result = list(/obj/item/clothing/under/roguetown/trou/apothecary)
	reqs = list(/obj/item/natural/cloth = 2,
	            /obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	craftdiff = 4
	sellprice = 14

/datum/crafting_recipe/roguetown/sewing/royalsleeves
	name = "royal sleeves (2 fibers, 1 cloth, 1 silk)"
	result = list(/obj/item/clothing/wrists/roguetown/royalsleeves)
	reqs = list(/obj/item/natural/cloth = 1,
	            /obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 1)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 19

/datum/crafting_recipe/roguetown/sewing/nemes
	name = "nemes (2 fibers, 2 cloth)"
	result = list(/obj/item/clothing/head/roguetown/headdress)
	reqs = list(/obj/item/natural/cloth = 2,
	            /obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	craftdiff = 4
	sellprice = 10

/datum/crafting_recipe/roguetown/sewing/hatfur
	name = "fur hat (1 fibers, 1 cloth, 1 fur)"
	result = list(/obj/item/clothing/head/roguetown/hatfur)
	reqs = list(/obj/item/natural/cloth = 1,
	            /obj/item/natural/fibers = 1,
				/obj/item/natural/fur = 1)
	tools = list(/obj/item/needle)
	craftdiff = 3
	sellprice = 14

/datum/crafting_recipe/roguetown/sewing/shawl
	name = "shawl (1 cloth)"
	result = list(/obj/item/clothing/head/roguetown/shawl)
	reqs = list(/obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle)
	craftdiff = 2
	sellprice = 5

/datum/crafting_recipe/roguetown/sewing/articap
	name = "flat cap (1 fibers, 1 cloth, 1 silk)"
	result = list(/obj/item/clothing/head/roguetown/articap)
	reqs = list(/obj/item/natural/cloth = 1,
	            /obj/item/natural/fibers = 1,
				/obj/item/natural/hide/cured = 1)
	tools = list(/obj/item/needle)
	craftdiff = 4
	sellprice = 14

/datum/crafting_recipe/roguetown/sewing/lordlycloak
	name = "royal cloak (2 fibers, 3 cloth, 2 silk, 2 fur)"
	result = list(/obj/item/clothing/cloak/lordcloak)
	reqs = list(/obj/item/natural/cloth = 3,
	            /obj/item/natural/fibers = 2,
				/obj/item/natural/fur = 2,
				/obj/item/natural/silk = 2)
	tools = list(/obj/item/needle)
	craftdiff = 6
	sellprice = 35

/datum/crafting_recipe/roguetown/sewing/ladycloak
	name = "royal half-cloak (2 fibers, 2 cloth, 2 silk, 1 fur)"
	result = list(/obj/item/clothing/cloak/lordcloak/ladycloak)
	reqs = list(/obj/item/natural/cloth = 2,
	            /obj/item/natural/fibers = 2,
			    /obj/item/natural/silk = 2,
				/obj/item/natural/fur = 1)
	tools = list(/obj/item/needle)
	craftdiff = 6
	sellprice = 30

/datum/crafting_recipe/roguetown/sewing/furovercoat
	name = "fur overcoat (1 fibers, 3 cloth, 1 silk, 1 fur)"
	result = list(/obj/item/clothing/cloak/black_cloak)
	reqs = list(/obj/item/natural/cloth = 3,
	            /obj/item/natural/fibers = 1,
				/obj/item/natural/silk = 1,
				/obj/item/natural/fur = 1)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 22
	
/datum/crafting_recipe/roguetown/sewing/sleevelessovercoat
	name = "sleeveless overcoat (2 fibers, 3 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/armor/leather/vest/hand)
	reqs = list(/obj/item/natural/cloth = 3,
	            /obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	craftdiff = 4
	sellprice = 16

/datum/crafting_recipe/roguetown/sewing/guildedjacket
	name = "guilded jacket (2 fibers, 3 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/merchant)
	reqs = list(/obj/item/natural/cloth = 3,
	            /obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 19

/datum/crafting_recipe/roguetown/sewing/buttonedlongcoat
	name = "buttoned longcoat (2 fibers, 3 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/deacon)
	reqs = list(/obj/item/natural/cloth = 3,
	            /obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 20

/datum/crafting_recipe/roguetown/sewing/desertgown
	name = "desert gown (2 fibers, 3 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/hierophant)
	reqs = list(/obj/item/natural/cloth = 3,
	            /obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	craftdiff = 4
	sellprice = 17

/datum/crafting_recipe/roguetown/sewing/monkrobe
	name = "monk robe (2 fibers, 2 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/pointfex)
	reqs = list(/obj/item/natural/cloth = 2,
	            /obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	craftdiff = 4
	sellprice = 15

/datum/crafting_recipe/roguetown/sewing/fencergambeson
	name = "fencer gambeson (5 fibers, 6 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/armor/gambeson/fencer)
	reqs = list(/obj/item/natural/cloth = 6,
	            /obj/item/natural/fibers = 5)
	tools = list(/obj/item/needle)
	craftdiff = 6
	sellprice = 24

/datum/crafting_recipe/roguetown/sewing/sleevelessrobe
	name = "sleeveless robe (2 fibers, 3 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/phys)
	reqs = list(/obj/item/natural/cloth = 3,
	            /obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	craftdiff = 4
	sellprice = 13
	
/datum/crafting_recipe/roguetown/sewing/weddingdress
	name = "wedding silk dress (2 fibers, 3 cloth, 2 silk, 2 gold dust)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/silkdress/weddingdress)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 2,
				/obj/item/alch/golddust = 1)
	tools = list(/obj/item/needle)
	craftdiff = 5
	sellprice = 40

/datum/crafting_recipe/roguetown/sewing/silkydress
	name = "silky dress (3 fibers, 6 cloth)"
	result = /obj/item/clothing/suit/roguetown/shirt/dress/silkydress
	reqs = list(/obj/item/natural/cloth = 6,
				/obj/item/natural/fibers = 3)
	tools = list(/obj/item/needle)
	craftdiff = 6
	sellprice = 50

/datum/crafting_recipe/roguetown/sewing/weaving/springgown
	name = "gown (spring) (3 cloth, 4 silk)"
	result = /obj/item/clothing/suit/roguetown/shirt/dress/gown
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 4)
	craftdiff = 6
	sellprice = 85

/datum/crafting_recipe/roguetown/sewing/weaving/summergown
	name = "gown (summer) (2 fibers, 1 cloth, 3 silk)"
	result = /obj/item/clothing/suit/roguetown/shirt/dress/gown/summergown
	reqs = list(/obj/item/natural/fibers = 2,
				/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 3)
	craftdiff = 6
	sellprice = 70

/datum/crafting_recipe/roguetown/sewing/weaving/fallgown
	name = "gown (fall, silk) (3 fibers, 2 cloth, 2 silk)"
	result = /obj/item/clothing/suit/roguetown/shirt/dress/gown/fallgown
	reqs = list(/obj/item/natural/fibers = 3,
				/obj/item/natural/silk = 2,
				/obj/item/natural/cloth = 2)
	craftdiff = 6
	sellprice = 75

/datum/crafting_recipe/roguetown/sewing/weaving/wintergown
	name = "gown (winter) (3 fibers, 2 silk, 1 fur)"
	result = /obj/item/clothing/suit/roguetown/shirt/dress/gown/wintergown
	reqs = list(/obj/item/natural/fibers = 3,
				/obj/item/natural/silk = 2,
				/obj/item/natural/fur = 1)
	craftdiff = 6
	sellprice = 90

/datum/crafting_recipe/roguetown/sewing/exoticsilkbra
	name = "exotic silk bra (3 silk, 1 gold ring)"
	result = list (/obj/item/clothing/suit/roguetown/shirt/exoticsilkbra)
	reqs = list(/obj/item/natural/silk = 3,
				/obj/item/clothing/ring/gold = 1)
	craftdiff = 6

/datum/crafting_recipe/roguetown/sewing/anklets
	name = "exotic silk anklets (3 silk, 1 gold ring)"
	result = list (/obj/item/clothing/shoes/roguetown/anklets)
	reqs = list(/obj/item/natural/silk = 3,
				/obj/item/clothing/ring/gold = 1)
	craftdiff = 6

/datum/crafting_recipe/roguetown/sewing/exoticsilkbelt
	name = "exotic silk belt (3 silk, 1 gold ring)"
	result = list (/obj/item/storage/belt/rogue/leather/exoticsilkbelt)
	reqs = list(/obj/item/natural/silk = 3,
				/obj/item/clothing/ring/gold = 1)
	craftdiff = 6

/datum/crafting_recipe/roguetown/sewing/exoticsilkmask
	name = "exotic silk mask (3 silk, 1 gold ring)"
	result = list (/obj/item/clothing/mask/rogue/exoticsilkmask)
	reqs = list(/obj/item/natural/silk = 3,
				/obj/item/clothing/ring/gold = 1)
	craftdiff = 6

/datum/crafting_recipe/roguetown/sewing/stockings_white
	name = "stockings (1 fibers, 1 cloth)"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/white)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

//datum/crafting_recipe/roguetown/sewing/stockings_black
//	name = "black stockings (1 fibers, 1 cloth)"
//	result = list(/obj/item/clothing/under/roguetown/tights/stockings/black)
//	reqs = list(/obj/item/natural/cloth = 1,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 3

//datum/crafting_recipe/roguetown/sewing/stockings_blue
//	name = "blue stockings (1 fibers, 1 cloth)"
//	result = list(/obj/item/clothing/under/roguetown/tights/stockings/blue)
//	reqs = list(/obj/item/natural/cloth = 1,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 3

//datum/crafting_recipe/roguetown/sewing/stockings_red
//	name = "red stockings (1 fibers, 1 cloth)"
//	result = list(/obj/item/clothing/under/roguetown/tights/stockings/red)
//	reqs = list(/obj/item/natural/cloth = 1,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 3

///datum/crafting_recipe/roguetown/sewing/stockings_purple
//	name = "purple stockings (1 fibers, 1 cloth)"
//	result = list(/obj/item/clothing/under/roguetown/tights/stockings/purple)
//	reqs = list(/obj/item/natural/cloth = 1,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/stockings_white_silk
	name = "silk stockings (1 fibers, 1 silk)"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/silk/white)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5

//datum/crafting_recipe/roguetown/sewing/stockings_black_silk
//	name = "black silk stockings (1 fibers, 1 silk)"
//	result = list(/obj/item/clothing/under/roguetown/tights/stockings/silk/black)
//	reqs = list(/obj/item/natural/silk = 1,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 5

//datum/crafting_recipe/roguetown/sewing/stockings_blue_silk
//	name = "blue silk stockings (1 fibers, 1 silk)"
//	result = list(/obj/item/clothing/under/roguetown/tights/stockings/silk/blue)
//	reqs = list(/obj/item/natural/silk = 1,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 5

//datum/crafting_recipe/roguetown/sewing/stockings_red_silk
//	name = "red silk stockings (1 fibers, 1 silk)"
//	result = list(/obj/item/clothing/under/roguetown/tights/stockings/silk/red)
//	reqs = list(/obj/item/natural/silk = 1,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 5

//datum/crafting_recipe/roguetown/sewing/stockings_purple_silk
//	name = "purple silk stockings (1 fibers, 1 silk)"
//	result = list(/obj/item/clothing/under/roguetown/tights/stockings/silk/purple)
//	reqs = list(/obj/item/natural/silk = 1,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 5

/datum/crafting_recipe/roguetown/sewing/stockings_white_fishnet
	name = "fishnet stockings (2 fibers)"
	result = list(/obj/item/clothing/under/roguetown/tights/stockings/fishnet/white)
	reqs = list(/obj/item/natural/fibers = 2)
	craftdiff = 3

//datum/crafting_recipe/roguetown/sewing/stockings_black_fishnet
//	name = "black fishnet stockings (2 fibers)"
//	result = list(/obj/item/clothing/under/roguetown/tights/stockings/fishnet/black)
//	reqs = list(/obj/item/natural/fibers = 2)
//	craftdiff = 3

//datum/crafting_recipe/roguetown/sewing/stockings_blue_fishnet
//	name = "blue fishnet stockings (2 fibers)"
//	result = list(/obj/item/clothing/under/roguetown/tights/stockings/fishnet/blue)
//	reqs = list(/obj/item/natural/fibers = 2)
//	craftdiff = 3

//datum/crafting_recipe/roguetown/sewing/stockings_red_fishnet
//	name = "red fishnet stockings (2 fibers)"
//	result = list(/obj/item/clothing/under/roguetown/tights/stockings/fishnet/red)
//	reqs = list(/obj/item/natural/fibers = 2)
//	craftdiff = 3

//datum/crafting_recipe/roguetown/sewing/stockings_purple_fishnet
//	name = "purple fishnet stockings (2 fibers)"
//	result = list(/obj/item/clothing/under/roguetown/tights/stockings/fishnet/purple)
//	reqs = list(/obj/item/natural/fibers = 2)
//	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/strapless_dress
	name = "strapless dress (1 fibers, 2 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

//datum/crafting_recipe/roguetown/sewing/strapless_dress_black
//	name = "black strapless dress (1 fibers, 2 cloth)"
//	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless/black)
//	reqs = list(/obj/item/natural/cloth = 2,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 3

//datum/crafting_recipe/roguetown/sewing/strapless_dress_blue
//	name = "blue strapless dress (1 fibers, 2 cloth)"
//	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless/blue)
//	reqs = list(/obj/item/natural/cloth = 2,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 3

//datum/crafting_recipe/roguetown/sewing/strapless_dress_red
//	name = "red strapless dress (1 fibers, 2 cloth)"
//	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless/red)
//	reqs = list(/obj/item/natural/cloth = 2,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 3

//datum/crafting_recipe/roguetown/sewing/strapless_dress_purple
//	name = "purple strapless dress (1 fibers, 2 cloth)"
//	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless/purple)
//	reqs = list(/obj/item/natural/cloth = 2,
//				/obj/item/natural/fibers = 1)
//	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/strapless_dress_alt
	name = "strapless dress alt (1 fibers, 1 cloth)"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/strapless/alt)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
