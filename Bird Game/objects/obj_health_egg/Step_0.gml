/// @desc


vsp += grav;

if (vsp > 0 && !out_wall && place_meeting(x, y, obj_wall)) {
	in_wall = true;
}

if (in_wall && !place_meeting(x, y, obj_wall)) {
	in_wall = false;
	out_wall = true;
}

function collide_check(x, y, obj) {
	return place_meeting(x, y, obj);
}

cooldown = approach(cooldown, 0, 1);

if (!in_wall && vsp > 0) {
	if (collide_check(x+hsp, y, obj_wall)) {
		while (!collide_check(x+sign(hsp), y, obj_wall)) {
			x += sign(hsp);
		}
		
		var e = instance_create_depth(x + sign(hsp) * sprite_width/2, y, depth, obj_health_egg_cracked);
		
		e.image_angle = 90 * sign(hsp);
		
		instance_destroy();

	} else if (collide_check(x, y+vsp, obj_wall)) {
		while (!collide_check(x, y+sign(vsp), obj_wall)) {
			y += sign(vsp);
		}
		
		instance_create_depth(x, y + sign(vsp) * sprite_height/2, depth, obj_health_egg_cracked);
		
		instance_destroy();
	}
}

x += hsp;
y += vsp;

if (place_meeting(x, y, obj_player) && cooldown == 0) {
	instance_destroy();
	obj_player.heal(1);
	
}