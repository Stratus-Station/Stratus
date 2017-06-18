/proc/ishuman_species(A)
	if(istype(A, /mob/living/carbon/human) && (A:get_species() == "Human"))
		return 1
	return 0

/proc/isunathi(A)
	if(istype(A, /mob/living/carbon/human) && (A:get_species() == "Unathi"))
		return 1
	return 0

/proc/istajara(A)
	if(istype(A, /mob/living/carbon/human))
		switch(A:get_species())
			if ("Tajara")
				return 1
			if("Zhan-Khazan Tajara")
				return 1
			if("M'sai Tajara")
				return 1
	return 0

/proc/isskrell(A)
	if(istype(A, /mob/living/carbon/human) && (A:get_species() == "Skrell"))
		return 1
	return 0

/proc/isvaurca(A)
	if(istype(A, /mob/living/carbon/human))
		switch(A:get_species())
			if ("Vaurca Worker")
				return 1
			if("Vaurca Warrior")
				return 1
			if("Vaurca Breeder")
				return 1
			if("V'krexi")
				return 1
	return 0

/proc/isipc(A)
	if(istype(A, /mob/living/carbon/human))
		switch(A:get_species())
			if ("Machine")
				return 1
/*			if ("Baseline Frame")
				return 1
			if ("Industrial Frame")
				return 1
			if ("Shell Frame")
				return 1
			if ("Hunter-Killer")
				return 1
*/
	return 0

/proc/isvox(A)
	if(istype(A, /mob/living/carbon/human))
		switch(A:get_species())
			if ("Vox")
				return 1
			if ("Vox Pariah")
				return 1
			if ("Vox Armalis")
				return 1
	return 0

