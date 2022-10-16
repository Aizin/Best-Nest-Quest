

#region Process movement

if (freeze_input == 0) {
	
	// Get horizontal input axis
	var xaxis = global.key_right - global.key_left;

	// Horizontal movement
	if (xaxis != 0) {
		hsp = approach(hsp, xaxis*spd, acc);
		dir = xaxis;
	} else {
		hsp = approach(hsp, 0, fric);
	}
}

// Determine if we are on ground
on_ground = place_meeting(x, y+1, obj_wall);

var float = false;

if (on_ground) {
	
	// Jump
	if (global.key_jump_pressed && freeze_input == 0) {
		vsp = -jump_spd;
	}
	
	// Reset state
	float_counter = 0;
	spin_ready = false;
	spin = false;
} else {
	
	// Determine if we should float
	float = !spin && global.key_jump && vsp > 0;
	
	// Get values based on floating or not
	var g = float ? float_grav : grav;
	var vm = float ? float_vsp_max: vsp_max;
	
	// Apply gravity
	vsp = approach(vsp, vm, g);
	
	if (!spin) {
		if (global.key_jump_released && vsp < 0) {
			vsp = max(vsp, -jump_spd/4);
		}
		
		if (float) {
			float_counter ++;
		}
		if (float_counter >= 45) {
			spin_ready = true;
		}
	
		if (spin_ready && vsp > 0 && global.key_jump_released) {
			spin = true;
			vsp = -jump_spd;
			spin_ready = false;
		}
	}
}

var spinnable_inst = instance_place(x, y+vsp+8, obj_spinnable);
if (instance_exists(spinnable_inst)) {
	if (spin && spin_cooldown == 0) {
		spin_cooldown = 10;
		
		vsp = -jump_spd/(1.1 + 0.4 * !global.key_jump);
		spinnable_inst.spin_hit();
	} else {
		spinnable_inst.on_touch(self);
	}
		
}

spin_cooldown = approach(spin_cooldown, 0, 1);

#region Move and collide

var hsp_final = hsp + hsp_knockback;

// Horizontal collision
if (place_meeting(x+hsp_final, y, obj_wall)) {
	while (!place_meeting(x+sign(hsp_final), y, obj_wall)) {
		x += sign(hsp_final);
	}
	hsp_final = 0;
	hsp = 0;
	hsp_knockback = 0;
}
x += hsp_final;

var vsp_final = vsp;

// Vertical collision
if (place_meeting(x, y+vsp_final, obj_wall)) {
	while (!place_meeting(x, y+sign(vsp_final), obj_wall)) {
		y += sign(vsp_final);
	}
	vsp_final = 0;
	vsp = 0;
	hsp_knockback = 0;
}
y += vsp_final;

#endregion

#endregion

freeze_input = approach(freeze_input, 0, 1);

invincible_timer = approach(invincible_timer, 0, 1);
if (invincible_timer == 0) {
	invincible = false;
}

#region Process Animation
if (on_ground) {
	if (hsp != 0 && !place_meeting(x+dir, y, obj_wall)) {
		sprite_index = spr_player_walk;
	} else {
		sprite_index = spr_player_idle;
	}
} else {
	if (spin_ready) {
		sprite_index = spr_player_spinready;
	} else if (float) {
		sprite_index = spr_player_glide;
	} else if (spin) {
		sprite_index = spr_player_spin;
	} else if (vsp > 0) {
		sprite_index = spr_player_fall;
	} else {
		sprite_index = spr_player_jump;
	}
}
#endregion

if (y > room_height+48 && alarm[0] == -1) {
	alarm_set(0, 5);	
}