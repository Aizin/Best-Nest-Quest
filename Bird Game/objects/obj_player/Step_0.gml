/// @desc

if (!init) {
	init = true;
	if (instance_exists(global.cur_room)) {
		global.cur_room.enter_room();
	}
}

if (global.transition_scroll_lock) {
	transition_progress ++;
	
	if (transition_progress < 16) {
		x += dir;
	}
	return;
}

transition_progress = 0;
old_room = -1;

if (global.player_frozen) return;


process_movement();
process_animation();

var trigger_inst = instance_place(x, y, obj_trigger);
if (instance_exists(trigger_inst)) {
	with (trigger_inst) {
		trigger();
		
		if (single_use) {
			instance_destroy();
		}
	}
}

if (place_meeting(x, y, obj_death_zone)) {
	die();
}

if (global.debug) {
	if (keyboard_check(vk_control)) {
		if (keyboard_check_pressed(ord("S"))) {
			global.save_data[$ "respawn_x"] = x;
			global.save_data[$ "respawn_y"] = y;
			save_game();
		}
		if (keyboard_check_pressed(ord("R"))) {
			global.save_data[$ "respawn_x"] = -1;
			global.save_data[$ "respawn_y"] = -1;
			room_restart();
		}
		if (mouse_check_button_pressed(mb_left)) {
			x = mouse_x;
			y = mouse_y;
		}
	} else {
		if (keyboard_check_pressed(ord("R"))) {
			room_restart();
		}
	}
	
	
}


global.player_x = x;
global.player_y = y;