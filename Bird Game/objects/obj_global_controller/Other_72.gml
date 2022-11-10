/// @desc

if (audio_group_is_loaded(ag_music) && !music_ag_loaded) {
	music_ag_loaded = true;
	audio_group_set_gain(ag_music, global.save_data[$ "volume_music"], 0);
	
	room_goto(rm_title);
}

if (audio_group_is_loaded(ag_sounds)) {
	audio_group_set_gain(ag_sounds, global.save_data[$ "volume_sound"], 0);
}



