/// @desc


if (global.transition_scroll_lock) return;

if (global.cur_room != room_inst && !ignore_room_boundry) {
	x = xstart;
	y = ystart;
	state = 0;
	hp = hp_max;
	
	target_outside_room();
} else {
	
	if (instance_exists(target)) {
		step();
	}
}



