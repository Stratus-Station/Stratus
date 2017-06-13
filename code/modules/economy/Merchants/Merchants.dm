//Merchant templates

/datum/merchant
	var/list/market = list()
	var/list/icons = list()
	var/can_alliterate = TRUE
	var/shop_names_only = FALSE //Don't use merchant names for shop names. E.g. No "Yachikiyaya's Bargain Mart"
	var/list/shop_names = list() //As opposed to merchant names, which are taken from the random name generator.
	var/list/names_commodity = list() //Names associated with a given commodity. E.g. "Guns" for weapons.
	var/list/names_modifiers = list() //Flavor. E.g. "N' stuff" or "Discount."
	var/list/dialogue_greet = list()
	var/list/dialogue_greet_same_race = list()
	var/list/dialogue_greet_hated_race = list()
	var/list/dialogue_farewell = list()
	var/list/dialogue_wants = list()
	var/list/dialogue_haggle = list()
	var/list/dialogue_offer_reject = list()
	var/list/dialogue_offer_accept = list()
	var/list/dialogue_insulted = list()