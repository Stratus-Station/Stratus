/datum/species/proc/is_job_locked(var/datum/job/gig)
	if(gig.species_exclusive)
		for(var/N in gig.species_exclusive)
			if(istype(src,N))
				return 0
		return 1

	if(restricted_jobs)
		for(var/N in restricted_jobs)
			if(istype(gig,N))
				return 1
	else
		return 0