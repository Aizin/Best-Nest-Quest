/// @desc

gpu_set_blendenable(false);

if (global.game_paused) {
	surface_set_target(application_surface);
		if (surface_exists(pause_surf)) {
			draw_surface(pause_surf, 0, 0);
		} else {
			pause_surf = surface_create(res_w, res_h);
			buffer_set_surface(pause_surf_buffer, pause_surf, 0);
		}
		
		
	surface_reset_target();
	
	gpu_set_blendenable(true);
	
	if (instance_exists(pause_menu)) {
		pause_menu.draw();
	}
	
	gpu_set_blendenable(false);
}

if (global.key_pause_pressed && global.can_pause && !global.transition_scroll_lock && room != rm_title) {
	toggle_pause();
}

gpu_set_blendenable(true);

