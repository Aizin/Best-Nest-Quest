/// @desc


function create_particle() {
	var xx = random_range(x, x + 16*image_xscale);
	var yy = random_range(y, y + 16*image_yscale);
	
	instance_create_depth(xx, yy, depth, obj_sparkle);
}


