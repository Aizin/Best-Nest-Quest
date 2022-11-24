/// @desc

// Inherit the parent event
event_inherited();

set_hp(2);

state = 0; // (0, 1, 2, 3) - (idle, jump, drill, fall)
dir = -1;

hsp = 0;
vsp = 0;

jump_spd = 5.75;
grav = 0.27;

spd = 1;

range = 128;

cooldown_timer = 0;

function peck_hit(dir) {
	on_peck(dir);
	if ((state != 4 && state != 2) || dir == self.dir) {
		vsp = -3;
		hsp = 2*dir;
		
		if (state == 4 || state == 2) {
			change_state(3);
		}
		
		return damage(1);
	} else {
		return true;
	}
	
}

function step() {
	image_xscale = dir;
	
	switch (state) {
		
		case 0:
			cooldown_timer = approach(cooldown_timer, 0, 1);
			
			if (cooldown_timer != 0) break;
			
			dir = sign(target.x - x);
			if (distance_to_object(target) < range && target.y <= y+8) {
				change_state(1);
			}
			break;
		
		case 1:
			if (vsp >= 0) {
				change_state(2);
			}
			break;
		
		case 3:
			if (place_meeting(x,y+1,obj_wall)) {
				change_state(0);
			}
			break;
	}
	
	if (state != 4 && state != 2) {
		vsp += grav;
	}
	
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

function change_state(new_state) {
	state = new_state;
	switch (state) {
		case 0:
			sprite_index = spr_frog_knight_idle;
			hsp = 0;
			cooldown_timer = irandom_range(30, 70);
			break;
		
		case 1:
			sprite_index = spr_frog_knight_jump;
			
			var s = jump_spd * 3/4;
			var dist = abs(y - target.y);
			
			if (dist >= 32) {
				s = jump_spd;
			}
			
			vsp = -s;
			hsp = 0;
			break;
		
		case 2:
			hsp = 0;
			vsp = 0;
			sprite_index = spr_frog_knight_drill_transition;
			break;
		
		case 3:
			sprite_index = spr_frog_knight_fall;
			break;
		
		case 4:
			hsp = dir * spd;
			vsp = 0;
			sprite_index = spr_frog_knight_drill;
			alarm_set(0, 50);
			break;
	}
}