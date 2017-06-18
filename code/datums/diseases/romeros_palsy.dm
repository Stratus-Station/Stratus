/datum/disease/zombie
	//Flags
	var/visibility_flags = 0
	var/disease_flags = CURABLE|CAN_CARRY|CAN_RESIST
	var/spread_flags = BLOOD

	//Fluff
	var/form = "Virus"
	var/name = "Romero's Palsy"
	var/desc = "This insidious virus gradually transforms the victim into a mindless meat-puppet, dead by convential measures, but all too animated."
	var/agent = "some microbes"
	var/spread_text = ""
	var/cure_text = "Holy water, Lugosium, and other unknown reagents."

	//Stages
	var/stage = 1
	var/max_stages = 5
	var/stage_prob = 4

	//Other
	var/longevity = 150 //Time in ticks disease stays in objects, Syringes and such are infinite.
	var/list/viable_mobtypes = list() //typepaths of viable mobs
	var/mob/living/carbon/affected_mob = null
	var/atom/movable/holder = null
	var/list/cures = list("holywater","lugosium") //list of cures if the disease has the CURABLE flag, these are reagent ids
	var/infectivity = 65
	var/carrier = 0 //If our host is only a carrier
	var/permeability_mod = 1
	var/severity =	BIOHAZARD
	var/list/required_organs = list()
	var/needs_all_cures = TRUE
	var/list/strain_data = list() //dna_spread special bullshit



/datum/disease/zombie/stage_act()
	var/cure = has_cure()
	var/braincount = 0
	var/time_since_brain = 0

	if(carrier && !cure)
		return

	stage = min(stage, max_stages)

	if(!cure)
		if(prob(stage_prob))
			stage = min(stage + 1,max_stages)
	else
		if(prob(cure_chance))
			stage = max(stage - 1, 1)

	if(disease_flags & CURABLE)
		if(cure && prob(cure_chance))
			cure()
