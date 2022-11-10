/// @desc

if (collected) return;

collected = true;

play_sound(snd_checkpoint);

global.save_data[$ "respawn_x"] = x;
global.save_data[$ "respawn_y"] = y;

global.hp = global.hp_max;

with (other) {
	alarm_set(2, 60);
}
