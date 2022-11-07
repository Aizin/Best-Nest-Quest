/// @desc

// Inherit the parent event
event_inherited();

set_hp(5);

damage_sprite = {
	spr_enemy_gator: spr_enemy_gator_damage,
}

dir = -1;
spd = 0.3;

cooldown = 0;

function step() {
	image_xscale = dir;

	if (cooldown == 0 && !collision_point(x+sprite_width/2, y+1, obj_wall, false, true)) {
		dir *= -1;
		cooldown = 16;
	}

	cooldown = approach(cooldown, 0, 1);

	x += spd*dir;

}