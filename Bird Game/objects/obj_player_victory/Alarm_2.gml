/// @desc

finished = true;

with (instance_create_depth(0,0,-9999,obj_transition)) {
	room_to = rm_title;
	
	set_step_size(8);
	step_timer_stay = 60;
	
	music_set_gain(global.cur_music, 0, 1500);
}



