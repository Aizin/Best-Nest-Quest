/// @desc

var room_inst = instance_place(x,y,obj_room);

if (!instance_exists(room_inst)) {
	if (alarm[0] == -1) {
		alarm_set(0, 15);
	}
} else if (room_inst.active) {
	if (room_inst != global.cur_room) {
		global.transition_scroll_lock = true;
		
		if (instance_exists(global.cur_room)) {
			global.cur_room.exit_room();
			old_room = room_inst;
		}
	}
	global.cur_room = room_inst;
	global.cur_room.step();
}



