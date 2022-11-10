/// @desc

if (!active || instance_exists(obj_transition)) return;

var input_dir = (global.key_down_pressed || global.key_right_pressed) - (global.key_up_pressed || global.key_left_pressed);

if (input_dir != 0) {
	cur_page.input(input_dir);
	
}

if (global.key_jump_pressed) {
	cur_page.select();
}

if (global.key_peck_pressed) {
	play_sound(snd_menu_select);
	
	cur_page.back();
}




