/// @desc

if (sprite_index == spr_water_blast) {
	if (irandom(20) == 0) {
		instance_create_depth(x, random_range(bbox_top, bbox_top+32), depth-10, obj_water_particle);
	}
}




