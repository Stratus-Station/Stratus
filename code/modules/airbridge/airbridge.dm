/obj/airbridge
	invisibility = 101
	icon = 'icons/obj/device.dmi'
	icon_state = "pinonmedium"
	dir = NORTH
	anchored = 1
	unacidable = 1
	var/id = "generic"
	var/length = 1
	var/centered = TRUE
	var/turf_type = /turf/space
	var/speed = 50
//	var/template = 'generic'

/*/obj/airbridge_anchor
	invisibility = 101
	icon = 'icons/obj/device.dmi'
	icon_state = "gps"
	anchored = 1
	unacidable = 1
*/


/obj/machinery/computer/airbridge
	name = "Airbridge Console"
	var/airbid = "generic"
	var/OnStartExpand = TRUE

/obj/machinery/computer/airbridge/proc/load_template(var/obj/airbridge/arb, dis, var/turf/arbpos)
	var/arx = arbpos.x
	var/ary = arbpos.y
	var/arz = arbpos.z
	if(arb.dir == WEST || arb.dir == SOUTHWEST || arb.dir == NORTHWEST)
		arx -= dis
	else if(arb.dir == EAST || arb.dir == SOUTHEAST || arb.dir == NORTHEAST)
		arx += dis
	if(arb.dir == NORTH || arb.dir == NORTHWEST || arb.dir == NORTHEAST)
		ary += dis
	else if(arb.dir == SOUTH || arb.dir == SOUTHWEST || arb.dir == SOUTHEAST)
		ary -= dis
//	var/datum/map_template/airbridge/temp
	var/datum/map_template/airbridge/temp = airbridge_templates[arb.id]
/*	for (var/datum/map_template/airbridge/A in /datum/map_template/airbridge)
		if(A.suffix == arb.id)
			temp = A
			to_chat(usr, "<span class='notice'>Phase 3b complete.</span>")
			break*/
	var/turf/landmark_turf = locate(arx, ary, arz)
	sleep(arb.speed)
	temp.load(landmark_turf, centered = arb.centered)



/obj/machinery/computer/airbridge/proc/bridge_expand(var/obj/airbridge/arb)
	var/tm = arb.length
	var/dis = 0
	while(tm > 0)
		load_template(arb, dis, get_turf(arb))
		dis++
		tm--

/obj/machinery/computer/airbridge/proc/bridge_init()
	var/brcount = 0
	for(var/obj/airbridge/arb in world)
		if(arb.id == airbid)
			brcount++
			bridge_expand(arb)
			var/area/airbridge/ara = new
			var/list/turf/org = list()
			ara.araID = arb.id
			ara.rank = brcount
			ara.name = "Airbridge [arb.id].[brcount]"
			var/area/airbridge/ara2
			for(var/turf/ara3 in ara2.contents)
				org += ara3
			ara.contents.Add(org)

	for(var/obj/machinery/door/airlock/L in world)
		if(L.id_tag == airbid)
			L.unlock()

/datum/map_template/airbridge
	var/suffix
	var/prefix = "_maps/map_files/airbridge/"
	var/description
	var/bridge_width = 1
/datum/map_template/airbridge/New()
//	shuttle_id = "[port_id]_[suffix]"
	mappath = "[prefix][suffix].dmm"
	. = ..()

/datum/map_template/airbridge/generic
	suffix = "generic"
	name = "Generic"
	description = "Your quintessential airbridge. What else is there to say?"
	width = 5
/area/airbridge
	name = "\improper Airbridge"
	icon_state = "yellow"
	var/rank = 0
	var/araID


/turf/simulated/shuttle/floor/airless
	oxygen = 0.01
	nitrogen = 0.01

/turf/simulated/shuttle/wall/airless
	oxygen = 0.01
	nitrogen = 0.01