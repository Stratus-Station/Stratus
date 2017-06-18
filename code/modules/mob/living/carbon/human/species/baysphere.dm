/datum/species/vaurca
	name = "Vaurca Worker"
//	short_name = "vau"
	name_plural = "Type A"
//	bodytype = "Vaurca"
//	age_min = 1
//	age_max = 20
	language = "Hivenet"
	primitive_form = "V'krexi"
	greater_form = "Vaurca Warrior"
	icobase = 'icons/mob/human_races/r_vaurca.dmi'
	deform = 'icons/mob/human_races/r_vaurca.dmi'
//	name_language = "Hivenet"
//	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp)
	unarmed_type = /datum/unarmed_attack/claws
//	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/vaurca
//	rarity_value = 4
	slowdown = 1
//	darksight = 8 //USELESS
	eyes = "vaurca_eyes" //makes it so that eye colour is not changed when skin colour is.
	brute_mod = 0.5
	burn_mod = 1.5 //2x was a bit too much. we'll see how this goes.
	tox_mod = 2 //they're not used to all our weird human bacteria.
	oxy_mod = 0.6
	radiation_mod = 0.2 //almost total radiation protection
	warning_low_pressure = 50
	hazard_low_pressure = 0
//	ethanol_resistance = 2
//	siemens_coefficient = 1 //setting it to 0 would be redundant due to LordLag's snowflake checks, plus batons/tasers use siemens now too.
	breath_type = "plasma"
	poison_type = "nitrogen" //a species that breathes plasma shouldn't be poisoned by it.
//	mob_size = 13 //their half an inch thick exoskeleton and impressive height, plus all of their mechanical organs.

	blurb = "Type A are the most common type of Vaurca and can be seen as the 'backbone' of Vaurcae societies. Their most prevalent feature is their hardened exoskeleton, varying in colors \
	in accordance to their hive. It is approximately half an inch thick among all Type A Vaurca. The carapace provides protection against harsh radiation, solar \
	and otherwise, and acts as a pressure-suit to seal their soft inner core from the outside world. This allows most Type A Vaurca to have extended EVA \
	expeditions, assuming they have internals. They are bipedal, and compared to warriors they are better suited for EVA and environments, and more resistant to brute force thanks to their \
	thicker carapace, but also a fair bit slower and less agile. \
	<b>Type A comfortable in any department except security. There will almost never be a Worker in a security position, as they are as a type disposed against combat.</b>"

	cold_level_1 = 50
	cold_level_2 = -1
	cold_level_3 = -1

	heat_level_1 = 330 //Default 360
	heat_level_2 = 380 //Default 400
	heat_level_3 = 600 //Default 1000
	flags = FEET_NOSLIP | IS_WHITELISTED// | NO_MINOR_CUT
//	spawn_flags = CAN_JOIN | IS_WHITELISTED
	bodyflags = HAS_SKIN_COLOR
	blood_color = "#E6E600" // dark yellow
	flesh_color = "#E6E600"
	base_color = "#575757"

	death_message = "chitters faintly before crumbling to the ground, their eyes dead and lifeless..."
//	halloss_message = "crumbles to the ground, too weak to continue fighting."

/*	list/heat_discomfort_strings = list(
		"Your blood feels like its boiling in the heat.",
		"You feel uncomfortably warm.",
		"Your carapace feels hot as the sun."
		)
	list/cold_discomfort_strings = list(
		"You chitter in the cold.",
		"You shiver suddenly.",
		"Your carapace is ice to the touch."
		)
*/

//	stamina	=	100			  // Long period of sprinting, but relatively low speed gain
//	sprint_speed_factor = 0.7
//	sprint_cost_factor = 0.30
//	stamina_recovery = 2//slow recovery


	has_organ = list(
		"neural socket" =  /obj/item/organ/internal/vaurca/neuralsocket,
		"lungs" =    /obj/item/organ/internal/lungs,
		"filtration bit" = /obj/item/organ/internal/vaurca/filtrationbit,
		"lungs" =    /obj/item/organ/internal/lungs,
		"right heart" =    /obj/item/organ/internal/heart/right,
		"plasma reserve tank" = /obj/item/organ/internal/vaurca/preserve,
		"left heart" =    /obj/item/organ/internal/heart/left,
		"liver" =    /obj/item/organ/internal/liver/vaurca,
		"kidneys" =  /obj/item/organ/internal/kidneys,
		"brain" =    /obj/item/organ/internal/brain,
		"eyes" =     /obj/item/organ/internal/eyes/vaurca
		)

/*/datum/species/bug/equip_survival_gear(var/mob/living/carbon/human/H)
	..()
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sandal(H),slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/breath(H), slot_wear_mask)
	H.gender = NEUTER
*/
/datum/species/vaurca/after_equip_job(datum/job/J, mob/living/carbon/human/H)
	if(!H.mind || !H.mind.assigned_role || H.mind.assigned_role != "Clown" && H.mind.assigned_role != "Mime")
		H.unEquip(H.wear_mask)
	H.unEquip(H.l_hand)

	H.equip_or_collect(new /obj/item/clothing/mask/breath/vox(H), slot_wear_mask)
	var/tank_pref = H.client && H.client.prefs ? H.client.prefs.speciesprefs : null
	if(tank_pref)//Diseasel, here you go
		H.equip_or_collect(new /obj/item/weapon/tank/nitrogen(H), slot_l_hand)
	else
		H.equip_or_collect(new /obj/item/weapon/tank/emergency_oxygen/vox(H), slot_l_hand)
	to_chat(H, "<span class='notice'>You are now running on plasma internals from the [H.l_hand] in your hand. Your species finds oxygen toxic, so you must breathe nitrogen only.</span>")
	H.internal = H.l_hand
	H.update_internals_hud_icon(1)

/datum/species/vaurca/handle_post_spawn(var/mob/living/carbon/human/H)
	H.gender = NEUTER
	H.butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat/vaurca = 10)
	return ..()

/mob/living/carbon/human/type_a/New(var/new_loc)
	..(new_loc, "Vaurca Worker")
	src.gender = NEUTER
