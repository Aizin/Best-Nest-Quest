/// @desc

if (!invincible || invincible_timer % 10 < 5) {
	draw_sprite_ext(sprite_index, image_index, x, y, dir*image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

