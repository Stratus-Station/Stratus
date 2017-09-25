/datum/controller/process/flicker/
	var/list/lights = list()
	var/obj/machinery/light/blargh
/datum/controller/process/flicker/setup()
	name = "random light flickering"
	schedule_interval = 2
	for(var/obj/machinery/light/lt in world)
		if(is_station_level(lt.z))
			lights += lt
/datum/controller/process/flicker/doWork()
	sleep(rand(1200,6000))
	blargh = pick(lights)
	blargh.flicker()
/*	for(var/obj/machinery/light/lt in world)
		if(is_station_level(lt.z) && prob(1))
			lt.flicker()
			break*/
