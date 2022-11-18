/// @desc

sprite_index = spr_water_blast_dissolve;

active = false;

if (instance_exists(parent)) {
	parent.water_blast_finish();
}


