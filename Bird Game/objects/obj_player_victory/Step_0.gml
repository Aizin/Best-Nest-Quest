/// @desc

image_xscale = dir;


if (state == 0) {
	vsp += grav;
	
	if (place_meeting(x+hsp, y, obj_wall)) {
		while (!place_meeting(x+sign(hsp), y, obj_wall)) {
			x += sign(hsp);
		}
		hsp = 0;
	}
	if (place_meeting(x, y+vsp, obj_wall)) {
		while (!place_meeting(x, y+sign(vsp), obj_wall)) {
			y += sign(vsp);
		}
		vsp = 0;
		hsp = 0;
		
		state = 1;
	}
} else if (state == 1) {
	dir = sign(xgoal - x);
	
	x = approach(x, xgoal, 1);
	sprite_index = spr_player_walk;
	
	if (x == xgoal) {
		sprite_index = spr_player_idle;
		state = 2;
	}
} else if (state == 2) {
	if (alarm[0] == -1) {
		alarm_set(0, 60);
	}
} else {
	dir = -1;
	
	if (alarm[2] == -1 && !finished) {
		alarm_set(2, 360);
	}
	
	vsp += grav;
	if (place_meeting(x, y+vsp, obj_wall)) {
		while (!place_meeting(x, y+sign(vsp), obj_wall)) {
			y += sign(vsp);
		}
		vsp = -jump_spd*0.75;
	}
	
	if (vsp > 0) {
		sprite_index = spr_player_fall;
	} else {
		sprite_index = spr_player_jump;
	}
}

x += hsp;
y += vsp;
