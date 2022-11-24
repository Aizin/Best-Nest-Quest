/// @desc






// Inherit the parent event
event_inherited();

if (alarm[0] != -1) {
	
	change_state(alarm[0] % (transition_amp) < transition_amp/2);
	transition_amp ++;
}

jellyfish_progress = lerp(jellyfish_progress, jellyfish_active, 0.01);


timer ++;