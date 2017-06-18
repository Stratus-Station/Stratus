/datum/language/vaurca
	name = "Hivenet"
	desc = "A localised expression of the Vaurcae hivemind, allowing Vaurcae to communicate from across great distances. \"It's a bugs life.\""
	speech_verb = " broadcasts"
	colour = "vaurca"
	key = "9"
	native = 1
	flags = WHITELISTED | HIVEMIND
	syllables = list("vaur","uyek","uyit","avek","sc'theth","k'ztak","teth","wre'ge","lii","dra'","zo'","ra'","k'lax'","zz","vh","ik","ak",
	"uhk","zir","sc'orth","sc'er","thc'yek","th'zirk","th'esk","k'ayek","ka'mil","sc'","ik'yir","yol","kig","k'zit","'","'","zrk","krg","isk'yet","na'k",
	"sc'azz","th'sc","nil","n'ahk","sc'yeth","aur'sk","iy'it","azzg","a'","i'","o'","u'","a","i","o","u","zz","kr","ak","nrk")

/datum/language/vaurca/get_random_name()
	var/new_name = "[pick(list("Ka'","Za'","Ka'"))]"
	new_name += "[pick(list("Akaix'","Viax'"))]"
	new_name += "[pick(list("Uyek","Uyit","Avek","Theth","Ztak","Teth","Zir","Yek","Zirk","Ayek","Yir","Kig","Yol","'Zrk","Nazgr","Yet","Nak","Kiihr","Gruz","Guurz","Nagr","Zkk","Zohd","Norc","Agraz","Yizgr","Yinzr","Nuurg","Iii","Lix","Nhagh","Xir","Z'zit","Zhul","Zgr","Na'k","Isk'yet","Aaaa"))]"
	new_name += " [pick(list("Zo'ra","Zo'ra","Zo'ra","K'lax"))]"
	return new_name

/datum/language/vaurca/broadcast(var/mob/living/speaker,var/message,var/speaker_mask)
	log_say("[key_name(speaker)] : ([name]) [message]",ckey=key_name(speaker))

	if(!speaker_mask)
		speaker_mask = speaker.name

	var/msg = "<i><span class='game say'>[name], <span class='name'>[speaker_mask]</span>[format_message(message, get_spoken_verb(message))]</span></i>"

	speaker.custom_emote(1, "[pick("twitches their antennae", "twitches their antennae rythmically")].")

	if (within_jamming_range(speaker))
		// The user thinks that the message got through.
		speaker << msg
		return

	for(var/mob/player in player_list)
		if(istype(player,/mob/dead) || ((src in player.languages && !within_jamming_range(player)) || check_special_condition(player)))
			player << msg

/datum/language/vaurca/check_special_condition(var/mob/other)
	if(istype(other, /mob/living/silicon))
		return 1

	var/mob/living/carbon/human/M = other
	if(!istype(M))
		return 0
	if(istype(M, /mob/new_player))
		return 0
	if(within_jamming_range(other))
		return 0
	if(locate(/obj/item/organ/internal/vaurca/neuralsocket) in M.internal_organs)
		return 1

	if (M.l_ear || M.r_ear)
		var/obj/item/device/radio/headset/dongle
		if(istype(M.l_ear,/obj/item/device/radio/headset))
			dongle = M.l_ear
		else
			dongle = M.r_ear

		if(!istype(dongle))
			return 0
		if(dongle.translate_hivenet)
			return 1

	return 0

/datum/language/vaurca/monkey
	name = "V'krexi"
	desc = "Buzz buzz buzz."
	key = "#"
	speech_verb = "chitters"
	ask_verb = "ponders"
	exclaim_verb = "buzzes"
	syllables = list("vaur","uyek","uyit","avek","sc'theth","k'ztak","teth","wre'ge","lii","dra'","zo'","ra'","k'lax'","zz","vh","ik","ak",
	"uhk","zir","sc'orth","sc'er","thc'yek","th'zirk","th'esk","k'ayek","ka'mil","sc'","ik'yir","yol","kig","k'zit","'","'","zrk","krg","isk'yet","na'k",
	"sc'azz","th'sc","nil","n'ahk","sc'yeth","aur'sk","iy'it","azzg","a'","i'","o'","u'","a","i","o","u","zz","kr","ak","nrk")
