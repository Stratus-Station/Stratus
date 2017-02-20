var/list/station_departments = list("Command", "Medical", "Engineering", "Security", "Support", "Civilian")

// The department the job belongs to.
/datum/job/var/department = null

// Whether this is a head position
/datum/job/var/head_position = 0

/datum/job/captain/department = "Command"
/datum/job/captain/head_position = 1

/datum/job/mining/department = "Support"

/datum/job/janitor/department = "Support"

/datum/job/qm/department = "Support"
/datum/job/qm/head_position = 1

/datum/job/cargo_tech/department = "Support"

/datum/job/chief_engineer/department = "Engineering"
/datum/job/chief_engineer/head_position = 1

/datum/job/engineer/department = "Engineering"

/datum/job/atmos/department = "Engineering"

/datum/job/roboticist/department = "Engineering"

/datum/job/cmo/department = "Medical"
/datum/job/cmo/head_position = 1

/datum/job/doctor/department = "Medical"

/datum/job/chemist/department = "Medical"

/datum/job/hos/department = "Security"
/datum/job/hos/head_position = 1

/datum/job/detective/department = "Security"

/datum/job/officer/department = "Security"
