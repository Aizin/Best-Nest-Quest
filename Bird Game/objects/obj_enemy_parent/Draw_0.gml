/// @desc

if (global.transition_scroll_lock) return;



if (alarm[11] != -1) {
	
	if (alarm[11] % 2 == 0) {
		var r = max(0, alarm[10]/damage_flash_duration - 0.25) * damage_range;
		shake_x = choose(1, -1) * random_range(r/4, r);
		shake_y = choose(1, -1) * random_range(r/4, r);
	}
	
	shader_set(shd_red_flash);
}

draw_sprite_ext(sprite_index, image_index, x + shake_x, y + shake_y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (alarm[11] != -1) {
	shader_reset();
}