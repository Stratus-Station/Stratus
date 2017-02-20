var/datum/announcement/minor/captain_announcement = new(do_newscast = 0)
/datum/job/captain
	title = "Captain"
	flag = CAPTAIN
	department_flag = ENGSEC
	total_positions = 1
	spawn_positions = 1
	supervisors = "Nanotrasen officials"
	selection_color = "#ccccff"
	idtype = /obj/item/weapon/card/id/gold
	req_admin_notify = 1
	is_command = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 30
	exp_requirements = 1200
	exp_type = EXP_TYPE_CREW
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_or_collect(new /obj/item/device/radio/headset/heads/captain/alt(H), slot_l_ear)
		switch(H.backbag)
			if(2) H.equip_or_collect(new /obj/item/weapon/storage/backpack/captain(H), slot_back)
			if(3) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_cap(H), slot_back)
			if(4) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		H.equip_or_collect(new /obj/item/weapon/storage/box/survival(H), slot_in_backpack)
		var/obj/item/clothing/under/U = new /obj/item/clothing/under/rank/captain(H)
		var/obj/item/clothing/accessory/medal/gold/captain/M = new /obj/item/clothing/accessory/medal/gold/captain(U)
		U.accessories += M
		M.on_attached(U)
		H.equip_or_collect(U, slot_w_uniform)
		H.equip_or_collect(new /obj/item/device/pda/captain(H), slot_wear_pda)
		H.equip_or_collect(new /obj/item/clothing/suit/armor/vest/capcarapace(H), slot_wear_suit)
		H.equip_or_collect(new /obj/item/clothing/shoes/brown(H), slot_shoes)
		H.equip_or_collect(new /obj/item/clothing/head/caphat(H), slot_head)
		H.equip_or_collect(new /obj/item/clothing/glasses/sunglasses(H), slot_glasses)
		H.equip_or_collect(new /obj/item/weapon/storage/box/ids(H), slot_in_backpack)
		H.equip_or_collect(new /obj/item/weapon/melee/classic_baton/telescopic(H), slot_in_backpack)
		var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
		L.imp_in = H
		L.implanted = 1
		H.sec_hud_set_implants()
		captain_announcement.Announce("All hands, Captain [H.real_name] on deck!")
		callHook("captain_spawned", list("captain" = H))
		return 1

	get_access()
		return get_all_accesses()
