/// @desc

if (alpha_state == 1) {
	alpha = approach(alpha, 0, 0.02);
	
	image_alpha = (alpha * 10) % 4 >= 2;
	
	if (alpha == 0) {
		instance_destroy();
	}
}

