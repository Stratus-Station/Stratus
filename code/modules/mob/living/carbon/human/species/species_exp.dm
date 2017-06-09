/datum/species/proc/get_exp_req_type()
	return exp_type

/datum/species/proc/available_in_playtime(client/C)
	if(!C)
		return 0
	if(!req_playtime)
		return 0
	if(!config.usealienwhitelist)
		return 0
	if(check_rights(R_ADMIN, 0, C.mob))
		return 0
	var/list/play_records = params2list(C.prefs.exp)
	var/my_exp = text2num(play_records[get_exp_req_type()])
	if(my_exp >= req_playtime)
		return 0
	else
		return (req_playtime - my_exp)
