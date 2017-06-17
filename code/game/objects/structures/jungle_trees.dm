//treeeeeeeeees

/obj/structure/flora/tree/jungle
	name = "jungle tree"
	desc = "A tree commonly found in jungle areas."
	icon = 'icons/obj/flora/jungletrees.dmi'
	icon_state = "tree"
	pixel_x = -48
	pixel_y = -20


/obj/structure/flora/tree/jungle/large
	desc = "It's seriously hampering your view of the jungle."
	name = "large jungle tree"
	icon = 'icons/obj/flora/trees-large.dmi'
	icon_state = "tree1"
	pixel_x = -32
	chops_needed = 8

/obj/structure/flora/tree/jungle/New()
	icon_state = "[icon_state][rand(1, 3)]"

/obj/structure/flora/tree/jungle/large/New()
	icon_state = "tree[rand(1,4)]"

/obj/structure/flora/tree/jungle/small
	icon = 'icons/obj/flora/trees-small.dmi'
	icon_state = "tree1"
	chops_needed = 4

/obj/structure/flora/tree/jungle/small/New()
	icon_state = "tree[rand(1,10)]"

