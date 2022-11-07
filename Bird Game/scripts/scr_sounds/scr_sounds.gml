

function play_sound(soundid) {
	//var s = audio_play_sound(soundid, 1, 0, global.save_data[$ "volume_sound"]);
	
	var s = audio_play_sound(soundid, 1, 0, 1);
	
	return s;
}

function sound_set_gain(sound, gain, time) {
	audio_sound_gain(sound, gain * global.save_data[$ "volume_sound"], time);
}
function music_set_gain(sound, gain, time) {
	audio_sound_gain(sound, gain * global.save_data[$ "volume_music"], time);
}

global.cur_music = -1;
global.cur_music_soundid = -1;
function play_music(soundid) {
	if (audio_is_playing(soundid)) {
		return;
	}
	
	if (global.cur_music != -1) {
		audio_stop_sound(global.cur_music);
	}

	var s = audio_play_sound(soundid, 1, 1, 0);
	music_set_gain(s, 1, 250)

	global.cur_music = s;
	
	return s;
}