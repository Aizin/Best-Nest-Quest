/// @desc

global.game_paused = false;
global.can_pause = true;

res_w = CW * 2;
res_h = CH * 2;

pause_menu = noone;

pause_surf = -1;
pause_surf_buffer = -1;

function toggle_pause() {
	if (!global.game_paused) {
		if (instance_exists(obj_player) && !instance_exists(obj_transition)) {
			global.game_paused = true;
		
			pause_menu = instance_create_depth(0, 0, depth, obj_pause_menu);
		
			instance_deactivate_all(true);
		
			instance_activate_object(obj_global_controller);
			instance_activate_object(pause_menu);
		
			pause_surf = surface_create(res_w, res_h);
			surface_set_target(pause_surf);
				draw_surface(application_surface, 0, 0);
			surface_reset_target();
		
			pause_surf_buffer = buffer_create(res_w * res_h * 4, buffer_fixed, 1);
			buffer_get_surface(pause_surf_buffer, pause_surf, 0);
		}
	} else if (instance_exists(pause_menu) && !pause_menu.cur_page.focused) {
		global.game_paused = false;
		
		with (pause_menu) {
			instance_destroy();
		}
		pause_menu = noone;
		
		instance_activate_all();
		if (surface_exists(pause_surf)) {
			surface_free(pause_surf);
		}
		if (buffer_exists(pause_surf_buffer)) {
			buffer_delete(pause_surf_buffer);
		}
	}
}