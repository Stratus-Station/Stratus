//treeeeeeeeees

/obj/structure/flora/tree/jungle
	name = "jungle tree"
	desc = "A large tree commonly found in jungle areas."
	var/chops = 0 //how many times it's been chopped. Gotta make them work for it!
	var/small = 0

/obj/structure/flora/tree/jungle/large
	desc = "An extremely large tree commonly found in jungle areas."
	name = "large jungle tree"
	icon = 'icons/obj/flora/trees-large.dmi'
	icon_state = "tree1"
	pixel_x = -32

/obj/structure/flora/tree/jungle/large/New()
	icon_state = "tree[rand(1,4)]"

/obj/structure/flora/tree/jungle/small
	icon = 'icons/obj/flora/trees-small.dmi'
	icon_state = "tree1"
	small = 1

/obj/structure/flora/tree/jungle/small/New()
	icon_state = "tree[rand(1,10)]"

/obj/structure/flora/tree/jungle/attackby(var/obj/item/I, mob/user as mob)
	if(istype(I, /obj/item/weapon/hatchet))
		user.show_message("<span class='notice'>You chop [src] with [I].</span>")

		playsound(src.loc, 'sound/effects/chopchop.ogg', 100, 1)

		sleep(5)


		chops += 1

		if(chops == 4 && small)
			user.show_message("<span class='notice'>[src] comes crashing down!</span>")
			playsound(src.loc, 'sound/effects/treefalling.ogg', 100, 1)
			new /obj/item/weapon/grown/log(src.loc)

			qdel(src)

		else if(chops == 8)
			user.show_message("<span class='notice'>[src] comes crashing down!</span>")

			sleep(5)

			playsound(src.loc, 'sound/effects/treefalling.ogg', 100, 1)

			new /obj/item/weapon/grown/log(get_step(src, NORTH))
			new /obj/item/weapon/grown/log(src.loc)
			var/obj/item/weapon/grown/log/L = new /obj/item/weapon/grown/log(get_step(src, NORTH))

			L.y += 1

			qdel(src)

	return

