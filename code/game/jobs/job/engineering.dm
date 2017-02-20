/datum/job/chief_engineer
	title = "Chief Engineer"
	flag = CHIEF
	department_flag = ENGSEC
	total_positions = 1
	spawn_positions = 1
	is_engineering = 1
	supervisors = "the captain"
	selection_color = "#ffeeaa"
	idtype = /obj/item/weapon/card/id/ce
	req_admin_notify = 1
	access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction, access_sec_doors,
			            access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_minisat, access_mineral_storeroom)
	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction, access_sec_doors,
			            access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_minisat, access_mineral_storeroom)
	minimal_player_age = 21
	exp_requirements = 600
	exp_type = EXP_TYPE_CREW

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_or_collect(new /obj/item/device/radio/headset/heads/ce(H), slot_l_ear)
		switch(H.backbag)
			if(2) H.equip_or_collect(new /obj/item/weapon/storage/backpack/industrial(H), slot_back)
			if(3) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_eng(H), slot_back)
			if(4) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		H.equip_or_collect(new /obj/item/clothing/under/rank/chief_engineer(H), slot_w_uniform)
		H.equip_or_collect(new /obj/item/device/pda/heads/ce(H), slot_wear_pda)
		H.equip_or_collect(new /obj/item/clothing/shoes/brown(H), slot_shoes)
		H.equip_or_collect(new /obj/item/clothing/head/hardhat/white(H), slot_head)
		H.equip_or_collect(new /obj/item/weapon/storage/belt/utility/full(H), slot_belt)
		H.equip_or_collect(new /obj/item/clothing/gloves/color/black/ce(H), slot_gloves)
		H.equip_or_collect(new /obj/item/weapon/storage/box/engineer(H), slot_in_backpack)
		H.equip_or_collect(new /obj/item/weapon/melee/classic_baton/telescopic(H), slot_in_backpack)
		var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
		L.imp_in = H
		L.implanted = 1
		H.sec_hud_set_implants()
		return 1



/datum/job/engineer
	title = "Station Engineer"
	flag = ENGINEER
	department_flag = ENGSEC
	total_positions = 3
	spawn_positions = 3
	is_engineering = 1
	supervisors = "the chief engineer"
	selection_color = "#fff5cc"
	idtype = /obj/item/weapon/card/id/engineering
	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_mineral_storeroom)
	minimal_access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_mineral_storeroom)
	minimal_player_age = 7

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_or_collect(new /obj/item/device/radio/headset/headset_eng(H), slot_l_ear)
		switch(H.backbag)
			if(2) H.equip_or_collect(new /obj/item/weapon/storage/backpack/industrial(H), slot_back)
			if(3) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_eng(H), slot_back)
			if(4) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		H.equip_or_collect(new /obj/item/clothing/under/rank/engineer(H), slot_w_uniform)
		H.equip_or_collect(new /obj/item/clothing/shoes/workboots(H), slot_shoes)
		H.equip_or_collect(new /obj/item/weapon/storage/belt/utility/full(H), slot_belt)
		H.equip_or_collect(new /obj/item/clothing/head/hardhat(H), slot_head)
		H.equip_or_collect(new /obj/item/device/t_scanner(H), slot_r_store)
		H.equip_or_collect(new /obj/item/device/pda/engineering(H), slot_wear_pda)
		H.equip_or_collect(new /obj/item/weapon/storage/box/engineer(H), slot_in_backpack)
		return 1



/datum/job/atmos
	title = "Atmospherics Technician"
	flag = ATMOSTECH
	department_flag = ENGSEC
	total_positions = 1
	spawn_positions = 1
	is_engineering = 1
	supervisors = "the chief engineer"
	selection_color = "#fff5cc"
	idtype = /obj/item/weapon/card/id/engineering
	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_mineral_storeroom)
	minimal_access = list(access_eva, access_atmospherics, access_maint_tunnels, access_external_airlocks, access_emergency_storage, access_construction, access_mineral_storeroom)
	minimal_player_age = 7

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_or_collect(new /obj/item/device/radio/headset/headset_eng(H), slot_l_ear)
		switch(H.backbag)
			if(2) H.equip_or_collect(new /obj/item/weapon/storage/backpack(H), slot_back)
			if(3) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_norm(H), slot_back)
			if(4) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		H.equip_or_collect(new /obj/item/clothing/under/rank/atmospheric_technician(H), slot_w_uniform)
		H.equip_or_collect(new /obj/item/clothing/shoes/workboots(H), slot_shoes)
		H.equip_or_collect(new /obj/item/weapon/storage/belt/utility/atmostech/(H), slot_belt)
		H.equip_or_collect(new /obj/item/device/pda/atmos(H), slot_wear_pda)
		H.equip_or_collect(new /obj/item/weapon/storage/box/engineer(H), slot_in_backpack)
		return 1

/datum/job/roboticist
	title = "Roboticist"
	flag = ROBOTICIST
	department_flag = ENGSEC
	total_positions = 1
	spawn_positions = 1
	is_engineering = 1
	supervisors = "the chief engineer"
	selection_color = "#fff5cc"
	idtype = /obj/item/weapon/card/id/engineering
	//TODO: reword robotics access
	access = list(access_robotics, access_tox, access_tox_storage, access_tech_storage, access_morgue, access_research, access_mineral_storeroom)
	minimal_access = list(access_robotics, access_tech_storage, access_morgue, access_research, access_maint_tunnels, access_mineral_storeroom)
	minimal_player_age = 3

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		switch(H.backbag)
			if(2) H.equip_or_collect(new /obj/item/weapon/storage/backpack(H), slot_back)
			if(3) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_norm(H), slot_back)
			if(4) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		H.equip_or_collect(new /obj/item/device/radio/headset/headset_sci(H), slot_l_ear)
		H.equip_or_collect(new /obj/item/clothing/under/rank/roboticist(H), slot_w_uniform)
		H.equip_or_collect(new /obj/item/clothing/shoes/black(H), slot_shoes)
		H.equip_or_collect(new /obj/item/device/pda/roboticist(H), slot_wear_pda)
		H.equip_or_collect(new /obj/item/clothing/suit/storage/labcoat(H), slot_wear_suit)
		H.equip_or_collect(new /obj/item/weapon/storage/belt/utility/full(H), slot_belt)
		H.equip_or_collect(new /obj/item/weapon/storage/box/survival(H), slot_in_backpack)
		return 1
