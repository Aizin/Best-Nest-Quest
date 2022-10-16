/// @desc

draw_self();

if (alarm[0] != -1) {
	gpu_set_fog(1, flash_color, 0, 1);
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, alarm[0]/flash_timer);
	gpu_set_fog(0, flash_color, 0, 1);
}

