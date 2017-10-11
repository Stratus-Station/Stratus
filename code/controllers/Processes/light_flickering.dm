/datum/controller/process/flicker/
	var/list/lights = list()
	var/obj/machinery/light/blargh
/datum/controller/process/flicker/setup()
	name = "random light flickering"
	schedule_interval = rand(600,6000)
	for(var/obj/machinery/light/lt in world)
		if(is_station_level(lt.z))
			lights += lt
	log_startup_progress("Random light flickering starting up.")
/datum/controller/process/flicker/doWork()
	blargh = pick(lights)
	blargh.flicker()
	schedule_interval = rand(600,6000)
/*	for(var/obj/machinery/light/lt in world)
		if(is_station_level(lt.z) && prob(1))
			lt.flicker()
			break*/
