/datum/disease/zombie
	//Flags
	visibility_flags = 0
	disease_flags = CURABLE|CAN_CARRY|CAN_RESIST
	spread_flags = BLOOD

	//Fluff
	form = "Virus"
	name = "Romero's Palsy"
	desc = "This insidious virus gradually transforms the victim into a mindless meat-puppet, dead by convential measures, but all too animated."
	agent = "some microbes"
	spread_text = ""
	cure_text = "Holy water, Lugosium, and other unknown reagents."

	//Stages
	stage = 1
	max_stages = 5
	stage_prob = 4

	//Other
	longevity = 150 //Time in ticks disease stays in objects, Syringes and such are infinite.
	viable_mobtypes = list() //typepaths of viable mobs
	mob/living/carbon/affected_mob = null
	atom/movable/holder = null
	cures = list("holywater","lugosium") //list of cures if the disease has the CURABLE flag, these are reagent ids
	infectivity = 65
	carrier = 0 //If our host is only a carrier
	permeability_mod = 1
	severity =	BIOHAZARD
	required_organs = list()
	needs_all_cures = TRUE
	strain_data = list() //dna_spread special bullshit



/datum/disease/zombie/stage_act()
	cure = has_cure()
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
