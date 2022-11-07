/// @desc

if (global.hp == 0) return;

var sw = 48, sh = 32;
var s_ox = sw/2, s_oy = sh-8;
if (!surface_exists(surf)) {
	surf = surface_create(sw, sh);
}

var xs = sprite_index == spr_player_peck ? 1 : xscale;

surface_set_target(surf);
	draw_clear_alpha(c_white, 0);
	draw_sprite_ext(sprite_index, image_index, s_ox, s_oy, image_xscale*dir*xs, image_yscale*yscale, image_angle, image_blend, image_alpha);
	
	if (alarm[2] != -1 && alarm[2] % 10 < 5) {
		gpu_set_colorwriteenable(1,1,1,0);
		draw_rectangle(0, 0, sw, sh, 0);
		gpu_set_colorwriteenable(1,1,1,1);
	}
surface_reset_target();


if (!invincible || alarm[1] % 10 < 5) {
	draw_surface(surf, x-s_ox, y-s_oy);
}
