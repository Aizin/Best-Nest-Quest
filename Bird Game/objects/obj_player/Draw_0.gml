/// @desc

var sw = 32, sh = 32;
var s_ox = sw/2, s_oy = sh-8;
if (!surface_exists(surf)) {
	surf = surface_create(sw, sh);
}

surface_set_target(surf);
	draw_clear_alpha(c_white, 0);
	draw_sprite_ext(sprite_index, image_index, s_ox, s_oy, image_xscale*dir*xscale, image_yscale*yscale, image_angle, image_blend, image_alpha);
surface_reset_target();

draw_surface(surf, x-s_ox, y-s_oy);

