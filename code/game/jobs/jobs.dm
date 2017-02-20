
var/const/ENGSEC			=(1<<0)

var/const/CAPTAIN			=(1<<0)
var/const/HOS				=(1<<1)
var/const/WARDEN			=(1<<2)
var/const/DETECTIVE			=(1<<3)
var/const/OFFICER			=(1<<4)
var/const/CHIEF				=(1<<5)
var/const/ENGINEER			=(1<<6)
var/const/ATMOSTECH			=(1<<7)
var/const/AI				=(1<<8)
var/const/CYBORG			=(1<<9)
var/const/CENTCOM			=(1<<10)

var/const/MEDSCI			=(1<<1)

var/const/RD				=(1<<0)
var/const/SCIENTIST			=(1<<1)
var/const/CHEMIST			=(1<<2)
var/const/CMO				=(1<<3)
var/const/DOCTOR			=(1<<4)
var/const/GENETICIST		=(1<<5)
var/const/VIROLOGIST		=(1<<6)
var/const/PSYCHIATRIST		=(1<<7)
var/const/ROBOTICIST		=(1<<8)
var/const/PARAMEDIC			=(1<<9)


var/const/SUPPORT			=(1<<2)

var/const/HOP				=(1<<0)
var/const/BARTENDER			=(1<<1)
var/const/BOTANIST			=(1<<2)
var/const/CHEF				=(1<<3)
var/const/JANITOR			=(1<<4)
var/const/LIBRARIAN			=(1<<5)
var/const/QUARTERMASTER		=(1<<6)
var/const/CARGOTECH			=(1<<7)
var/const/MINER				=(1<<8)
var/const/LAWYER			=(1<<9)
var/const/CHAPLAIN			=(1<<10)
var/const/CLOWN				=(1<<11)
var/const/MIME				=(1<<12)
var/const/VISITOR			=(1<<13)


var/const/KARMA				=(1<<3)

var/const/NANO				=(1<<0)
var/const/BLUESHIELD		=(1<<1)
var/const/BARBER			=(1<<3)
var/const/EXPLORER			=(1<<4)
var/const/BRIGDOC			=(1<<5)
var/const/PILOT				=(1<<7)

var/list/assistant_occupations = list(
)


var/list/command_positions = list(
	"Captain",
	"Head of Security",
	"Chief Engineer",
	"Chief Medical Officer"
)


var/list/engineering_positions = list(
	"Chief Engineer",
	"Station Engineer",
	"Atmospherics Technician",
	"Roboticist"
)


var/list/medical_positions = list(
	"Chief Medical Officer",
	"Medical Doctor",
	"Chemist",
	"Paramedic"
)


var/list/science_positions = list(
	"Research Director",
	"Scientist",
	"Geneticist",	//Part of both medical and science
	"Roboticist",
)

//BS12 EDIT
var/list/supply_positions = list(
	"Quartermaster",
	"Cargo Technician",
	"Miner",
	"Janitor"
)

var/list/security_positions = list(
	"Head of Security",
	"Detective",
	"Security Officer",
	"Security Medic"
)

var/list/nonhuman_positions = list(
	"AI",
	"Cyborg",
	"Drone",
	"pAI"
)

var/list/whitelisted_positions = list()

/proc/guest_jobbans(var/job)
	return (job in whitelisted_positions)

/proc/get_job_datums()
	var/list/occupations = list()
	var/list/all_jobs = typesof(/datum/job)

	for(var/A in all_jobs)
		var/datum/job/job = new A()
		if(!job)	continue
		occupations += job

	return occupations

/proc/get_alternate_titles(var/job)
	var/list/jobs = get_job_datums()
	var/list/titles = list()

	for(var/datum/job/J in jobs)
		if(!J)	continue
		if(J.title == job)
			titles = J.alt_titles

	return titles

var/global/list/exp_jobsmap = list(
	EXP_TYPE_LIVING = list(), // all living mobs
	EXP_TYPE_CREW = list(titles = command_positions | engineering_positions | medical_positions | supply_positions | security_positions | list("AI","Cyborg") | whitelisted_positions), // crew positions
	EXP_TYPE_SPECIAL = list(), // antags, ERT, etc
	EXP_TYPE_GHOST = list(), // dead people, observers
	EXP_TYPE_EXEMPT = list() // special grandfather setting
)
