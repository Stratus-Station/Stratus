/obj/effect/proc_holder/spell/targeted/touch/psi/punch
	name = "Psyper Punch"
	desc = "This spell charges your hand with the power of your mind, allowing you put more force into your next punch."
	hand_path = /obj/item/weapon/melee/touch_attack/psi/punch
	school = "psi"
	charge_max = 150
	cooldown_min = 50 //100 deciseconds reduction per rank
	action_icon_state = "psyper-punch"

/obj/item/weapon/melee/touch_attack/psi/punch
	name = "psyper punch"
	desc = "A fist empowered with PSI energy."
	catchphrase = "PSI punch!"
	on_use_sound = 'sound/weapons/genhit2.ogg'
	icon = 'icons/misc/PSIPowers.dmi'
	icon_state = "psyper-punch"
	item_state = "psyper-punch"

/obj/item/weapon/melee/touch_attack/psi/punch/afterattack(mob/living/target, mob/living/carbon/user, proximity)
	if (!istype(target))
		return
	user.do_attack_animation(target)
	target.apply_damage(20, BRUTE)
	target.visible_message("<span class='danger'>[user] punches [target.name] with the power of their mind!</span>", \
		"<span class='userdanger'>You cry out in pain as [user]'s punch flings you backwards!</span>")
	new /obj/effect/overlay/temp/kinetic_blast(target.loc)
	var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
	spawn(0)
		target.throw_at(throw_target, 2, 0.2)
	add_logs(user, target, "psyper punched", src)
	user.changeNext_move(CLICK_CD_MELEE)
	..()
