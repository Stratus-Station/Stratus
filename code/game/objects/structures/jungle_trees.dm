//treeeeeeeeees

/obj/structure/flora/tree/jungle
	name = "jungle tree"
	desc = "A large tree commonly found in jungle areas."
	chops_needed = 8

/obj/structure/flora/tree/jungle/large
	desc = "An extremely large tree commonly found in jungle areas."
	name = "large jungle tree"
	icon = 'icons/obj/flora/trees-large.dmi'
	icon_state = "tree1"
	pixel_x = -32

/obj/structure/flora/tree/jungle/large/New()
	icon_state = "tree[rand(1,4)]"

/obj/structure/flora/tree/jungle/small
	icon = 'icons/obj/flora/trees-small.dmi'
	icon_state = "tree1"
	chops_needed = 4

/obj/structure/flora/tree/jungle/small/New()
	icon_state = "tree[rand(1,10)]"

