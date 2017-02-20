/datum/job/cmo
	title = "Chief Medical Officer"
	flag = CMO
	department_flag = MEDSCI
	total_positions = 1
	spawn_positions = 1
	is_medical = 1
	supervisors = "the captain"
	selection_color = "#ffddf0"
	idtype = /obj/item/weapon/card/id/cmo
	req_admin_notify = 1
	access = list(access_medical, access_morgue, access_genetics, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_paramedic, access_mineral_storeroom)
	minimal_access = list(access_eva, access_medical, access_morgue, access_genetics, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_maint_tunnels, access_paramedic, access_mineral_storeroom)
	minimal_player_age = 21
	exp_requirements = 600
	exp_type = EXP_TYPE_CREW

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_or_collect(new /obj/item/device/radio/headset/heads/cmo(H), slot_l_ear)
		switch(H.backbag)
			if(2) H.equip_or_collect(new /obj/item/weapon/storage/backpack/medic(H), slot_back)
			if(3) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_med(H), slot_back)
			if(4) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		H.equip_or_collect(new /obj/item/clothing/under/rank/chief_medical_officer(H), slot_w_uniform)
		H.equip_or_collect(new /obj/item/clothing/shoes/brown(H), slot_shoes)
		H.equip_or_collect(new /obj/item/device/pda/heads/cmo(H), slot_wear_pda)
		H.equip_or_collect(new /obj/item/clothing/suit/storage/labcoat/cmo(H), slot_wear_suit)
		H.equip_or_collect(new /obj/item/weapon/storage/firstaid/adv(H), slot_l_hand)
		H.equip_or_collect(new /obj/item/device/flashlight/pen(H), slot_s_store)
		H.equip_or_collect(new /obj/item/weapon/storage/box/survival(H), slot_in_backpack)
		H.equip_or_collect(new /obj/item/weapon/melee/classic_baton/telescopic(H), slot_in_backpack)
		var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
		L.imp_in = H
		L.implanted = 1
		H.sec_hud_set_implants()
		return 1

/datum/job/doctor
	title = "Medical Doctor"
	flag = DOCTOR
	department_flag = MEDSCI
	total_positions = 3
	spawn_positions = 3
	is_medical = 1
	supervisors = "the chief medical officer"
	selection_color = "#ffeef0"
	idtype = /obj/item/weapon/card/id/medical
	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_mineral_storeroom)
	minimal_access = list(access_medical, access_morgue, access_surgery, access_maint_tunnels)
	minimal_player_age = 3

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_or_collect(new /obj/item/device/radio/headset/headset_med(H), slot_l_ear)
		switch(H.backbag)
			if(2) H.equip_or_collect(new /obj/item/weapon/storage/backpack/medic(H), slot_back)
			if(3) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_med(H), slot_back)
			if(4) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		H.equip_or_collect(new /obj/item/clothing/under/rank/medical(H), slot_w_uniform)
		H.equip_or_collect(new /obj/item/clothing/suit/storage/labcoat(H), slot_wear_suit)
		H.equip_or_collect(new /obj/item/clothing/shoes/white(H), slot_shoes)
		H.equip_or_collect(new /obj/item/device/pda/medical(H), slot_wear_pda)
		H.equip_or_collect(new /obj/item/weapon/storage/firstaid/adv(H), slot_l_hand)
		H.equip_or_collect(new /obj/item/device/flashlight/pen(H), slot_s_store)
		H.equip_or_collect(new /obj/item/weapon/storage/box/survival(H), slot_in_backpack)
		return 1



//Chemist is a medical job damnit	//YEAH FUCK YOU SCIENCE	-Pete	//Guys, behave -Erro
/datum/job/chemist
	title = "Chemist"
	flag = CHEMIST
	department_flag = MEDSCI
	total_positions = 1
	spawn_positions = 1
	is_medical = 1
	supervisors = "the chief medical officer"
	selection_color = "#ffeef0"
	idtype = /obj/item/weapon/card/id/medical
	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_mineral_storeroom)
	minimal_access = list(access_medical, access_chemistry, access_maint_tunnels, access_mineral_storeroom)
	minimal_player_age = 7

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		switch(H.backbag)
			if(2) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/chemistry(H), slot_back)
			if(3) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/satchel_chem(H), slot_back)
			if(4) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/headset_med(H), slot_l_ear)
		H.equip_or_collect(new /obj/item/clothing/glasses/science(H), slot_glasses)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chemist(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/device/pda/chemist(H), slot_wear_pda)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat/chemist(H), slot_wear_suit)
		H.equip_or_collect(new /obj/item/weapon/storage/box/survival(H), slot_in_backpack)
		return 1

/datum/job/paramedic
	title = "Paramedic"
	flag = PARAMEDIC
	department_flag = MEDSCI
	total_positions = 1
	spawn_positions = 1
	is_medical = 1
	supervisors = "the chief medical officer"
	selection_color = "#ffeef0"
	idtype = /obj/item/weapon/card/id/medical
	access = list(access_paramedic, access_medical, access_sec_doors, access_maint_tunnels, access_external_airlocks, access_morgue)
	minimal_access=list(access_paramedic, access_medical, access_sec_doors, access_maint_tunnels, access_external_airlocks, access_morgue)
	minimal_player_age = 3

	equip(var/mob/living/carbon/human/H)
		if(!H)  return 0
		H.equip_or_collect(new /obj/item/device/radio/headset/headset_med(H), slot_l_ear)
		if(H.backbag == 2) H.equip_or_collect(new /obj/item/weapon/storage/backpack/medic (H), slot_back)
		if(H.backbag == 3) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_med(H), slot_back)
		H.equip_or_collect(new /obj/item/clothing/under/rank/medical/paramedic(H), slot_w_uniform)
		H.equip_or_collect(new /obj/item/clothing/shoes/black(H), slot_shoes)
		H.equip_or_collect(new /obj/item/device/pda/medical(H), slot_wear_pda)
		H.equip_or_collect(new /obj/item/clothing/mask/cigarette(H), slot_wear_mask)
		H.equip_or_collect(new /obj/item/clothing/head/soft/blue(H), slot_head)
		H.equip_or_collect(new /obj/item/device/flashlight/pen(H), slot_s_store)
		H.equip_or_collect(new /obj/item/weapon/storage/box/engineer(H), slot_in_backpack)
		H.equip_or_collect(new /obj/item/device/healthanalyzer(H), slot_in_backpack)
		return 1
