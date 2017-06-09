/datum/market/triton
	name = "Triton's Plot"
	desc = "So called for its unusual abundance of water-worlds, Triton's Plot is one of Stratus' seedier solar systems.\
	Few, if any, proper governments exist here. Rather, it comprises a motley assortment of synthetic supremicists,\
	rogue dionae groves, vox shoals (leftovers from the last arkship to visit, a few centuries back,) and whatever\
	other forsaken groups have made their way here.\
	Naturally, industry here is virtually nonexistant, but there is a thriving trade in second-hand goods,\
	both salvaged and plundered."
	species = list(/datum/species/machine,/datum/species/vox, /datum/species/diona)
	stability = 45
	var/list/exports = list((/datum/commodity/salvage, 50, -35), (/datum/commodity/illegal/plundered, 50, -20))