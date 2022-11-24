/// @desc





if (!surface_exists(surf)) {
	surf = surface_create(CW, CH);
}

surface_set_target(surf);
	draw_clear_alpha(c_white, 0);
	
	event_inherited();
	
	gpu_set_colorwriteenable(1,1,1,0);
	
	var steps = 2 + instance_number(obj_checkpoint);
	var w = 128;
	var step_width = w/(steps-1);
	var h = 8;
	var xx = CW/2 - w/2;
	var yy = CH/2 - h/2
	
	var cp_x1 = 0;
	var cp_x2 = room_width;
	var px = global.player_x;
	
	if (global.stage_direction == 0) {
		if (instance_exists(obj_checkpoint)) {
		
			with (obj_checkpoint) {
				if (index == global.checkpoint_index) {
					cp_x1 = x;
				} else if (index == global.checkpoint_index + 1) {
					cp_x2 = x;
				}
			}
		}
	} else {
		px = global.player_y;
		cp_x1 = room_height;
		cp_x2 = 0;
		
		if (instance_exists(obj_checkpoint)) {
			with (obj_checkpoint) {
				if (index == global.checkpoint_index) {
					cp_x1 = y;
				} else if (index == global.checkpoint_index + 1) {
					cp_x2 = y;
				}
			}
		}
	}
	var cp_progress = (px - cp_x1) / (cp_x2 - cp_x1);
	
	for (var i = 0; i < steps-1; i ++) {
		draw_sprite_stretched(spr_level_progress_line, 0, xx + step_width*i, yy, step_width-1, h);
	}
	draw_sprite_stretched(spr_level_progress_line, 0, xx + w, yy, 8, h);
	
	draw_sprite_stretched_ext(spr_level_progress_line, 0, xx + step_width*global.checkpoint_index, yy, 8, h, c_yellow, 1);
	
	var cx = xx + 5 + (global.checkpoint_index/(steps-1) + cp_progress/(steps-1)) * w * progress;
	var cy = yy - 2;
	draw_sprite(spr_player_icon, 0, cx, cy);
	
	gpu_set_colorwriteenable(1,1,1,1);
	
	if (state == 1) {
		progress = lerp(progress, 1, 1/50);

		if (progress >= 0.95 && alarm[0] == -1) {
			alarm_set(0, 100);
		}
	}
	
surface_reset_target();

draw_surface(surf, CX, CY);