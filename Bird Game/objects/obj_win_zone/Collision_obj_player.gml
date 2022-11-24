/// @desc

if (active) return;

active = true;

global.player_frozen = true;

with (obj_player) {
	var p = instance_create_depth(x, y, depth, obj_player_win);
	p.sprite_index = sprite_index;
	
	instance_destroy();
}

if (instance_exists(obj_camera_follower)) {
	with (obj_camera_follower) {
		follow = obj_player_win;
	}
}

global.save_data[$ "respawn_x"] = -1;
global.save_data[$ "respawn_y"] = -1;
global.checkpoint_index = 0;

var t = instance_create_depth(0,0,-999999,obj_transition);
t.transition_type = 1;
t.room_to = room_to;
t.step_timer_stay = 100;

music_set_gain(global.cur_music, 0, 1700)
