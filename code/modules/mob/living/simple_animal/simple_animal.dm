/mob/living/simple_animal
	name = "animal"
	icon = 'icons/mob/animal.dmi'
	health = 20
	maxHealth = 20
	universal_understand = 1
	status_flags = CANPUSH

	var/icon_living = ""
	var/icon_dead = ""
	var/icon_resting = ""
	var/icon_gib = null	//We only try to show a gibbing animation if this exists.

	var/oxygen_alert = 0
	var/toxins_alert = 0
	var/fire_alert = 0
	var/healable = 1

	var/list/speak = list()
	var/speak_chance = 0
	var/list/emote_hear = list()	//Hearable emotes
	var/list/emote_see = list()		//Unlike speak_emote, the list of things in this variable only show by themselves with no spoken text. IE: Ian barks, Ian yaps

	var/turns_per_move = 1
	var/turns_since_move = 0
	universal_speak = 0
	var/stop_automated_movement = 0 //Use this to temporarely stop random movement or to if you write special movement code for animals.
	var/wander = 1	// Does the mob wander around when idle?
	var/stop_automated_movement_when_pulled = 1 //When set to 1 this stops the animal from moving when someone is pulling it.

	//Interaction
	var/response_help   = "pokes"
	var/response_disarm = "shoves"
	var/response_harm   = "hits"
	var/harm_intent_damage = 3
	var/force_threshold = 0 //Minimum force required to deal any damage

	//Temperature effect
	var/minbodytemp = 250
	var/maxbodytemp = 350
	var/heat_damage_per_tick = 3	//amount of damage applied if animal's body temperature is higher than maxbodytemp
	var/cold_damage_per_tick = 2	//same as heat_damage_per_tick, only if the bodytemperature it's lower than minbodytemp

	//Atmos effect - Yes, you can make creatures that require plasma or co2 to survive. N2O is a trace gas and handled separately, hence why it isn't here. It'd be hard to add it. Hard and me don't mix (Yes, yes make all the dick jokes you want with that.) - Errorage
	var/list/atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0) //Leaving something at 0 means it's off - has no maximum
	var/unsuitable_atmos_damage = 2	//This damage is taken when atmos doesn't fit all the requirements above


	//LETTING SIMPLE ANIMALS ATTACK? WHAT COULD GO WRONG. Defaults to zero so Ian can still be cuddly
	var/melee_damage_lower = 0
	var/melee_damage_upper = 0
	var/armour_penetration = 0 //How much armour they ignore, as a flat reduction from the targets armour value
	var/melee_damage_type = BRUTE //Damage type of a simple mob's melee attack, should it do damage.
	var/list/damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 1) // 1 for full damage , 0 for none , -1 for 1:1 heal from that source
	var/attacktext = "attacks"
	var/attack_sound = null
	var/friendly = "nuzzles" //If the mob does no damage with it's attack
	var/environment_smash = 0 //Set to 1 to allow breaking of crates,lockers,racks,tables; 2 for walls; 3 for Rwalls

	var/speed = 1 //LETS SEE IF I CAN SET SPEEDS FOR SIMPLE MOBS WITHOUT DESTROYING EVERYTHING. Higher speed is slower, negative speed is faster
	var/can_hide    = 0

	var/obj/item/clothing/accessory/petcollar/collar = null
	var/can_collar = 0 // can add collar to mob or not

//Hot simple_animal baby making vars
	var/childtype = null
	var/scan_ready = 1
	var/simplespecies //Sorry, no spider+corgi buttbabies.

	var/gold_core_spawnable = CHEM_MOB_SPAWN_INVALID //if CHEM_MOB_SPAWN_HOSTILE can be spawned by plasma with gold core, CHEM_MOB_SPAWN_FRIENDLY are 'friendlies' spawned with blood

	var/master_commander = null //holding var for determining who own/controls a sentient simple animal (for sentience potions).

	var/mob/living/simple_animal/hostile/spawner/nest

	var/sentience_type = SENTIENCE_ORGANIC // Sentience type, for slime potions
	var/list/loot = list() //list of things spawned at mob's loc when it dies
	var/del_on_death = 0 //causes mob to be deleted on death, useful for mobs that spawn lootable corpses
	var/deathmessage = ""
	var/death_sound = null //The sound played on death
//Hostilities et al.
	//Hostility settings
	var/hostile = 0					// Do I even attack?
	var/retaliate = 0				// I respond to damage against specific targets.
	var/atom/target
	var/ranged = 0
	var/rapid = 0
	var/projectiletype
	var/projectilesound
	var/casingtype
	var/move_to_delay = 3 //delay for the automated movement.
	var/list/friends = list()
	var/list/enemies = list()
	var/ranged_message = "fires" //Fluff text for ranged mobs
	var/ranged_cooldown = 0 //What the starting cooldown is on ranged attacks
	var/ranged_cooldown_time = 30 //How long, in deciseconds, the cooldown of ranged attacks is
	var/ranged_ignores_vision = FALSE //if it'll fire ranged attacks even if it lacks vision on its target, only works with environment smash
	var/check_friendly_fire = 0 // Should the ranged mob check for friendlies when shooting
	var/retreat_distance = null //If our mob runs from players when they're too close, set in tile distance. By default, mobs do not retreat.
	var/minimum_distance = 1 //Minimum approach distance, so ranged mobs chase targets down, but still keep their distance set in tiles to the target, set higher to make mobs keep distance

//These vars are related to how mobs locate and target
	var/robust_searching = 0 //By default, mobs have a simple searching method, set this to 1 for the more scrutinous searching (stat_attack, stat_exclusive, etc), should be disabled on most mobs
	var/vision_range = 9 //How big of an area to search for targets in, a vision of 9 attempts to find targets as soon as they walk into screen view
	var/aggro_vision_range = 9 //If a mob is aggro, we search in this radius. Defaults to 9 to keep in line with original simple mob aggro radius
	var/idle_vision_range = 9 //If a mob is just idling around, it's vision range is limited to this. Defaults to 9 to keep in line with original simple mob aggro radius
	var/search_objects = 0 //If we want to consider objects when searching around, set this to 1. If you want to search for objects while also ignoring mobs until hurt, set it to 2. To completely ignore mobs, even when attacked, set it to 3
	var/list/wanted_objects = list() //A list of objects that will be checked against to attack, should we have search_objects enabled
	var/stat_attack = 0 //Mobs with stat_attack to 1 will attempt to attack things that are unconscious, Mobs with stat_attack set to 2 will attempt to attack the dead.
	var/stat_exclusive = 0 //Mobs with this set to 1 will exclusively attack things defined by stat_attack, stat_attack 2 means they will only attack corpses
	var/attack_same = 0 //Set us to 1 to allow us to attack our own faction, or 2, to only ever attack our own faction

	var/AIStatus = AI_ON //The Status of our AI, can be set to AI_ON (On, usual processing), AI_IDLE (Will not process, but will return to AI_ON if an enemy comes near), AI_OFF (Off, Not processing ever)

	//typecache of things this mob will attack in DestroySurroundings() if it has environment_smash
	var/list/environment_target_typecache = list(
	/obj/machinery/door/window,
	/obj/structure/window,
	/obj/structure/closet,
	/obj/structure/table,
	/obj/structure/grille,
	/obj/structure/girder,
	/obj/structure/rack,
	/obj/structure/barricade) //turned into a typecache in New()
	var/atom/targets_from = null //all range/attack/etc. calculations should be done from this atom, defaults to the mob itself, useful for Vehicles and such
	var/list/emote_taunt = list()
	var/taunt_chance = 0



/mob/living/simple_animal/New()
	..()
	simple_animal_list += src
	verbs -= /mob/verb/observe
	if(!can_hide)
		verbs -= /mob/living/simple_animal/verb/hide
	if(collar)
		if(!istype(collar))
			collar = new(src)
		regenerate_icons()
	if(hostile || retaliate)
		if(!targets_from)
			targets_from = src
		environment_target_typecache = typecacheof(environment_target_typecache)

/mob/living/simple_animal/Destroy()
	if(collar)
		collar.forceMove(loc)
		collar = null
	master_commander = null
	simple_animal_list -= src
	if(hostile || retaliate)
		targets_from = null
		target = null
	return ..()

/mob/living/simple_animal/Life()
	. = ..()
	if(!.)
		if(hostile  || retaliate)
			walk(src, 0)
			return 0


/mob/living/simple_animal/Login()
	if(src && src.client)
		src.client.screen = list()
		client.screen += client.void
	..()

/mob/living/simple_animal/updatehealth()
	..()
	health = Clamp(health, 0, maxHealth)

/mob/living/simple_animal/handle_hud_icons_health()
	..()
	if(healths && maxHealth > 0)
		switch(health / maxHealth * 30)
			if(30 to INFINITY)		healths.icon_state = "health0"
			if(26 to 29)			healths.icon_state = "health1"
			if(21 to 25)			healths.icon_state = "health2"
			if(16 to 20)			healths.icon_state = "health3"
			if(11 to 15)			healths.icon_state = "health4"
			if(6 to 10)				healths.icon_state = "health5"
			if(1 to 5)				healths.icon_state = "health6"
			if(0)					healths.icon_state = "health7"

/mob/living/simple_animal/proc/process_ai()
	handle_automated_movement()
	handle_automated_action()
	handle_automated_speech()
	if(hostile || retaliate)
		if(!AICanContinue())
			return 0
		return 1

/mob/living/simple_animal/lay_down()
	..()
	handle_resting_state_icons()

/mob/living/simple_animal/proc/handle_resting_state_icons()
	if(icon_resting)
		if(resting && stat != DEAD)
			icon_state = icon_resting
		else if(stat != DEAD)
			icon_state = icon_living

/mob/living/simple_animal/handle_regular_status_updates()
	if(..()) //alive
		if(health < 1)
			death()
			return 0
		return 1

/mob/living/simple_animal/proc/handle_automated_action()
	if(hostile || retaliate)
		if(AIStatus == AI_OFF)
			return 0
		var/list/possible_targets = ListTargets() //we look around for potential targets and make it a list for later use.
		if(environment_smash)
			EscapeConfinement()

		if(AICanContinue(possible_targets))
			DestroySurroundings()
			if(!MoveToTarget(possible_targets))     //if we lose our target
				if(AIShouldSleep(possible_targets))	// we try to acquire a new one
					AIStatus = AI_IDLE				// otherwise we go idle
		return 1

	else
		return

/mob/living/simple_animal/proc/handle_automated_movement()
	if(!stop_automated_movement && wander)
		if(isturf(src.loc) && !resting && !buckled && canmove)		//This is so it only moves if it's not inside a closet, gentics machine, etc.
			turns_since_move++
			if(turns_since_move >= turns_per_move)
				if(!(stop_automated_movement_when_pulled && pulledby)) //Soma animals don't move when pulled
					var/anydir = pick(cardinal)
					if(Process_Spacemove(anydir))
						Move(get_step(src,anydir), anydir)
						turns_since_move = 0
			return

/mob/living/simple_animal/proc/handle_automated_speech()
	if(speak_chance)
		if(rand(0,200) < speak_chance)
			if(speak && speak.len)
				if((emote_hear && emote_hear.len) || (emote_see && emote_see.len))
					var/length = speak.len
					if(emote_hear && emote_hear.len)
						length += emote_hear.len
					if(emote_see && emote_see.len)
						length += emote_see.len
					var/randomValue = rand(1,length)
					if(randomValue <= speak.len)
						say(pick(speak))
					else
						randomValue -= speak.len
						if(emote_see && randomValue <= emote_see.len)
							custom_emote(1, pick(emote_see))
						else
							custom_emote(2, pick(emote_hear))
				else
					say(pick(speak))
			else
				if(!(emote_hear && emote_hear.len) && (emote_see && emote_see.len))
					custom_emote(1, pick(emote_see))
				if((emote_hear && emote_hear.len) && !(emote_see && emote_see.len))
					custom_emote(2, pick(emote_hear))
				if((emote_hear && emote_hear.len) && (emote_see && emote_see.len))
					var/length = emote_hear.len + emote_see.len
					var/pick = rand(1,length)
					if(pick <= emote_see.len)
						custom_emote(1, pick(emote_see))
					else
						custom_emote(2,pick(emote_hear))


/mob/living/simple_animal/handle_environment(datum/gas_mixture/environment)
	var/atmos_suitable = 1

	var/areatemp = get_temperature(environment)

	if(abs(areatemp - bodytemperature) > 40 && !(flags & NO_BREATHE))
		var/diff = areatemp - bodytemperature
		diff = diff / 5
		bodytemperature += diff

	var/tox = environment.toxins
	var/oxy = environment.oxygen
	var/n2 = environment.nitrogen
	var/co2 = environment.carbon_dioxide

	if(atmos_requirements["min_oxy"] && oxy < atmos_requirements["min_oxy"])
		atmos_suitable = 0
		throw_alert("oxy", /obj/screen/alert/oxy)
	else if(atmos_requirements["max_oxy"] && oxy > atmos_requirements["max_oxy"])
		atmos_suitable = 0
		throw_alert("oxy", /obj/screen/alert/too_much_oxy)
	else
		clear_alert("oxy")

	if(atmos_requirements["min_tox"] && tox < atmos_requirements["min_tox"])
		atmos_suitable = 0
		throw_alert("tox_in_air", /obj/screen/alert/not_enough_tox)
	else if(atmos_requirements["max_tox"] && tox > atmos_requirements["max_tox"])
		atmos_suitable = 0
		throw_alert("tox_in_air", /obj/screen/alert/tox_in_air)
	else
		clear_alert("tox_in_air")

	if(atmos_requirements["min_n2"] && n2 < atmos_requirements["min_n2"])
		atmos_suitable = 0
	else if(atmos_requirements["max_n2"] && n2 > atmos_requirements["max_n2"])
		atmos_suitable = 0

	if(atmos_requirements["min_co2"] && co2 < atmos_requirements["min_co2"])
		atmos_suitable = 0
	else if(atmos_requirements["max_co2"] && co2 > atmos_requirements["max_co2"])
		atmos_suitable = 0

	if(!atmos_suitable)
		adjustBruteLoss(unsuitable_atmos_damage)

	handle_temperature_damage()

/mob/living/simple_animal/proc/handle_temperature_damage()
	if(bodytemperature < minbodytemp)
		adjustBruteLoss(cold_damage_per_tick)
	else if(bodytemperature > maxbodytemp)
		adjustBruteLoss(heat_damage_per_tick)

/mob/living/simple_animal/gib()
	if(icon_gib)
		flick(icon_gib, src)
	if(butcher_results)
		for(var/path in butcher_results)
			for(var/i = 1; i <= butcher_results[path];i++)
				new path(src.loc)
	..()


/mob/living/simple_animal/blob_act()
	adjustBruteLoss(20)
	return

/mob/living/simple_animal/emote(var/act, var/m_type=1, var/message = null)
	if(stat)
		return
	act = lowertext(act)
	switch(act) //IMPORTANT: Emotes MUST NOT CONFLICT anywhere along the chain.
		if("scream")
			message = "<B>\The [src]</B> whimpers."
			m_type = 2

	..(act, m_type, message)

/mob/living/simple_animal/attack_animal(mob/living/simple_animal/M as mob)
	if(M.melee_damage_upper == 0)
		M.custom_emote(1, "[M.friendly] [src]")
	else
		M.do_attack_animation(src)
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 50, 1, 1)
		visible_message("<span class='danger'>\The [M] [M.attacktext] [src]!</span>", \
				"<span class='userdanger'>\The [M] [M.attacktext] [src]!</span>")
		add_logs(M, src, "attacked", admin=0, print_attack_log = 0)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		attack_threshold_check(damage,M.melee_damage_type)

/mob/living/simple_animal/proc/attacked_by(obj/item/I, mob/living/user) // Handled in _onclick/click.dm
	if(stat == CONSCIOUS && !target && AIStatus != AI_OFF && !client && user)
		if(hostile || retaliate)
			FindTarget(list(user), 1)

	return

/mob/living/simple_animal/bullet_act(var/obj/item/projectile/Proj)
	if(!Proj)
		return
	if((Proj.damage_type != STAMINA))
		adjustBruteLoss(Proj.damage)
		Proj.on_hit(src, 0)
	return 0

/mob/living/simple_animal/attack_hand(mob/living/carbon/human/M as mob)
	..()

	switch(M.a_intent)

		if(I_HELP)
			if(health > 0)
				visible_message("<span class='notice'> [M] [response_help] [src].</span>")
				playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)

		if(I_GRAB)
			if(M == src || anchored)
				return
			if(!(status_flags & CANPUSH))
				return

			var/obj/item/weapon/grab/G = new /obj/item/weapon/grab(M, src )

			M.put_in_active_hand(G)

			G.synch()

			LAssailant = M

			visible_message("<span class='warning'>[M] has grabbed [src] passively!</span>")
			playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)

		if(I_HARM, I_DISARM)
			M.do_attack_animation(src)
			visible_message("<span class='danger'>[M] [response_harm] [src]!</span>")
			playsound(loc, "punch", 25, 1, -1)
			attack_threshold_check(harm_intent_damage)

	return

/mob/living/simple_animal/attack_alien(mob/living/carbon/alien/humanoid/M as mob)

	switch(M.a_intent)

		if(I_HELP)

			visible_message("<span class='notice'>[M] caresses [src] with its scythe like arm.</span>")
		if(I_GRAB)
			grabbedby(M)

		if(I_HARM, I_DISARM)
			M.do_attack_animation(src)
			var/damage = rand(15, 30)
			visible_message("<span class='danger'>[M] has slashed at [src]!</span>", \
					"<span class='userdanger'>[M] has slashed at [src]!</span>")
			playsound(loc, 'sound/weapons/slice.ogg', 25, 1, -1)
			attack_threshold_check(damage)

	return

/mob/living/simple_animal/attack_larva(mob/living/carbon/alien/larva/L as mob)

	switch(L.a_intent)
		if(I_HELP)
			visible_message("<span class='notice'>[L] rubs its head against [src].</span>")


		else
			L.do_attack_animation(src)
			var/damage = rand(5, 10)
			visible_message("<span class='danger'>[L] bites [src]!</span>", \
					"<span class='userdanger'>[L] bites [src]!</span>")
			playsound(loc, 'sound/weapons/bite.ogg', 50, 1, -1)

			if(stat != DEAD)
				L.amount_grown = min(L.amount_grown + damage, L.max_grown)
				attack_threshold_check(damage)


/mob/living/simple_animal/attack_slime(mob/living/carbon/slime/M as mob)
	if(!ticker)
		to_chat(M, "You cannot attack people before the game has started.")
		return

	if(M.Victim) return // can't attack while eating!

	if(health > 0)
		M.do_attack_animation(src)
		visible_message("<span class='danger'>[M.name] glomps [src]!</span>", \
				"<span class='userdanger'>[M.name] glomps [src]!</span>")

		var/damage = rand(1, 3)

		if(M.is_adult)
			damage = rand(20, 40)
		else
			damage = rand(5, 35)

		attack_threshold_check(damage)


	return

/mob/living/simple_animal/attackby(var/obj/item/O as obj, var/mob/living/user as mob)  //Marker -Agouri
	if(can_collar && !collar && istype(O, /obj/item/clothing/accessory/petcollar))
		var/obj/item/clothing/accessory/petcollar/C = O
		user.drop_item()
		C.forceMove(src)
		collar = C
		collar.equipped(src)
		regenerate_icons()
		to_chat(usr, "<span class='notice'>You put \the [C] around \the [src]'s neck.</span>")
		if(C.tagname)
			name = C.tagname
			real_name = C.tagname
		return
	else
		user.changeNext_move(CLICK_CD_MELEE)
		if(attempt_harvest(O, user))
			return
		user.do_attack_animation(src)
		if(istype(O) && istype(user) && !O.attack(src, user))
			var/damage = 0
			if(O.force)
				if(O.force >= force_threshold)
					damage = O.force
					if(O.damtype == STAMINA)
						damage = 0
					visible_message("<span class='danger'>[user] has [O.attack_verb.len ? "[pick(O.attack_verb)]": "attacked"] [src] with [O]!</span>",\
									"<span class='userdanger'>[user] has [O.attack_verb.len ? "[pick(O.attack_verb)]": "attacked"] you with [O]!</span>")
				else
					visible_message("<span class='danger'>[O] bounces harmlessly off of [src].</span>",\
									"<span class='userdanger'>[O] bounces harmlessly off of [src].</span>")
			else
				user.visible_message("<span class='warning'>[user] gently taps [src] with [O].</span>",\
									"<span class='warning'>This weapon is ineffective, it does no damage.</span>")
			adjustBruteLoss(damage)


/mob/living/simple_animal/movement_delay()
	. = ..()

	. = speed

	. += config.animal_delay

/mob/living/simple_animal/Stat()
	..()

	statpanel("Status")
	stat(null, "Health: [round((health / maxHealth) * 100)]%")

/mob/living/simple_animal/death(gibbed)
	if(nest)
		nest.spawned_mobs -= src
		nest = null
	if(loot.len)
		for(var/i in loot)
			new i(loc)
	if(!gibbed)
		if(death_sound)
			playsound(get_turf(src),death_sound, 200, 1)
		if(deathmessage)
			visible_message("<span class='danger'>\The [src] [deathmessage]</span>")
		else if(!del_on_death)
			visible_message("<span class='danger'>\The [src] stops moving...</span>")
	if(del_on_death)
		ghostize()
		qdel(src)
	else
		health = 0
		icon_state = icon_dead
		stat = DEAD
		density = 0
		lying = 1
	..()

/mob/living/simple_animal/ex_act(severity)
	..()
	switch(severity)
		if(1.0)
			gib()
			return

		if(2.0)
			adjustBruteLoss(60)


		if(3.0)
			adjustBruteLoss(30)

/mob/living/simple_animal/proc/adjustHealth(amount)
	if(status_flags & GODMODE)
		return 0
	bruteloss = Clamp(bruteloss + amount, 0, maxHealth)
	handle_regular_status_updates()
	if(retaliate)
		Retaliate()

/mob/living/simple_animal/adjustBruteLoss(amount)
	if(damage_coeff[BRUTE])
		adjustHealth(amount * damage_coeff[BRUTE])

/mob/living/simple_animal/adjustFireLoss(amount)
	if(damage_coeff[BURN])
		adjustHealth(amount * damage_coeff[BURN])

/mob/living/simple_animal/adjustOxyLoss(amount)
	if(damage_coeff[OXY])
		adjustHealth(amount * damage_coeff[OXY])

/mob/living/simple_animal/adjustToxLoss(amount)
	if(damage_coeff[TOX])
		adjustHealth(amount * damage_coeff[TOX])

/mob/living/simple_animal/adjustCloneLoss(amount)
	if(damage_coeff[CLONE])
		adjustHealth(amount * damage_coeff[CLONE])

/mob/living/simple_animal/adjustStaminaLoss(amount)
	if(damage_coeff[STAMINA])
		return ..(amount*damage_coeff[STAMINA])

/mob/living/simple_animal/proc/CanAttack(var/atom/the_target)
	if(see_invisible < the_target.invisibility)
		return 0
	if(isliving(the_target))
		var/mob/living/L = the_target
		if(L.stat != CONSCIOUS)
			return 0
	if(istype(the_target, /obj/mecha))
		var/obj/mecha/M = the_target
		if(M.occupant)
			return 0
	if(istype(the_target,/obj/spacepod))
		var/obj/spacepod/S = the_target
		if(S.pilot)
			return 0
	return 1

/mob/living/simple_animal/handle_fire()
	return

/mob/living/simple_animal/update_fire()
	return

/mob/living/simple_animal/IgniteMob()
	return 0

/mob/living/simple_animal/ExtinguishMob()
	return

/mob/living/simple_animal/proc/attack_threshold_check(damage, damagetype = BRUTE)
	if(damage <= force_threshold || !damage_coeff[damagetype])
		visible_message("<span class='warning'>[src] looks unharmed from the damage.</span>")
	else
		apply_damage(damage, damagetype)

/mob/living/simple_animal/update_transform()
	var/matrix/ntransform = matrix(transform) //aka transform.Copy()
	var/changed = 0

	if(resize != RESIZE_DEFAULT_SIZE)
		changed++
		ntransform.Scale(resize)
		resize = RESIZE_DEFAULT_SIZE

	if(changed)
		animate(src, transform = ntransform, time = 2, easing = EASE_IN|EASE_OUT)

/mob/living/simple_animal/revive()
	..()
	health = maxHealth
	icon_state = icon_living
	density = initial(density)
	update_canmove()



/mob/living/simple_animal/proc/make_babies() // <3 <3 <3
	if(gender != FEMALE || stat || !scan_ready || !childtype || !simplespecies)
		return
	scan_ready = 0
	spawn(400)
		scan_ready = 1
	var/alone = 1
	var/mob/living/simple_animal/partner
	var/children = 0
	for(var/mob/M in oview(7, src))
		if(istype(M, childtype)) //Check for children FIRST.
			children++
		else if(istype(M, simplespecies))
			if(M.client)
				continue
			else if(!istype(M, childtype) && M.gender == MALE) //Better safe than sorry ;_;
				partner = M
		else if(istype(M, /mob/))
			alone = 0
			continue
	if(alone && partner && children < 3)
		new childtype(loc)

/mob/living/simple_animal/say_quote(var/message)
	var/verb = "says"

	if(speak_emote.len)
		verb = pick(speak_emote)

	return verb

/mob/living/simple_animal/update_canmove(delay_action_updates = 0)
	if(paralysis || stunned || weakened || stat || resting)
		drop_r_hand()
		drop_l_hand()
		canmove = 0
	else if(buckled)
		canmove = 0
	else
		canmove = 1
	update_transform()
	if(!delay_action_updates)
		update_action_buttons_icon()
	return canmove

/mob/living/simple_animal/update_transform()
	var/matrix/ntransform = matrix(transform) //aka transform.Copy()
	var/changed = 0

	if(resize != RESIZE_DEFAULT_SIZE)
		changed++
		ntransform.Scale(resize)
		resize = RESIZE_DEFAULT_SIZE

	if(changed)
		animate(src, transform = ntransform, time = 2, easing = EASE_IN|EASE_OUT)

/* Inventory */

/mob/living/simple_animal/show_inv(mob/user as mob)
	if(!can_collar)
		return

	user.set_machine(src)
	var/dat = "<table><tr><td><B>Collar:</B></td><td><A href='?src=[UID()];item=[slot_collar]'>[(collar && !(collar.flags&ABSTRACT)) ? collar : "<font color=grey>Empty</font>"]</A></td></tr></table>"
	dat += "<A href='?src=[user.UID()];mach_close=mob\ref[src]'>Close</A>"

	var/datum/browser/popup = new(user, "mob\ref[src]", "[src]", 440, 250)
	popup.set_content(dat)
	popup.open()

/mob/living/simple_animal/get_item_by_slot(slot_id)
	switch(slot_id)
		if(slot_collar)
			return collar
	. = ..()

/mob/living/simple_animal/can_equip(obj/item/I, slot, disable_warning = 0)
	// . = ..() // Do not call parent. We do not want animals using their hand slots.
	switch(slot)
		if(slot_collar)
			if(collar)
				return 0
			if(!can_collar)
				return 0
			if(!istype(I, /obj/item/clothing/accessory/petcollar))
				return 0
			return 1

/mob/living/simple_animal/equip_to_slot(obj/item/W, slot)
	if(!istype(W))
		return 0

	if(!slot)
		return 0

	W.forceMove(src)
	W.equipped(src, slot)
	W.layer = 20
	W.plane = HUD_PLANE

	switch(slot)
		if(slot_collar)
			collar = W
			if(collar.tagname)
				name = collar.tagname
				real_name = collar.tagname
			regenerate_icons()

/mob/living/simple_animal/unEquip(obj/item/I, force)
	. = ..()
	if(!. || !I)
		return

	if(I == collar)
		collar = null
		regenerate_icons()

/mob/living/simple_animal/get_access()
	. = ..()
	if(collar)
		. |= collar.GetAccess()

/* End Inventory */

/mob/living/simple_animal/proc/sentience_act() //Called when a simple animal gains sentience via gold slime potion
	return

/mob/living/simple_animal/update_sight(reset_sight = FALSE)
	if(!client)
		return
	if(stat == DEAD)
		grant_death_vision()
		return

	if(reset_sight)
		see_invisible = initial(see_invisible)
		see_in_dark = initial(see_in_dark)
		sight = initial(sight)

	if(client.eye != src)
		var/atom/A = client.eye
		if(A.update_remote_sight(src)) //returns 1 if we override all other sight updates.
			return

/mob/living/simple_animal/SetEarDamage()
	return

/mob/living/simple_animal/SetEarDeaf()
	return

//////////////HOSTILE MOB TARGETTING AND AGGRESSION////////////

/mob/living/simple_animal/proc/ListTargets()//Step 1, find out what we can see
	. = list()
	if(!search_objects)
		var/list/Mobs = hearers(vision_range, targets_from) - src //Remove self, so we don't suicide
		. += Mobs

		var/static/hostile_machines = typecacheof(list(/obj/machinery/porta_turret, /obj/mecha, /obj/spacepod))

		for(var/HM in typecache_filter_list(range(vision_range, targets_from), hostile_machines))
			if(can_see(targets_from, HM, vision_range))
				. += HM
	else
		var/list/Objects = oview(vision_range, targets_from)
		. += Objects
	if(retaliate)
		if(!enemies.len)
			return list()
		var/list/see = .
		see &= enemies // Remove all entries that aren't in enemies
		return see


/mob/living/simple_animal/proc/FindTarget(var/list/possible_targets, var/HasTargetsList = 0)//Step 2, filter down possible targets to things we actually care about
	. = list()
	if(!HasTargetsList)
		possible_targets = ListTargets()
	for(var/pos_targ in possible_targets)
		var/atom/A = pos_targ
		if(Found(A))//Just in case people want to override targetting
			. = list(A)
			break
		if(CanAttack(A))//Can we attack it?
			. += A
			continue
	var/Target = PickTarget(.)
	GiveTarget(Target)
	return Target //We now have a target

/mob/living/simple_animal/proc/GiveTarget(new_target)//Step 4, give us our selected target
	target = new_target
	if(target != null)
		Aggro()
		return 1

/mob/living/simple_animal/proc/PickTarget(list/Targets)//Step 3, pick amongst the possible, attackable targets
	if(target != null)//If we already have a target, but are told to pick again, calculate the lowest distance between all possible, and pick from the lowest distance targets
		for(var/pos_targ in Targets)
			var/atom/A = pos_targ
			var/target_dist = get_dist(targets_from, target)
			var/possible_target_distance = get_dist(targets_from, A)
			if(target_dist < possible_target_distance)
				Targets -= A
	if(!Targets.len)//We didnt find nothin!
		return
	var/chosen_target = pick(Targets)//Pick the remaining targets (if any) at random
	return chosen_target


/mob/living/simple_animal/proc/MoveToTarget(var/list/possible_targets)//Step 5, handle movement between us and our target
	stop_automated_movement = 1
	if(!target || !CanAttack(target))
		LoseTarget()
		return 0
	if(target in possible_targets)
		if(target.z != z)
			LoseTarget()
			return 0
		var/target_distance = get_dist(targets_from,target)
		if(ranged) //We ranged? Shoot at em
			if(!target.Adjacent(targets_from) && ranged_cooldown <= world.time) //But make sure they're not in range for a melee attack and our range attack is off cooldown
				OpenFire(target)
		if(retreat_distance != null) //If we have a retreat distance, check if we need to run from our target
			if(target_distance <= retreat_distance) //If target's closer than our retreat distance, run
				walk_away(src,target,retreat_distance,move_to_delay)
			else
				Goto(target,move_to_delay,minimum_distance) //Otherwise, get to our minimum distance so we chase them
		else
			Goto(target,move_to_delay,minimum_distance)
		if(target)
			if(targets_from && isturf(targets_from.loc) && target.Adjacent(targets_from)) //If they're next to us, attack
				AttackingTarget()
			return 1
		return 0
	if(environment_smash)
		if(target.loc != null && get_dist(targets_from, target.loc) <= vision_range) //We can't see our target, but he's in our vision range still
			if(ranged_ignores_vision && ranged_cooldown <= world.time) //we can't see our target... but we can fire at them!
				OpenFire(target)
			if(environment_smash >= 2) //If we're capable of smashing through walls, forget about vision completely after finding our target
				Goto(target,move_to_delay,minimum_distance)
				FindHidden()
				return 1
			else
				if(FindHidden())
					return 1
	LoseTarget()
	return 0


/mob/living/simple_animal/proc/Goto(target, delay, minimum_distance)
	walk_to(src, target, minimum_distance, delay)


/mob/living/simple_animal/hostile/proc/PossibleThreats()
	. = list()
	for(var/pos_targ in ListTargets())
		var/atom/A = pos_targ
		if(Found(A))
			. = list(A)
			break
		if(CanAttack(A))
			. += A
			continue

/mob/living/simple_animal/proc/Retaliate()
	..()
	var/list/around = view(src, 7)

	for(var/atom/movable/A in around)
		if(A == src)
			continue
		if(isliving(A))
			var/mob/living/M = A
			var/faction_check = 0
			for(var/F in faction)
				if(F in M.faction)
					faction_check = 1
					break
			if(faction_check && attack_same || !faction_check)
				enemies |= M
		else if(istype(A, /obj/mecha))
			var/obj/mecha/M = A
			if(M.occupant)
				enemies |= M
				enemies |= M.occupant
		else if(istype(A, /obj/spacepod))
			var/obj/spacepod/M = A
			if(M.pilot)
				enemies |= M
				enemies |= M.pilot

	for(var/mob/living/simple_animal/hostile/retaliate/H in around)
		var/retaliate_faction_check = 0
		for(var/F in faction)
			if(F in H.faction)
				retaliate_faction_check = 1
				break
		if(retaliate_faction_check && !attack_same && !H.attack_same)
			H.enemies |= enemies
	return 0

/mob/living/simple_animal/proc/Found(var/atom/A)//This is here as a potential override to pick a specific target if available
	if(retaliate)
		if(isliving(A))
			var/mob/living/L = A
			if(!L.stat)
				return L
			else
				enemies -= L
		else if(istype(A, /obj/mecha))
			var/obj/mecha/M = A
			if(M.occupant)
				return A
		else if(istype(A, /obj/spacepod))
			var/obj/spacepod/M = A
			if(M.pilot)
				return A

	else
		return

/mob/living/simple_animal/proc/OpenFire(atom/A)
	if(check_friendly_fire)
		for(var/turf/T in getline(src,A)) // Not 100% reliable but this is faster than simulating actual trajectory
			for(var/mob/living/L in T)
				if(L == src || L == A)
					continue
				if(faction_check(L) && !attack_same)
					return
	visible_message("<span class='danger'><b>[src]</b> [ranged_message] at [A]!</span>")

	if(rapid)
		spawn(1)
			Shoot(A)
		spawn(4)
			Shoot(A)
		spawn(6)
			Shoot(A)
	else
		Shoot(A)
	ranged_cooldown = world.time + ranged_cooldown_time

/mob/living/simple_animal/proc/Shoot(atom/targeted_atom)
	if(targeted_atom == targets_from.loc || targeted_atom == targets_from)
		return

	var/turf/startloc = get_turf(targets_from)
	if(casingtype)
		var/obj/item/ammo_casing/casing = new casingtype(startloc)
		playsound(src, projectilesound, 100, 1)
		casing.fire(targeted_atom, src, zone_override = ran_zone())
	else if(projectiletype)
		var/obj/item/projectile/P = new projectiletype(startloc)
		playsound(src, projectilesound, 100, 1)
		P.current = startloc
		P.starting = startloc
		P.firer = src
		P.yo = targeted_atom.y - startloc.y
		P.xo = targeted_atom.x - startloc.x
		if(AIStatus != AI_ON)//Don't want mindless mobs to have their movement screwed up firing in space
			newtonian_move(get_dir(targeted_atom, targets_from))
		P.original = targeted_atom
		P.fire()
		return P


/mob/living/simple_animal/proc/DestroySurroundings()
	if(retaliate)
		for(var/dir in cardinal) // North, South, East, West
			var/obj/structure/obstacle = locate(/obj/structure, get_step(src, dir))
			if(istype(obstacle, /obj/structure/closet) || istype(obstacle, /obj/structure/table))
				obstacle.attack_animal(src)
	else
		if(environment_smash)
			EscapeConfinement()
			for(var/dir in cardinal)
				var/turf/T = get_step(targets_from, dir)
				if(iswallturf(T) || ismineralturf(T))
					if(T.Adjacent(targets_from))
						T.attack_animal(src)
				for(var/a in T)
					var/atom/A = a
					if(!A.Adjacent(targets_from))
						continue
					if(is_type_in_typecache(A, environment_target_typecache))
						A.attack_animal(src)
	return


/mob/living/simple_animal/proc/EscapeConfinement()
	if(buckled)
		buckled.attack_animal(src)
	if(!isturf(targets_from.loc) && targets_from.loc != null)//Did someone put us in something?
		var/atom/A = get_turf(targets_from)
		A.attack_animal(src)//Bang on it till we get out
	return

/mob/living/simple_animal/proc/FindHidden()
	if(istype(target.loc, /obj/structure/closet) || istype(target.loc, /obj/machinery/disposal) || istype(target.loc, /obj/machinery/sleeper) || istype(target.loc, /obj/machinery/bodyscanner) || istype(target.loc, /obj/machinery/recharge_station))
		var/atom/A = target.loc
		Goto(A,move_to_delay,minimum_distance)
		if(A.Adjacent(targets_from))
			A.attack_animal(src)
		return 1

/mob/living/simple_animal/RangedAttack(atom/A, params) //Player firing
	if(hostile || retaliate)
		if(ranged && ranged_cooldown <= world.time)
			target = A
			OpenFire(A)
	..()


/mob/living/simple_animal/proc/AICanContinue(var/list/possible_targets)
	switch(AIStatus)
		if(AI_ON)
			. = 1
		if(AI_IDLE)
			if(FindTarget(possible_targets, 1))
				. = 1
				AIStatus = AI_ON //Wake up for more than one Life() cycle.
			else
				. = 0

/mob/living/simple_animal/proc/AIShouldSleep(var/list/possible_targets)
	return !FindTarget(possible_targets, 1)

/mob/living/simple_animal/proc/AttackingTarget()
	target.attack_animal(src)

/mob/living/simple_animal/proc/LoseTarget()
	target = null
	walk(src, 0)
	LoseAggro()

/mob/living/simple_animal/proc/Aggro()
	vision_range = aggro_vision_range
	if(target && emote_taunt.len && prob(taunt_chance))
		emote("me", 1, "[pick(emote_taunt)] at [target].")
		taunt_chance = max(taunt_chance-7,2)

/mob/living/simple_animal/proc/LoseAggro()
	stop_automated_movement = 0
	vision_range = idle_vision_range
	taunt_chance = initial(taunt_chance)


/mob/living/simple_animal/hostile
	hostile = 1
	faction = list("hostile")
	stop_automated_movement_when_pulled = 0
	environment_smash = 1 //Set to 1 to break closets,tables,racks, etc; 2 for walls; 3 for rwalls

/mob/living/simple_animal/hostile/retaliate
	hostile = 0 //Clumsy, but it will spare us from map-conflicts galore.
	retaliate = 1


