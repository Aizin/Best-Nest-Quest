/// @desc

if (global.transition_scroll_lock || global.player_frozen) return;


process_movement();
process_animation();

var room_inst = instance_place(x,y,obj_room);

if (!instance_exists(room_inst)) {
	if (alarm[0] == -1) {
		alarm_set(0, 15);
	}
} else {
	if (room_inst != global.cur_room) {
		global.transition_scroll_lock = true;
	}
	global.cur_room = room_inst;
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

