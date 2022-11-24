/// @desc

event_inherited();

s_noise = play_sound(snd_noise);
sound_set_gain(s_noise, 0, 0);
sound_set_gain(s_noise, 0.3, 1000);

mus_playing = false;

intro_step = 0;


function start_game() {
	active = false;
	
	global.save_data[$ "respawn_x"] = -1;
	global.save_data[$ "respawn_y"] = -1;
	save_game();
	
	with (instance_create_depth(0,0,-9999,obj_transition)) {
		room_to = rm_game_forest;
		
		music_set_gain(global.cur_music, 0, 1500);
		
		if (global.debug) {
			set_step_size(64);
			step_timer_stay = 1;
			timer_step = 1;
		}
	}
}

root.add_option_button("Start", method(self, start_game));

settings = root.add_option_page("Settings");
settings.add_option_button("Back", settings.back);

settings.add_option_slider("Sound", "volume_sound", 0, 1, function(val) {
	audio_group_set_gain(ag_sounds, val/2, 0);
});
settings.add_option_slider("Music", "volume_music", 0, 1, function(val) {
	audio_group_set_gain(ag_music, val, 0);
});

settings.add_option_button("Fullscreen", toggle_fullscreen)

root.add_option_button("Quit", game_end);
