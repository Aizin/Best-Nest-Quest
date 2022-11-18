/// @desc

// Inherit the parent event
event_inherited();

set_hp(4);

dir = -1;

state = 0; // (0, 1, 2) | (Idle, Walk, Roll)

range = 200;

spd = 0.4;

hsp = 0;
vsp = 0;

static_behavior = false;

hsp_knockback = 0;

roll_spd = 1.5;
roll_jump_spd = 2.5;

grav = 0.3;

damage_sound = snd_breakable_block_hit;
die_sound = snd_breakable_block_destroy;

function step() {
	image_xscale = dir;
	
	switch (state) {
		case 0:
			if (alarm[0] == -1) {
				alarm_set(0, irandom_range(30, 180));
			}
			break;
			
		case 1:
			if (!place_meeting(x + dir * sprite_width/2, y + 16, obj_wall) && vsp == 0) {
				change_state(0);
				dir *= -1;
			}
			break;
			
		case 2:
			break;
	}
	
	if (instance_exists(target)) {
		if (state != 2) {
			if (distance_to_object(target) < range && sign(target.x - x) == dir && (!static_behavior || (target.y > bbox_top+8))) {
				change_state(2);
			}
		}
	}
	
	if (!place_meeting(x, y+1, obj_wall)) {
		vsp += grav;
	}
	
	hsp_knockback = approach(hsp_knockback, 0, 0.1);
	
	
	
	var hsp_final = hsp + hsp_knockback;
	if (place_meeting(x+hsp_final, y, obj_wall)) {
		
		if (state != 0) {
			change_state(0);
			dir *= -1;
		}
		
		while (!place_meeting(x+sign(hsp_final), y, obj_wall)) {
			x += sign(hsp_final);
		}
		hsp_knockback = 0;
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
		if (state == 2 && abs(vsp) > 1 ) {
			vsp = -vsp/2;
		} else {
			vsp = 0;
		}
		vsp_final = vsp;
	}
	y += vsp_final;
}

function change_state(s) {
	state = s;
	
	if (static_behavior) {
		if (state == 1) {
			state = 0;
		}
	}
	
	switch (state) {
		case 0:
			sprite_index = spr_rock_bear_idle;
			
			hsp = 0;
			break;
			
		case 1:
			sprite_index = spr_rock_bear_walk;
			
			hsp = dir*spd;
			
			break;
			
		case 2:
			sprite_index = spr_rock_bear_roll;
			
			hsp = dir*roll_spd;
			vsp = -roll_jump_spd;
			
			static_behavior = false;
			break;
	}
}

function on_peck(dir) {
	hsp_knockback = dir * 2;
	self.dir = dir;
	change_state(2);
}