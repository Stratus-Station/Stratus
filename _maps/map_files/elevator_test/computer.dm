/obj/machinery/computer/shuttle/elevator
	name = "Elevator Console"
	icon = 'icons/obj/terminals.dmi'
	icon_state = "elevator"
	density = 0
	pixel_y = 32
	desc = "Used to call and send the mining elevator."
	circuit = /obj/item/weapon/circuitboard/mining_shuttle
	shuttleId = "elevator"
	possible_destinations = "elevator_home;elevator_away"