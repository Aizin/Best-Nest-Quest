/// @desc






// Inherit the parent event
event_inherited();

if (!audio_is_playing(s_noise) && !mus_playing) {
	
	mus_playing = true;
	var s = play_music(snd_mus_title)
	music_set_gain(s, 1, 0);
}