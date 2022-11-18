/// @desc

if (sprite_index == spr_water_blast_grow) {
	sprite_index = spr_water_blast;
	active = true;
	alarm_set(0, life);
} else if (sprite_index == spr_water_blast_dissolve) {
	instance_destroy();
}



