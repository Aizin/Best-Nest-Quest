/// @desc

// Inherit the parent event
event_inherited();

/*
function step() {
	// Face the correct direction
	image_xscale = dir;
	
	// Make sure the player exists, otherwise go to idle state
	if (!instance_exists(target)) state = 0;
	
	// Idle state
	if (state == 0) {
		
		// Reset speed
		hsp = 0;
		vsp = 0;
		
		// Turn around
		if (alarm[1] == -1) {
			alarm_set(1, irandom_range(30, 120));
		}
		
		// Sense if the player is within range
		if (instance_exists(target)) {
			
			// Get distance to player
			var dist = target.x - x;
			
			// Player is within range
			if (abs(dist) < range && sign(dist) == dir && sprite_index == spr_corn_mouse_idle && hit_player == 0) {
				
				// Go to jumping state
				state = 1;
				
				// Set speed
				hsp = spd * dir * random_range(0.95, 1.05);
				vsp = -jump_spd;
				
				// Set sprite
				sprite_index = spr_corn_mouse_jump;
				
				// Wait before sensing if touching the ground again
				cooldown = 10;
			}
		}
		
		// Reduce timer
		hit_player = approach(hit_player, 0, 1);
	} else {
	
		// Determine if grounded
		if (place_meeting(x, y+1, obj_wall) && cooldown == 0) {
			
			// Goto idle state
			state = 0;
			
			// Change to landing sprite
			sprite_index = spr_corn_mouse_land;
		} else {
			
			// Apply gravity
			vsp += grav;
		}
	}
	
	// Reduce timer
	cooldown = approach(cooldown, 0, 1);

	// Horizontal collision
	var hsp_final = hsp;
	if (place_meeting(x+hsp_final, y, obj_wall)) {
		while (!place_meeting(x+sign(hsp_final), y, obj_wall)) {
			x += sign(hsp_final);
		}
		dir *= -1;
		hsp *= -1;
	}
	x += hsp_final;
	
	// Vertical collision
	var vsp_final = vsp;
	if (place_meeting(x, y+vsp_final, obj_wall)) {
		while (!place_meeting(x, y+sign(vsp_final), obj_wall)) {
			y += sign(vsp_final);
		}
		hsp = 0;
		vsp = 0;
		vsp_final = 0;
	}
	y += vsp_final;

}
*/

function on_peck() {
	
	// Jump away
	//state = 1;
	
	// Set speed
	hsp = target.dir*max(1.5, abs(hsp))/2;
	vsp = -jump_spd;
	
	//// Change sprite to jump
	//sprite_index = spr_corn_mouse_jump;
	//		
	//// Start landing cooldown
	//cooldown = 10;
}

function on_touch(player) {
	// Damage player
	player.damage(1);
	
	// Start timer
	hit_player = 45;
}

function step() {
	
	image_xscale = dir;
	
	switch (state) {
		case 0:
			// Turn around
			if (alarm[1] == -1) {
				alarm_set(1, irandom_range(30, 120));
			}
			
			if (instance_exists(target) && irandom(3) == 0) {
				var target_in_range = distance_to_object(target) < range && sign(target.x - x) == dir;
				var no_wall_ahead = !place_meeting(x + sprite_width, y, obj_wall);
				var no_pit_ahead = place_meeting(x + sprite_width, y + sprite_height + 4, obj_wall);
				
				if (target_in_range && on_ground && no_wall_ahead && no_pit_ahead) {
					change_state(1);
				}
			}
			
			break;
		
		case 1:
			if (on_ground) {
				change_state(0);
			}
			break;
	}
	
	if (place_meeting(x, y+1, obj_wall)) {
		on_ground = true;
	} else {
		on_ground = false;
		
		vsp += grav;
	}
	
	state_cooldown = approach(state_cooldown, 0, 1);
	
	
	var hsp_final = hsp;
	if (place_meeting(x+hsp_final, y, obj_wall)) {
		while (!place_meeting(x+sign(hsp_final), y, obj_wall)) {
			x += sign(hsp_final);
		}
		hsp = 0;
		hsp_final = 0;
	}
	x += hsp_final;
	
	// Vertical collision
	var vsp_final = vsp;
	if (place_meeting(x, y+vsp_final, obj_wall)) {
		while (!place_meeting(x, y+sign(vsp_final), obj_wall)) {
			y += sign(vsp_final);
		}
		vsp = 0;
		hsp = 0;
		vsp_final = 0;
	}
	y += vsp_final;
}

function change_state(s) {
	if (state_cooldown != 0) return;
	
	state = s;
	
	switch (state) {
		case 0:
			// Set sprite
			sprite_index = spr_corn_mouse_land;
			
			hsp = 0;
			
			break;
		
		case 1:
			// Set speed
			hsp = spd * dir * random_range(0.95, 1.05);
			vsp = -jump_spd;
				
			// Set sprite
			sprite_index = spr_corn_mouse_jump;
			
			state_cooldown = 15;
			break;
	}
}



set_hp(3);

state = 0;

dir = -1;

on_ground = true;

hsp = 0;
vsp = 0;

spd = 1.5;
jump_spd = 1.5;

grav = 0.1;

range = 150;

state_cooldown = 0;

hit_player = 0;