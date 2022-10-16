/// @desc

hsp = spd * (keyboard_check(vk_right) - keyboard_check(vk_left));

on_ground = tilemap_get_at_pixel(collision_map, x, y+1) > 0;

var float = false;

if (on_ground) {
	
	// Jump
	if (global.key_jump_pressed) {
		vsp = -jump_spd;
	}
} else {
	vsp += grav;
}

process_collision();


