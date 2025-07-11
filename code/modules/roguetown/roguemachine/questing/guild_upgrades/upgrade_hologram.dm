/obj/effect/temp_visual/hologram
	icon = 'icons/effects/effects.dmi'
	icon_state = "shieldsparkles"
	duration = 30
	randomdir = FALSE
	layer = ABOVE_MOB_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/temp_visual/hologram/Initialize(mapload, atom/mimiced_atom)
	. = ..()
	if(mimiced_atom)
		appearance = mimiced_atom.appearance
		transform = matrix() * 0.8 // Slightly smaller than actual
		animate(src, alpha = 0, time = duration)
		// Preserve any pixel shifts from the original
		pixel_x = mimiced_atom.pixel_x
		pixel_y = mimiced_atom.pixel_y
