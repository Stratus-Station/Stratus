/obj/structure/sign
	icon = 'icons/obj/decals.dmi'
	anchored = 1
	opacity = 0
	density = 0
	layer = 3.5

/obj/structure/sign/ex_act(severity)
	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			qdel(src)
			return
		if(3.0)
			qdel(src)
			return
		else
	return

/obj/structure/sign/blob_act()
	qdel(src)
	return

/obj/structure/sign/attackby(obj/item/tool as obj, mob/user as mob)	//deconstruction
	if(istype(tool, /obj/item/weapon/screwdriver) && !istype(src, /obj/structure/sign/double))
		to_chat(user, "You unfasten the sign with your [tool].")
		var/obj/item/sign/S = new(src.loc)
		S.name = name
		S.desc = desc
		S.icon_state = icon_state
		//var/icon/I = icon('icons/obj/decals.dmi', icon_state)
		//S.icon = I.Scale(24, 24)
		S.sign_state = icon_state
		qdel(src)
	else ..()

/obj/item/sign
	name = "sign"
	desc = ""
	icon = 'icons/obj/decals.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	burn_state = FLAMMABLE
	var/sign_state = ""

/obj/item/sign/attackby(obj/item/tool as obj, mob/user as mob)	//construction
	if(istype(tool, /obj/item/weapon/screwdriver) && isturf(user.loc))
		var/direction = input("In which direction?", "Select direction.") in list("North", "East", "South", "West", "Cancel")
		if(direction == "Cancel") return
		var/obj/structure/sign/S = new(user.loc)
		switch(direction)
			if("North")
				S.pixel_y = 32
			if("East")
				S.pixel_x = 32
			if("South")
				S.pixel_y = -32
			if("West")
				S.pixel_x = -32
			else return
		S.name = name
		S.desc = desc
		S.icon_state = sign_state
		to_chat(user, "You fasten \the [S] with your [tool].")
		qdel(src)
	else ..()

/obj/structure/sign/double/map
	name = "station map"
	desc = "A framed picture of the station."

/obj/structure/sign/double/map/left
	icon_state = "map-left"

/obj/structure/sign/double/map/right
	icon_state = "map-right"

/obj/structure/sign/securearea
	name = "\improper SECURE AREA"
	desc = "A warning sign which reads 'SECURE AREA'"
	icon_state = "securearea"

/obj/structure/sign/biohazard
	name = "\improper BIOHAZARD"
	desc = "A warning sign which reads 'BIOHAZARD'"
	icon_state = "bio"

/obj/structure/sign/electricshock
	name = "\improper HIGH VOLTAGE"
	desc = "A warning sign which reads 'HIGH VOLTAGE'"
	icon_state = "shock"

/obj/structure/sign/examroom
	name = "\improper EXAM"
	desc = "A guidance sign which reads 'EXAM ROOM'"
	icon_state = "examroom"

/obj/structure/sign/vacuum
	name = "\improper HARD VACUUM AHEAD"
	desc = "A warning sign which reads 'HARD VACUUM AHEAD'"
	icon_state = "space"

/obj/structure/sign/deathsposal
	name = "\improper DISPOSAL LEADS TO SPACE"
	desc = "A warning sign which reads 'DISPOSAL LEADS TO SPACE'"
	icon_state = "deathsposal"

/obj/structure/sign/pods
	name = "\improper ESCAPE PODS"
	desc = "A warning sign which reads 'ESCAPE PODS'"
	icon_state = "pods"

/obj/structure/sign/fire
	name = "\improper DANGER: FIRE"
	desc = "A warning sign which reads 'DANGER: FIRE'"
	icon_state = "fire"

/obj/structure/sign/nosmoking_1
	name = "\improper NO SMOKING"
	desc = "A warning sign which reads 'NO SMOKING'"
	icon_state = "nosmoking"

/obj/structure/sign/nosmoking_2
	name = "\improper NO SMOKING"
	desc = "A warning sign which reads 'NO SMOKING'"
	icon_state = "nosmoking2"

/obj/structure/sign/dogpoker
 	name = "\improper dog painting"
 	desc = "A painting of some dogs playing poker, wonder if Ian is in it."
 	icon_state = "dogpoker"

/obj/structure/sign/starry
 	name = "\improper beautiful landscape painting"
 	desc = "A beautiful painting with swirling stars and a twisting skyline."
 	icon_state = "starry"

/obj/structure/sign/snow
 	name = "\improper snowy painting."
 	desc = "A calming picture of a cabin surronded by velvety snow."
 	icon_state = "snowy"

/obj/structure/sign/gogh
 	name = "\improper portrait"
 	desc = "An impressive self-portrait of an artist, dated many centuries ago."
 	icon_state = "gogh"

/obj/structure/sign/bigwave
 	name = "\improper tidal wave painting"
 	desc = "A painting of a huge wave, written in an old ancient language you cannot seem to understand."
 	icon_state = "wave"

/obj/structure/sign/desert
 	name = "\improper desert painting"
 	desc = "A picture of what appears to be bones cast out in the desert, it looks quite melancholy and haunting.."
 	icon_state = "desert"

/obj/structure/sign/stillife
	name = "\improper still-life painting"
	desc = "A painting that shows what appears to be fruit on a table in great detail."
	icon_state = "still"

/obj/structure/sign/persistance
	name = "\improper surreal painting"
	desc = "A surreal painting focusing on clocks melting into the landscape, almost trippy to look at."
	icon_state = "persistance"

/obj/structure/sign/sonofman
	name = "\improper surreal portrait"
	desc = "A strange surreal painting of a man with an apple for a face. Sounds like something Botany would do."
	icon_state = "sonman"

/obj/structure/sign/scream
 	name = "\improper eerie painting"
 	desc = "An odd picture showing a figure with his hands clasped over his face, screaming in a cacophony of agony, disturbing."
 	icon_state = "thescream"

/obj/structure/sign/redcross
	name = "medbay"
	desc = "The Intergalactic symbol of Medical institutions. You'll probably get help here.'"
	icon_state = "redcross"

/obj/structure/sign/greencross
	name = "medbay"
	desc = "The Intergalactic symbol of Medical institutions. You'll probably get help here.'"
	icon_state = "greencross"

/obj/structure/sign/goldenplaque
	name = "The Most Robust Men Award for Robustness"
	desc = "To be Robust is not an action or a way of life, but a mental state. Only those with the force of Will strong enough to act during a crisis, saving friend from foe, are truly Robust. Stay Robust my friends."
	icon_state = "goldenplaque"

/obj/structure/sign/kiddieplaque
	name = "AI developers plaque"
	desc = "Next to the extremely long list of names and job titles, there is a drawing of a little child. The child appears to be retarded. Beneath the image, someone has scratched the word \"PACKETS\"."
	icon_state = "kiddieplaque"

/obj/structure/sign/atmosplaque
	name = "\improper ZAS Atmospherics Division plaque"
	desc = "This plaque commemorates the fall of the Atmos ZAS division. For all the charred, dizzy, and brittle men who have died in its horrible hands."
	icon_state = "atmosplaque"

/obj/structure/sign/kidanplaque
	name = "Kidan wall trophy"
	desc = "A dead and stuffed Diona nymph, mounted on a board."
	icon_state = "kidanplaque"

/obj/structure/sign/science			//These 3 have multiple types, just var-edit the icon_state to whatever one you want on the map
	name = "\improper SCIENCE!"
	desc = "A warning sign which reads 'SCIENCE!'"
	icon_state = "science1"

/obj/structure/sign/chemistry
	name = "\improper CHEMISTRY"
	desc = "A warning sign which reads 'CHEMISTRY'"
	icon_state = "chemistry1"

/obj/structure/sign/botany
	name = "\improper HYDROPONICS"
	desc = "A warning sign which reads 'HYDROPONICS'"
	icon_state = "hydro1"

/obj/structure/sign/mech
	name = "\improper mech painting"
	desc = "A painting of a mech"
	icon_state = "mech"

/obj/structure/sign/nuke
	name = "\improper nuke painting"
	desc = "A painting of a nuke"
	icon_state = "nuke"

/obj/structure/sign/clown
	name = "\improper clown painting"
	desc = "A painting of the clown and mime. Awwww."
	icon_state = "clown"

/obj/structure/sign/bobross
	name = "\improper calming painting"
	desc = "We don't make mistakes, just happy little accidents."
	icon_state = "bob"

/obj/structure/sign/singulo
	name = "\improper singulo painting"
	desc = "A mesmerizing painting of a singularity. It seems to suck you in..."
	icon_state = "singulo"

/obj/structure/sign/barber
	name = "\improper barber shop sign"
	desc = "A spinning sign indicating a barbershop is near."
	icon_state = "barber"

/obj/structure/sign/chinese
	name = "\improper chinese restaurant sign"
	desc = "A glowing dragon invites you in."
	icon_state = "chinese"

/obj/structure/sign/directions/science
	name = "\improper Research Division"
	desc = "A direction sign, pointing out which way the Research Division is."
	icon_state = "direction_sci"

/obj/structure/sign/directions/engineering
	name = "\improper Engineering Department"
	desc = "A direction sign, pointing out which way the Engineering department is."
	icon_state = "direction_eng"

/obj/structure/sign/directions/security
	name = "\improper Security Department"
	desc = "A direction sign, pointing out which way the Security department is."
	icon_state = "direction_sec"

/obj/structure/sign/directions/medical
	name = "\improper Medical Bay"
	desc = "A direction sign, pointing out which way Medical Bay is."
	icon_state = "direction_med"

/obj/structure/sign/directions/evac
	name = "\improper Escape Arm"
	desc = "A direction sign, pointing out which way escape shuttle dock is."
	icon_state = "direction_evac"
