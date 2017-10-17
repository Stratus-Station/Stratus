/*
 * False Walls
 */

// Minimum pressure difference to fail building falsewalls.
// Also affects admin alerts.
#define FALSEDOOR_MAX_PRESSURE_DIFF 25.0

/obj/structure/falsewall
	name = "wall"
	desc = "A huge chunk of metal used to seperate rooms."
	anchored = 1
	icon = 'icons/turf/walls/wall.dmi'
	var/material = "metal"
	var/subpath = ""
	var/walltype = "metal"
	var/opening = 0
	density = 1
	opacity = 1

	canSmoothWith = list(
	/turf/simulated/wall,
	/turf/simulated/wall/r_wall,
	/obj/structure/falsewall,
	/obj/structure/falsewall/reinforced,  // WHY DO WE SMOOTH WITH FALSE R-WALLS WHEN WE DON'T SMOOTH WITH REAL R-WALLS. //because we do smooth with real r-walls now
	/turf/simulated/wall/rust,
	/turf/simulated/wall/r_wall/rust)
	smooth = SMOOTH_TRUE

/obj/structure/falsewall/New(loc)
	..()
	material += subpath
	air_update_turf(1)

/obj/structure/falsewall/Destroy()
	density = 0
	air_update_turf(1)
	return ..()

/obj/structure/falsewall/CanAtmosPass(turf/T)
	return !density

/obj/structure/falsewall/attack_ghost(mob/user)
	if(user.can_advanced_admin_interact())
		toggle(user)

/obj/structure/falsewall/attack_hand(mob/user)
	toggle(user)

/obj/structure/falsewall/proc/toggle(mob/user)
	if(opening)
		return

	opening = 1
	if(density)
		do_the_flick()
		sleep(4)
		density = 0
		set_opacity(0)
		update_icon(0)
	else
		var/srcturf = get_turf(src)
		for(var/mob/living/obstacle in srcturf) //Stop people from using this as a shield
			opening = 0
			return
		do_the_flick()
		density = 1
		sleep(4)
		set_opacity(1)
		update_icon()
	air_update_turf(1)
	opening = 0

/obj/structure/falsewall/proc/do_the_flick()
	if(density)
		smooth = SMOOTH_FALSE
		clear_smooth_overlays()
		icon_state = "fwall_opening"
	else
		icon_state = "fwall_closing"

/obj/structure/falsewall/update_icon()
	if(density)
		smooth = SMOOTH_TRUE
		smooth_icon(src)
		icon_state = ""
	else
		icon_state = "fwall_open"

/obj/structure/falsewall/proc/ChangeToWall(delete = 1)
	var/turf/T = get_turf(src)
	if(!walltype || walltype == "metal")
		T.ChangeTurf(/turf/simulated/wall)
	else
		T.ChangeTurf(text2path("/turf/simulated/wall/mineral/[walltype]"))
	if(delete)
		qdel(src)
	return T

/obj/structure/falsewall/attackby(obj/item/weapon/W, mob/user, params)
	if(opening)
		to_chat(user, "<span class='warning'>You must wait until the door has stopped moving.</span>")
		return

	if(density)
		var/turf/T = get_turf(src)
		if(T.density)
			to_chat(user, "<span class='warning'>[src] is blocked!</span>")
			return
		if(istype(W, /obj/item/weapon/screwdriver))
			if(!istype(T, /turf/simulated/floor))
				to_chat(user, "<span class='warning'>[src] bolts must be tightened on the floor!</span>")
				return
			user.visible_message("<span class='notice'>[user] tightens some bolts on the wall.</span>", "<span class='warning'>You tighten the bolts on the wall.</span>")
			ChangeToWall()
		if(istype(W, /obj/item/weapon/weldingtool))
			var/obj/item/weapon/weldingtool/WT = W
			if(WT.remove_fuel(0,user))
				dismantle(user)
	else
		to_chat(user, "<span class='warning'>You can't reach, close it first!</span>")

	if(istype(W, /obj/item/weapon/gun/energy/plasmacutter) || istype(W, /obj/item/weapon/pickaxe/drill/diamonddrill) || istype(W, /obj/item/weapon/pickaxe/drill/jackhammer) || istype(W, /obj/item/weapon/melee/energy/blade))
		dismantle(user)

/obj/structure/falsewall/proc/dismantle(mob/user)
	user.visible_message("<span class='notice'>[user] dismantles the false wall.</span>", "<span class='warning'>You dismantle the false wall.</span>")
	new /obj/structure/girder/displaced(loc)
	if(material == "metal")
		if(istype(src, /obj/structure/falsewall/reinforced))
			new /obj/item/stack/sheet/plasteel(loc, 2)
		else
/*			new /obj/item/stack/sheet/metal(loc, 2)
	else if(mineral == "wood")
		new/obj/item/stack/sheet/wood(loc, 2)
	else if(mineral == "plastic")
		new/obj/item/stack/sheet/plastic(loc, 2)*/
	else
		var/P = text2path("/obj/item/stack/sheet/[material]")
		new P(loc)
		new P(loc)
	playsound(src, 'sound/items/Welder.ogg', 100, 1)
	qdel(src)

/*
 * False R-Walls
 */

/obj/structure/falsewall/reinforced
	name = "reinforced wall"
	desc = "A huge chunk of reinforced metal used to seperate rooms."
	icon = 'icons/turf/walls/reinforced_wall.dmi'
	icon_state = "r_wall"
	walltype = "rwall"

/obj/structure/falsewall/reinforced/ChangeToWall(delete = 1)
	var/turf/T = get_turf(src)
	T.ChangeTurf(/turf/simulated/wall/r_wall)
	if(delete)
		qdel(src)
	return T


/obj/structure/falsewall/mineral/
	material = "mineral/"


/*
 * Uranium Falsewalls
 */


/obj/structure/falsewall/mineral/uranium
	name = "uranium wall"
	desc = "A wall with uranium plating. This is probably a bad idea."
	icon = 'icons/turf/walls/uranium_wall.dmi'
	icon_state = ""
	subpath = "uranium"
	walltype = "uranium"
	var/active = null
	var/last_event = 0
	canSmoothWith = list(/obj/structure/falsewall/mineral/uranium, /turf/simulated/wall/mineral/uranium)

/obj/structure/falsewall/mineral/uranium/attackby(obj/item/weapon/W as obj, mob/user as mob, params)
	radiate()
	..()

/obj/structure/falsewall/mineral/uranium/attack_hand(mob/user as mob)
	radiate()
	..()

/obj/structure/falsewall/mineral/uranium/proc/radiate()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			for(var/mob/living/L in range(3,src))
				L.apply_effect(12,IRRADIATE,0)
			for(var/turf/simulated/wall/mineral/uranium/T in range(3,src))
				T.radiate()
			last_event = world.time
			active = null
			return
	return
/*
 * Other misc falsewall types
 */

/obj/structure/falsewall/mineral/gold
	name = "gold wall"
	desc = "A wall with gold plating. Swag!"
	icon = 'icons/turf/walls/gold_wall.dmi'
	icon_state = ""
	subpath = "gold"
	walltype = "gold"
	canSmoothWith = list(/obj/structure/falsewall/mineral/gold, /turf/simulated/wall/mineral/gold)

/obj/structure/falsewall/mineral/silver
	name = "silver wall"
	desc = "A wall with silver plating. Shiny."
	icon = 'icons/turf/walls/silver_wall.dmi'
	icon_state = ""
	subpath = "silver"
	walltype = "silver"
	canSmoothWith = list(/obj/structure/falsewall/mineral/silver, /turf/simulated/wall/mineral/silver)

/obj/structure/falsewall/mineral/diamond
	name = "diamond wall"
	desc = "A wall with diamond plating. You monster."
	icon = 'icons/turf/walls/diamond_wall.dmi'
	icon_state = ""
	subpath = "diamond"
	walltype = "diamond"
	canSmoothWith = list(/obj/structure/falsewall/mineral/diamond, /turf/simulated/wall/mineral/diamond)


/obj/structure/falsewall/mineral/plasma
	name = "plasma wall"
	desc = "A wall with plasma plating. This is definately a bad idea."
	icon = 'icons/turf/walls/plasma_wall.dmi'
	icon_state = ""
	subpath = "plasma"
	walltype = "plasma"
	canSmoothWith = list(/obj/structure/falsewall/mineral/plasma, /turf/simulated/wall/mineral/plasma, /turf/simulated/wall/mineral/alien)

/obj/structure/falsewall/mineral/plasma/attackby(obj/item/weapon/W, mob/user, params)
	if(is_hot(W) > 300)
		message_admins("Plasma falsewall ignited by [key_name_admin(user)] in ([x],[y],[z] - <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>)",0,1)
		log_game("Plasma falsewall ignited by [key_name(user)] in ([x],[y],[z])")
		burnbabyburn()
		return
	..()

/obj/structure/falsewall/mineral/plasma/proc/burnbabyburn(user)
	playsound(src, 'sound/items/Welder.ogg', 100, 1)
	atmos_spawn_air(SPAWN_HEAT | SPAWN_TOXINS, 400)
	new /obj/structure/girder/displaced(loc)
	qdel(src)

/obj/structure/falsewall/mineral/plasma/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		burnbabyburn()

/obj/structure/falsewall/mineral/alien
	name = "alien wall"
	desc = "A strange-looking alien wall."
	icon = 'icons/turf/walls/plasma_wall.dmi'
	icon_state = ""
	subpath = "plasma"
	walltype = "plasma"
	canSmoothWith = list(/obj/structure/falsewall/mineral/alien, /turf/simulated/wall/mineral/alien)


/obj/structure/falsewall/mineral/bananium
	name = "bananium wall"
	desc = "A wall with bananium plating. Honk!"
	icon = 'icons/turf/walls/bananium_wall.dmi'
	icon_state = ""
	subpath = "bananium"
	walltype = "bananium"
	canSmoothWith = list(/obj/structure/falsewall/mineral/bananium, /turf/simulated/wall/mineral/bananium)
	var/spam_flag = 0

/obj/structure/falsewall/mineral/bananium/Bumped(atom/user)
	honk()
	..()

/obj/structure/falsewall/mineral/bananium/attackby(obj/item/weapon/W, mob/user, params)
	honk()
	..()

/obj/structure/falsewall/mineral/bananium/attack_hand(mob/user)
	honk()
	..()

/obj/structure/falsewall/mineral/bananium/proc/honk()
	if(!spam_flag)
		spam_flag = 1
		playsound(src, 'sound/items/bikehorn.ogg', 50, 1)
		spawn(20)
			spam_flag = 0

/obj/structure/falsewall/mineral/sandstone
	name = "sandstone wall"
	desc = "A wall with sandstone plating."
	icon = 'icons/turf/walls/sandstone_wall.dmi'
	icon_state = ""
	subpath = "sandstone"
	walltype = "sandstone"
	canSmoothWith = list(/obj/structure/falsewall/mineral/sandstone, /turf/simulated/wall/mineral/sandstone)

/obj/structure/falsewall/wood
	name = "wooden wall"
	desc = "A wall with wooden plating. Stiff."
	icon = 'icons/turf/walls/wood_wall.dmi'
	icon_state = ""
	material = "wood"
	walltype = "mineral/wood"
	canSmoothWith = list(/obj/structure/falsewall/wood, /turf/simulated/wall/mineral/wood)

/obj/structure/falsewall/mineral/iron
	name = "rough metal wall"
	desc = "A wall with rough metal plating."
	icon = 'icons/turf/walls/iron_wall.dmi'
	icon_state = ""
	material = "metal"
	walltype = "iron"
	canSmoothWith = list(/obj/structure/falsewall/mineral/iron, /turf/simulated/wall/mineral/iron)

/obj/structure/falsewall/mineral/abductor
	name = "alien wall"
	desc = "A wall with alien alloy plating."
	icon = 'icons/turf/walls/abductor_wall.dmi'
	icon_state = "abductor"
	subpath = "abductor"
	walltype = "abductor"
	canSmoothWith = list(/obj/structure/falsewall/mineral/abductor, /turf/simulated/wall/mineral/abductor)

/obj/structure/falsewall/plastic
	name = "plastic wall"
	desc = "A wall made of colorful plastic blocks attached together."
	icon = 'icons/turf/walls/plastic_wall.dmi'
	icon_state = "plastic"
	material = "plastic"
	walltype = "mineral/plastic"
	opacity = 0
	canSmoothWith = list(/turf/simulated/wall/mineral/plastic, /obj/structure/falsewall/plastic)