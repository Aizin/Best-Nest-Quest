/// @desc

if (alpha_state == 1) {
	image_alpha = approach(image_alpha, 0, 0.075);
	
	if (image_alpha == 0) {
		instance_destroy();
	}
}

