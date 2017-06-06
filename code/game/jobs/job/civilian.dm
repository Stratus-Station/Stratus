/datum/job/civilian
	title = "Civilian"
//	flag = CIVILIAN
//	department_flag = SUPPORT
	total_positions = -1
	spawn_positions = -1
	supervisors = "the captain"
	department_head = list("captain")
	selection_color = "#dddddd"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	alt_titles = list("Tourist","Businessman","Trader","Assistant")
	outfit = /datum/outfit/job/assistant
	admin_only = 1

/datum/job/civilian/get_access()
	if(config.assistant_maint)
		return list(access_maint_tunnels)
	else
		return list()

/datum/outfit/job/assistant
	name = "Civilian"
//	jobtype = /datum/job/civilian

	uniform = /obj/item/clothing/under/color/random
	shoes = /obj/item/clothing/shoes/black


