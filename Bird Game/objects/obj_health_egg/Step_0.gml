/// @desc


vsp += grav;

x += hsp;
y += vsp;

cooldown = approach(cooldown, 0, 1);

if (place_meeting(x, y, obj_wall)) {
	instance_destroy();
	instance_create_depth(x, y, depth, obj_health_egg_cracked)
}

if (place_meeting(x, y, obj_player) && cooldown == 0) {
	instance_destroy();
	obj_player.heal(1);
	
}