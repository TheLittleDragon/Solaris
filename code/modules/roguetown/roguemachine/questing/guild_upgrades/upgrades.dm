// Guild Upgrade Datums and Global Registry
GLOBAL_LIST_INIT(all_guild_upgrades, list(
	/datum/guild_upgrade/town_fountain,
	/datum/guild_upgrade/town_beacon,
	/datum/guild_upgrade/water_well,
	/datum/guild_upgrade/scom,
	/datum/guild_upgrade/guild_lighting,
	/datum/guild_upgrade/basic_questgiver,
	/datum/guild_upgrade/knight_statue,
	/datum/guild_upgrade/artificer_flag,
	/datum/guild_upgrade/file_cabinet,
	/datum/guild_upgrade/stockpile,
	/datum/guild_upgrade/mail_station,
	/datum/guild_upgrade/reward_chest,
	/datum/guild_upgrade/hearth,
	/datum/guild_upgrade/training_dummy,
	/datum/guild_upgrade/bedrolls,
	/datum/guild_upgrade/aeternus_statue,
	/datum/guild_upgrade/copper_cross,
	/datum/guild_upgrade/tanning_rack,
))

/datum/guild_upgrade
	var/name = "Basic Upgrade"
	var/category = "utility" // utility, convenience, or storage
	var/cost = 100
	var/refund_value = 100 // Percentage of original cost refunded when uninstalled (0-100)
	var/bonus = 0
	var/bonus_message = ""
	var/list/active_effects = list() // Objects to spawn
	var/passive_effects = "" // Changed from list to string description
	var/outdoor_only = FALSE // Default to false, set true for outdoor upgrades
	var/list/conflicts_with = list()
	var/direction = null // "north", "south", "east", or "west"

/datum/guild_upgrade/proc/get_passive_description()
	return passive_effects ? passive_effects : "No passive effects"

/datum/guild_upgrade/proc/apply_upgrade(turf/location, mob/installer)
	if(bonus > 0)
		var/gave_bonus = FALSE

		// First try the installer
		if(installer && (installer in SStreasury.bank_accounts))
			SStreasury.bank_accounts[installer] += bonus
			SStreasury.treasury_value += bonus
			SStreasury.log_entries += "+[bonus] to [installer.real_name] (guild upgrade bonus)"
			gave_bonus = TRUE
			if(bonus_message)
				to_chat(installer, span_notice("[bonus_message]"))
		else
			// If installer has no account, find a guild handler
			for(var/mob/M in SStreasury.bank_accounts)
				if(M.job == "Guild Handler")
					SStreasury.bank_accounts[M] += bonus
					SStreasury.treasury_value += bonus
					SStreasury.log_entries += "+[bonus] to [M.real_name] (guild upgrade fallback bonus)"
					gave_bonus = TRUE
					to_chat(M, span_notice("A bonus of [bonus] marks has been deposited to your account from a guild upgrade installation."))
					if(installer)
						to_chat(installer, span_notice("The bonus was given to Guild Handler [M.real_name] since you don't have a bank account."))
					break

			// If no guild handler found, drop physical coins
			if(!gave_bonus)
				var/obj/item/roguecoin/gold/gold_coins = new(location)
				var/obj/item/roguecoin/silver/silver_coins = new(location)
				var/obj/item/roguecoin/copper/copper_coins = new(location)

				gold_coins.quantity = FLOOR(bonus / 10, 1)
				silver_coins.quantity = FLOOR(bonus % 10 / 5, 1)
				copper_coins.quantity = bonus % 5

				gold_coins.update_icon()
				silver_coins.update_icon()
				copper_coins.update_icon()

				if(installer)
					to_chat(installer, span_notice("Since no valid bank accounts were found, [bonus] marks worth of coins have been dispensed on the floor."))

	for(var/path in active_effects)
		new path(location)
	SSroguemachine.guild_upgrades += src
	return TRUE

/datum/guild_upgrade/proc/apply_passive_bonus(mob/user, datum/quest/quest)
	return
