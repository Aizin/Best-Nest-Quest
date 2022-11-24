/// @desc Init variables

// ##################################################
#region Variables
// ##################################################

spd = 1.6;
jump_spd = 5.75;
spin_jump_spd = jump_spd;

grav = 0.27;
glide_grav = 0.1;

fric = 0.35;
acc = spd;

hsp = 0;
vsp = 0;

hsp_sustained_knockback = 0;
hsp_fade_knockback = 0;

vsp_max = 5.5;
glide_vsp_max = 1;

spin_ready = false;

gliding = false;
spinning = false;
peck = false;
peck_wall = false;

on_ground = true;

dir = 1
xaxis = 0;

can_glide = true;

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

spin_cooldown = 0;

h_input_lock = 0;
freeze_input = 0;

invincible = false;
invincible_timer = 145;

knockback_vsp = 4;
knockback_hsp = 4;

init = false;

// ##################################################
#endregion
// ##################################################

// ##################################################
#region Functions
// ##################################################

function heal(str=1) {
	global.hp = approach(global.hp, global.hp_max, str);
	
	play_sound(snd_player_heal);
	
	repeat (irandom_range(3, 5)) {
		var xx = irandom_range(bbox_left-6, bbox_right+6);
		var yy = irandom_range(bbox_top-6, bbox_bottom+6);
		instance_create_depth(xx, yy, depth-10, obj_sparkle);
	}
}

function damage(str=1) {
	
	// Make sure we aren't invinvible
	if (invincible) return;
	
	spin_ready = false;
	
	play_sound(snd_player_hit);
	
	// Start being invincible
	invincible = true;
	alarm_set(1, invincible_timer);
	
	// Apply knockback
	vsp = -knockback_vsp;
	
	hsp_fade_knockback = -dir * knockback_hsp;
	h_input_lock = 15;
	
	gliding = false;
	spinning = false;
	peck = false;
	peck_wall = false;
	
	// Decrease health
	global.hp = approach(global.hp, 0, str);
	
	if (global.hp == 0) {
		die();
	}
	
	// Make health egg particles
	repeat(str) {
		instance_create_depth(x, y-16, depth-10, obj_health_egg);
	}
}

function die() {
	global.hp = 0;
	global.player_frozen = true;
	
	play_sound(snd_player_die_fall);
	
	if (global.cur_music != -1) {
		audio_stop_sound(global.cur_music);
		global.cur_music = -1;
	}
	
	if (alarm[0] == -1) {
		alarm_set(0, 80);
	}
}

function process_movement() {
	
	var h_lock = peck_wall || (freeze_input > 0) || (h_input_lock > 0);
	
	if (!h_lock) {
		xaxis = global.key_right - global.key_left;
		if (xaxis != 0) {
			hsp = approach(hsp, xaxis * spd, acc);
			dir = xaxis;
		} else {
			hsp = approach(hsp, 0, fric);
		}
	}
	
	
	
	var v_wall = instance_place(x, y+1, obj_wall);
	if (instance_exists(v_wall) && (!v_wall.spinnable || (v_wall.spinnable && (!spinning)))) {
		
		if (!on_ground) {
			xscale = 1.5;
			yscale = 0.5;
			
		}
		on_ground = true;
		
		glide_counter = 0;
		spin_ready = false;
		gliding = false;
		spinning = false;
		
		jump_buffer = jump_buffer_timer;
	} else {
		
		on_ground = false;
		
		gliding = !spinning && global.key_jump && vsp > 0 && can_glide;
		
		var g = gliding ? glide_grav : grav;
		if (peck_wall) {
			g = 0;
		}
		
		var vm = gliding ? glide_vsp_max : vsp_max;
	
		// Apply gravity
		vsp = approach(vsp, vm, g);
		if (vsp > vm) vsp = vm;
		
		
		if (!spinning && can_glide) {
			if (global.key_jump_released && vsp < 0) {
				vsp = max(vsp, -jump_spd/4);
			}
		
			if (gliding) {
				glide_counter ++;
				
				peck_wall = false;
				peck_timer = 0;
				peck = false;
			}
			if (glide_counter >= glide_counter_max) {
				spin_ready = true;
			}
	
			if (spin_ready && vsp > 0 && global.key_jump_released) {
				
				play_sound(snd_player_spin_jump);
				
				spinning = true;
				vsp = -jump_spd;
				spin_ready = false;
				gliding = false;
			}
		}
		
		jump_buffer = approach(jump_buffer, 0, 1);
	}
	
	if (global.key_jump_pressed && jump_buffer != 0 && freeze_input == 0 && !peck_wall) {
		
		play_sound(snd_player_jump);
		
		vsp = -jump_spd;
		
		jump_buffer = 0;
		
		xscale = 0.5;
		yscale = 1.5;
	}
	
	
	process_pecking();
	process_spin();
	process_collision();
	
	h_input_lock = approach(h_input_lock, 0, 1);
	//freeze_input = approach(freeze_input, 0, 1);
	hsp_fade_knockback = approach(hsp_fade_knockback, 0, 0.12);
}

function process_spin() {
	spin_cooldown = approach(spin_cooldown, 0, 1);
	
	if (spinning && spin_cooldown == 0 && vsp > 0) {
		var spinnable_inst = instance_place(x, y+vsp, obj_spinnable);
		if (instance_exists(spinnable_inst)) {
	
			spin_cooldown = 10;
		
			vsp = -jump_spd/(1.1 + 0.4 * !global.key_jump);
			spinnable_inst.spin_hit();
		} 
	} else {
		var spinnable_inst = instance_place(x, y, obj_spinnable);
		if (instance_exists(spinnable_inst)) {
			spinnable_inst.on_touch(self);
		}
	
	}
}

function process_pecking() {
	peck_timer = approach(peck_timer, 0, 1);
	
	if (!spinning && !gliding) {
		if (!peck && !peck_wall) {
			if (global.key_peck_pressed && peck_timer == 0) {
				
				play_sound(snd_player_peck);
				
				peck = true;
			
				peck_timer = peck_timer_max;
				
				if (on_ground) {
					hsp /= 4
					h_input_lock = max(h_input_lock, 15);
				}
				
				image_index = 0;
				sprite_index = spr_player_peck_init;
			}
		} else {
			
			var spinnable_inst = instance_place(x+16*dir, y, obj_spinnable);
			if (instance_exists(spinnable_inst)) {
				
				var peck_res = spinnable_inst.peck_hit(dir);
				
				if (peck_res) {
					
					hsp_fade_knockback = -dir*2;
				}
				
				peck_wall = false;
				peck = false;
				
			} else {
				
				
				//var wall_inst = instance_place(x+16*dir, y, obj_wall);
				var wall_inst = collision_rectangle(x+16*dir, bbox_top+4, x+dir*3, bbox_bottom-8, obj_wall, 0, 0);
				var movingwall_h_inst = instance_place(x+dir*2, y, obj_movingwall_h);
				var movingwall_v_inst = instance_place(x+dir*2, y, obj_movingwall_v);
				if (instance_exists(wall_inst) && !wall_inst.nopeck && !peck_wall) {
					peck_wall = true;
					vsp = 0;
					
					play_sound(snd_player_peck_wall);
			
					hsp = 0;
					hsp_sustained_knockback = 0;
			
					peck_timer = 0;
				}
				if (instance_exists(movingwall_h_inst) && !movingwall_h_inst.nopeck && !peck_wall) {
					peck_wall = true; //set state of pecking a wall to true
					vsp = 0; //stop vert speed
					
					play_sound(snd_player_peck_wall);
					
					//x = movingwall_h_inst.x + -dir; //set x pos to x pos of moving block and "dig in" to block so when dir change the collision doesn't separate.
					
					hsp = movingwall_h_inst.hsp*movingwall_h_inst.dir;
					//hsp = 0; //stop horizontal speed
					hsp_sustained_knockback = 0;
					
					peck_timer = 0;
				}
				if (instance_exists(movingwall_v_inst) && !movingwall_v_inst.nopeck && !peck_wall) {
					peck_wall = true;
					vsp += movingwall_v_inst.vsp*movingwall_v_inst.dir;
					
					play_sound(snd_player_peck_wall);
					
					//if (bbox_top < movingwall_v_inst.bbox_top) {
					//	approach(y, movingwall_v_inst.y, 1);
					//}
					
					hsp = 0;
					hsp_sustained_knockback = 0;
					
					peck_timer = 0;
				}
			}
		
			if (peck_wall) {
				if (!global.key_peck) {
					peck_wall = false;
					peck_timer = 0;
					peck = false;
					
					play_sound(snd_player_spin_jump);
					
					spinning = true;
				
					vsp = -spin_jump_spd;
					//hsp_sustained_knockback = -dir*2;
				
					h_input_lock = 7;
				}
			} else {
				if (peck_timer == 0) {
					peck = false;
				}
			}
		}
	}
	
}

function process_collision() {
	var hsp_final = hsp + hsp_sustained_knockback + hsp_fade_knockback;
	if (place_meeting(x+hsp_final, y, obj_wall)) {
		while (!place_meeting(x+sign(hsp_final), y, obj_wall)) {
			x += sign(hsp_final);
		}
		hsp_sustained_knockback = 0;
		hsp_fade_knockback = 0;
		hsp = 0;
		hsp_final = 0;
	}
	
	var movingwall_h_inst = instance_place(x, y+1, obj_movingwall_h); //check if movingwall below player
	if (movingwall_h_inst) {
		hsp += movingwall_h_inst.hsp*movingwall_h_inst.dir;
	}
	var movingwall_h_btm_inst = instance_place(x, y, obj_movingwall_h); //check if player collide with bottom of movingwall
	if (movingwall_h_btm_inst && y < movingwall_h_btm_inst.bbox_bottom) {
		vsp = 1;
	}
	var movingwall_v_inst = instance_place(x, y+1, obj_movingwall_v);
	if (movingwall_v_inst) {
		y = movingwall_v_inst.bbox_top + movingwall_v_inst.dir * 2;
	}
	var movingwall_v_btm_inst = instance_place(x, y, obj_movingwall_v);
	if (movingwall_v_btm_inst && y > movingwall_v_btm_inst.bbox_bottom) {
		vsp = 1;
	}
	
	hsp_final = hsp + hsp_sustained_knockback;
	
	x += hsp_final;
	
	hsp = 0;


	var v_wall = instance_place(x, y+vsp, obj_wall);
		
	if (instance_exists(v_wall)) {
		
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
			
			can_glide = true;
			
			hsp_sustained_knockback = 0;
			if (freeze_input > 0) {
				hsp = 0;
				freeze_input = 0;
			}
		}
	}
	y += vsp;

}

function process_animation() {
	xscale = lerp(xscale, 1, 0.1);
	yscale = lerp(yscale, 1, 0.1);
	
	if (peck || peck_timer != 0) {} 
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

// ##################################################
#endregion
// ##################################################

global.hp = global.hp_max;

if (global.save_data[$ "respawn_x"] == -1 || global.save_data[$ "respawn_y"] == -1) {
	global.save_data[$ "respawn_x"] = x;
	global.save_data[$ "respawn_y"] = y;
}

x = global.save_data[$ "respawn_x"];
y = global.save_data[$ "respawn_y"];


global.cur_room = instance_place(x,y,obj_room);

