/// @desc

if (collected) return;

collected = true;

if (global.checkpoint_index == index) return;

play_sound(snd_checkpoint);

global.save_data[$ "respawn_x"] = x;
global.save_data[$ "respawn_y"] = y;

global.hp = global.hp_max;

global.checkpoint_index = index;

with (other) {
	alarm_set(2, 60);
}
