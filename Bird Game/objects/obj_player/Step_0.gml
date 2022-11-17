/// @desc

if (global.transition_scroll_lock) return;

get_input();


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