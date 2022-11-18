/// @desc

spd = 2;
jump_spd = 5.5;
spin_jump_spd = jump_spd;

grav = 0.3;
glide_grav = 0.1;

fric = 0.35;
acc = spd;

hsp = 0;
vsp = 0;

hsp_knockback = 0;

vsp_max = 10;
glide_vsp_max = 1;

gliding = false;
spinning = false;
peck = false;
peck_wall = false;

on_ground = false;

dir = 1
xaxis = 0;

glide_counter = 0;
glide_counter_max = 45;

peck_timer = 0;
peck_timer_max = 24;

jump_buffer = 0;
jump_buffer_timer = 10;

wall_corner_tolerance = 8;

surf = -1;

xscale = 1;
yscale = 1;

h_input_lock = 0;

function get_input() {
	global.key_right = keyboard_check(vk_right);
	global.key_left = keyboard_check(vk_left);
	global.key_jump = keyboard_check(ord("Z"))
	
	global.key_jump_pressed = keyboard_check_pressed(ord("Z"));
	global.key_peck_pressed = keyboard_check_pressed(ord("X"));
	global.key_peck_released = keyboard_check_released(ord("X"));
	
	global.key_jump_released = keyboard_check_released(ord("Z"));

}
get_input();

function process_movement() {
	
	var h_lock = peck_wall || (h_input_lock > 0);
	
	if (!h_lock) {
		xaxis = global.key_right - global.key_left;
		if (xaxis != 0) {
			hsp = approach(hsp, xaxis * spd, acc);
			dir = xaxis;
		} else {
			hsp = approach(hsp, 0, fric);
		}
	}
	//Start cloud platform here
	var _movingPlatform = instance_place(x, y + max(1, vsp), oPlatformMoving);
	if(_movingPlatform && bbox_bottom <= _movingPlatform.bbox_top){
		on_ground = true;
		if(vsp > 0){
			while (!place_meeting(x, y +sign(vsp), oPlatformMoving)){
				y += sign(vsp);
			}
			vsp = 0;	
		}
		x += _movingPlatform.hsp;
		y += _movingPlatform.vsp; // issue here
	
	}
	//End cloud platform here

	

	if (place_meeting(x, y+1, obj_wall)) {
		
		if (!on_ground) {
			xscale = 1.5;
			yscale = 0.5;
			
			instance_create_depth(x, y, depth-10, obj_sprite_animation, {sprite_index: spr_player_jump_dust});
		}
		on_ground = true;
		
		glide_counter = 0;
		spin_ready = false;
		gliding = false;
		spinning = false;
		
		jump_buffer = jump_buffer_timer;
	} else {
		
		on_ground = false;
		
		gliding = !spinning && global.key_jump && vsp > 0;
		
		var g = gliding ? glide_grav : grav;
		if (peck_wall) {
			g = 0;
		}
		
		var vm = gliding ? glide_vsp_max : vsp_max;
	
		// Apply gravity
		vsp = approach(vsp, vm, g);
		
		
		
		if (!spinning) {
			if (!global.key_jump && vsp < 0) {
				vsp = max(vsp, -jump_spd/4);
			}
		
			if (gliding) {
				glide_counter ++;
			}
			if (glide_counter >= glide_counter_max) {
				spin_ready = true;
			}
	
			if (spin_ready && vsp > 0 && global.key_jump_released) {
				spinning = true;
				vsp = -jump_spd;
				spin_ready = false;
				gliding = false;
			}
		}
		
		jump_buffer = approach(jump_buffer, 0, 1);
	}
	
	if (global.key_jump_pressed && jump_buffer != 0) {
		vsp = -jump_spd;
		
		xscale = 0.5;
		yscale = 1.5;
	}
	
	process_pecking();
	process_spin();
	
	process_collision();
	
	h_input_lock = approach(h_input_lock, 0, 1);
	hsp_knockback = approach(hsp_knockback, 0, 0.08);
}

function process_pecking() {
	peck_timer = approach(peck_timer, 0, 1);
	
	if (!spinning && !gliding) {
		if (!peck && !peck_wall) {
			if (global.key_peck_pressed) {
				peck = true;
			
				peck_timer = peck_timer_max;
			
				sprite_index = spr_player_peck_init;
			}
		} else {
			
			var spinnable_inst = instance_place(x+dir*2, y, obj_spinnable);
			if (instance_exists(spinnable_inst)) {
				
				spinnable_inst.peck_hit();
				
			} else {
			
				var wall_inst = instance_place(x+dir*2, y, obj_wall);
				if (instance_exists(wall_inst) && !wall_inst.nopeck) {
					peck_wall = true;
					vsp = 0;
			
					hsp = 0;
					hsp_knockback = 0;
			
					peck_timer = 0;
				}
			}
		
			if (peck_wall) {
				if (global.key_peck_released) {
					peck_wall = false;
					peck_timer = 0;
					peck = false;
				
					spinning = true;
				
					vsp = -spin_jump_spd;
					hsp_knockback = -dir*2;
				
					h_input_lock = 10;
				}
			} else {
				if (peck_timer == 0) {
					peck = false;
				}
			}
		}
	}
	
}

function process_spin() {
	var e_inst = instance_place(x, y+vsp, obj_enemy_parent);
	if (spinning && instance_exists(e_inst)) {
		vsp = -jump_spd;
		e_inst.damage();
	}
}

function process_collision() {
	var hsp_final = hsp + hsp_knockback;
	if (place_meeting(x+hsp_final, y, obj_wall)) {
		while (!place_meeting(x+sign(hsp_final), y, obj_wall)) {
			x += sign(hsp_final);
		}
		hsp_knockback = 0;
		hsp = 0;
		hsp_final = 0;
	}
	x += hsp_final;


	if (place_meeting(x, y+vsp, obj_wall)) {
		
		var collide = true;
		
		if (vsp < 0) {
			var wct = wall_corner_tolerance;
			var x_offset = 1;
			
			if (!place_meeting(x+wct, y+vsp, obj_wall)) {
				while (place_meeting(x+x_offset, y+vsp, obj_wall)) {
					x_offset ++;
				}
				collide = false;
			} else if (!place_meeting(x-wct, y+vsp, obj_wall)) {
				while (place_meeting(x+x_offset, y+vsp, obj_wall)) {
					x_offset --;
				}
				collide = false;
			}
			
			if (!collide) {
				x += x_offset;
			}
		}
		if (collide) {
			while (!place_meeting(x, y+sign(vsp), obj_wall)) {
				y += sign(vsp);
			}
			vsp = 0;
		}
	}
	y += vsp;

}

function process_animation() {
	xscale = lerp(xscale, 1, 0.1);
	yscale = lerp(yscale, 1, 0.1);
	
	if (peck) {} 
 	else if (on_ground) {
		if (xaxis != 0) {
			sprite_index = spr_player_walk;
		} else {
			sprite_index = spr_player_idle;
		}
	} else {
		if (gliding) {
			if (spin_ready) {
				sprite_index = spr_player_glide_spinready;
			} else {
				sprite_index = spr_player_glide;
			}
		} else if (spinning) {
			sprite_index = spr_player_spin;
		} else {
			if (vsp > 0) {
				sprite_index = spr_player_fall;
			} else {
				sprite_index = spr_player_jump;
			}
		}
	}
}
