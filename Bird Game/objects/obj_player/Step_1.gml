/// @desc

var room_inst = instance_place(x,y,obj_room);
if (instance_exists(room_inst) && room_inst.active) {
	global.last_room = room_inst;
}


if (!instance_exists(room_inst) && ((instance_exists(global.last_room) && global.last_room.boundry_kill) || !instance_exists(global.last_room))) {
	if (alarm[0] == -1) {
		alarm_set(0, 15);
	}

} else if (instance_exists(room_inst) && room_inst.active) {
	if (room_inst != global.cur_room) {
		global.transition_scroll_lock = true;
		
		if (instance_exists(global.cur_room)) {
			global.cur_room.exit_room();
			old_room = room_inst;
		}
	}
	global.cur_room = room_inst;
	global.cur_room.step();
} else if (instance_exists(global.last_room)) {
	global.last_room.step();
}



