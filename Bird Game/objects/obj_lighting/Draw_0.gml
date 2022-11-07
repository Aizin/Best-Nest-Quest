/// @desc

if (!surface_exists(surf)) {
	surf = surface_create(CW, CH);
}

surface_set_target(surf)
	draw_clear_alpha(c_white, 0);

	draw_set_color(c_black);
	draw_set_alpha(alpha);

	draw_rectangle(0, 0, room_width, room_height, 0);

	draw_set_color(c_white);
	draw_set_alpha(1);
	
	if (active != 0) {
		gpu_set_blendmode(bm_subtract);

		var xx = 0, yy = 0;
		if (active == 1) {
			xx = mouse_x;
			yy = mouse_y;
		} else {
			xx = obj_player.x;
			yy = obj_player.y;
		}
		
		draw_circle(xx - CX, yy - CY, 32, 0)
		
		gpu_set_blendmode(bm_normal);
	}
	
surface_reset_target();

draw_surface(surf, CX, CY)


