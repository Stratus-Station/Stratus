//Weapons and items used exclusively by the Vaurcae, typically only for event shenanigans, and possibly random finds in the future. All items here should have
//"Vaurca" in the item path at some point, so they can be easily spawned in-game.
/obj/item/weapon/storage/backpack/cloak
	name = "tunnel cloak"
	desc = "It's a Vaurca cloak, with paltry storage options."
	icon = 'icons/baysphere/obj/storage.dmi'
	icon_state = "cape"
	storage_slots = 12

/obj/item/clothing/glasses/sunglasses/blinders
	name = "vaurcae blinders"
	desc = "Specially designed Vaurca blindfold, designed to let in just enough light to see."
	icon = 'icons/baysphere/obj/clothing/glasses.dmi'
	icon_state = "blinders"
	item_state = "blinders"

/obj/item/clothing/mask/breath/vaurca
	desc = "A Vaurcae mandible garment with an attached gas filter and air-tube."
	name = "mandible garment"
	icon = 'icons/obj/vaurca_items.dmi'
	icon_state = "m_garment"
	item_state = "m_garment"
//	contained_sprite = 1

/obj/item/clothing/mask/breath/vaurca/adjustmask(mob/user)
//	user << "This mask is too tight to adjust."
	to_chat(user, "<span class='notice'>This mask is too tight to adjust.</span>")
	return

/obj/item/weapon/melee/energy/vaurca
	name = "thermal knife"
	desc = "A Vaurcae-designed combat knife with a thermal energy blade designed for close-quarter encounters."
	icon = 'icons/obj/vaurca_items.dmi'
	icon_state = "eknife0"
	item_state = "eknife0"
	force_on = 20
	throwforce_on = 20
	w_class_on = 5
	force = 5
	throwforce = 5
	throw_speed = 5
	throw_range = 10
	w_class = 1
	flags = CONDUCT
//	flags = CONDUCT | NOBLOODY
	attack_verb = list("stabbed", "chopped", "sliced", "cleaved", "slashed", "cut")
	sharp = 1
	edge = 1
//	contained_sprite = 1

/obj/item/weapon/melee/energy/vaurca/attack_self(mob/living/carbon/user)
	if(user.disabilities & CLUMSY && prob(50))
		to_chat(user, "<span class='warning'>You accidentally cut yourself with [src], like a doofus!</span>")
		user.take_organ_damage(5,5)
	active = !active
	if(active)
		force = force_on
		throwforce = throwforce_on
		hitsound = 'sound/weapons/blade1.ogg'
		if(attack_verb_on.len)
			attack_verb = attack_verb_on
		icon_state = "eknife1"
		damtype = "fire"
		w_class = w_class_on
		playsound(user, 'sound/weapons/saberon.ogg', 35, 1) //changed it from 50% volume to 35% because deafness
		to_chat(user, "<span class='notice'>[src] is now energised.</span>")
	else
		force = initial(force)
		throwforce = initial(throwforce)
		hitsound = initial(hitsound)
		if(attack_verb_on.len)
			attack_verb = list()
		icon_state = "eknife0"
		damtype = "brute"
		w_class = initial(w_class)
		playsound(user, 'sound/weapons/saberoff.ogg', 35, 1)  //changed it from 50% volume to 35% because deafness
		to_chat(user, "<span class='notice'>[src] is de-energised.</span>")
	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		H.update_inv_l_hand()
		H.update_inv_r_hand()
	add_fingerprint(user)
	return
/*/obj/item/weapon/melee/energy/vaurca/activate(mob/living/user)
	..()
	icon_state = "eknife1"
	item_state = icon_state
	damtype = "fire"
	user.regenerate_icons()
	user << "<span class='notice'>\The [src] is now energised.</span>"

/obj/item/weapon/melee/energy/vaurca/deactivate(mob/living/user)
	..()
	icon_state = "eknife0"
	item_state = icon_state
	damtype = "brute"
	user.regenerate_icons()
	user << "<span class='notice'>\The [src] is de-energised.</span>"
*/
/obj/item/vaurca/box
	name = "puzzle box"
	desc = "A classic Zo'rane puzzle box, a common sight in Vaurcae colonies."
	icon_state = "puzzlebox"
//	contained_sprite = 1
	icon = 'icons/obj/vaurca_items.dmi'

/obj/item/vaurca/box/attack_self(mob/user as mob)

	if(isvaurca(user))
		to_chat(user, "<span class='notice'>You are familiar with the box's solution, and open it to reveal an ancient thing. How tedious.</span>")
		var/obj/item/weapon/archaeological_find/X = new /obj/item/weapon/archaeological_find
		user.remove_from_mob(src)
		user.put_in_hands(X)
		qdel(src)

	else if(isipc(user))
		to_chat(user, "<span class='notice'>You analyze the box's markings, and begin to calculate with robotic efficiency every possible combination. (You must stand still to complete the puzzle box.)</span>")
		if(do_after(user, 100))
			to_chat(user, "<span class='notice'>Calculations complete. You begin to brute-force the box with a mechanical determination.</span>")
			if(do_after(user, 600))
				to_chat(user, "<span class='notice'>After a minute of brute-force puzzle solving, the box finally opens to reveal an ancient thing.</span>")
				var/obj/item/weapon/archaeological_find/X = new /obj/item/weapon/archaeological_find
				user.remove_from_mob(src)
				user.put_in_hands(X)
				qdel(src)

	else if(isvox(user))
		to_chat(user, "<span class='notice'>You are surprised to recognize the markings of the Apex, the Masters! You know this thing... (You must stand still to complete the puzzle box.)</span>")
		if(do_after(user, 100))
			to_chat(user, "<span class='notice'>After a few seconds of remembering, you input the solution to the riddle - a lovely riddle indeed - and open the box to reveal an ancient thing.</span>")
			var/obj/item/weapon/archaeological_find/X = new /obj/item/weapon/archaeological_find
			user.remove_from_mob(src)
			user.put_in_hands(X)
			qdel(src)

	else
		to_chat(user, "<span class='notice'>You stare at the box for a few seconds, trying to even comprehend what you're looking at... (You must stand still to complete the puzzle box.)</span>")
		if(do_after(user, 60))
			to_chat(user, "<span class = 'notice'>After a few more seconds, you hesitantly turn the first piece of the puzzle box.</span>")
			if(do_after(user,30))
				to_chat(user, "<span class = 'notice'>After nothing bad happens, you dive into the puzzle with a feeling of confidence!</span>")
				if(do_after(user,200))
					to_chat(user, "<span class = 'notice'>Twenty seconds pass, and suddenly you're feeling a lot less confident. You struggle on...</span>")
					if(do_after(user,100))
						to_chat(user, "<span class='notice'>You blink, and suddenly you've lost your place, your thoughts, your mind...</span>")
						if(do_after(user,20))
							to_chat(user, "<span class='notice'>You find yourself again, and get back to turning pieces. At this point it is just randomly.</span>")
							if(do_after(user,600))
								to_chat(user, "<span class='notice'>A minute goes by, and with one final turn the box looks just like it did when you started. Fucking bugs.</span>")

/obj/item/weapon/melee/vaurca/navcomp
	name = "navcomp coordinate archive"
	desc = "A rather heavy data disk for a Vaurcae Arkship navigation drive."
	icon = 'icons/obj/vaurca_items.dmi'
	icon_state = "harddisk"
	force = 10
	throwforce = 5
	w_class = 3
//	contained_sprite = 1

/obj/item/weapon/melee/vaurca/rock
	name = "Sedantis rock"
	desc = "A large chunk of alien earth from the distant Vaurcae world of Sedantis I. Just looking at it makes you feel funny."
	icon_state = "glowing"
	icon = 'icons/obj/vaurca_items.dmi'
	force = 15
	throwforce = 30
	w_class = 4
//	contained_sprite = 1

/*/obj/item/weapon/grenade/spawnergrenade/vaurca
	name = "K'ois delivery pod"
	desc = "A sophisticated K'ois delivery pod, for seeding a planet from the comfort of space."
	spawner_type = /obj/machinery/portable_atmospherics/hydroponics/soil/invisible
	deliveryamt = 7
	contained_sprite = 1
	icon = 'icons/obj/vaurca_items.dmi'
	icon_state = "beacon"
	force = 15
	throwforce = 30
	w_class = 4

/obj/item/weapon/grenade/spawnergrenade/vaurca/prime()

	if(spawner_type && deliveryamt)
		var/turf/T = get_turf(src)
		playsound(T, 'sound/effects/phasein.ogg', 100, 1)
		for(var/mob/living/carbon/human/M in viewers(T, null))
			if(M.eyecheck() < FLASH_PROTECTION_MODERATE)
				flick("e_flash", M.flash)

		for(var/i=1, i<=deliveryamt, i++)
			var/obj/machinery/portable_atmospherics/hydroponics/soil/invisible/x = new spawner_type(T, new /datum/seed/koisspore())
			x.tumble(4)
	qdel(src)
	return
*/
/obj/item/clothing/suit/space/hardsuit/vaurca
	name = "hardsuit"
//	contained_sprite = 1
	icon = 'icons/obj/vaurca_items.dmi'
	icon_state = "void"
	item_state = "void"
	desc = "A lightweight Zo'rane designed Vaurcae softsuit, for extremely extended EVA operations."
	slowdown = 0

	species_restricted = list("Vaurca")

	boots = /obj/item/clothing/shoes/magboots/vox/vaurca
	helmet = /obj/item/clothing/head/helmet/space/hardsuit/vaurca

/obj/item/clothing/head/helmet/space/hardsuit/vaurca
	name = "void helmet"
	desc = "An alien looking Zo'rane softsuit helmet."
//	contained_sprite = 1
	icon = 'icons/obj/vaurca_items.dmi'
	icon_state = "helm_void"
	item_state = "helm_void"

	species_restricted = list("Vaurca")

//	light_overlay = "helmet_light"

/obj/item/clothing/shoes/magboots/vox/vaurca

	desc = "A pair of heavy mag-claws designed for a Vaurca."
	name = "mag-claws"
	item_state = "boots_void"
	icon_state = "boots_void"
//	contained_sprite = 1
	icon = 'icons/obj/vaurca_items.dmi'

	species_restricted = list("Vaurca")

//	action_button_name = "Toggle the magclaws"

