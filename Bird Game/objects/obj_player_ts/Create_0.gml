/// @desc

collision_map = global.collision_map

// Speeds
spd = 2;
jump_spd = 6;
hsp = 0;
vsp = 0;
vsp_max = 5.5;

// Environment
grav = 0.275;
fric = 0.3;
acc = 0.3;

dir = 1;

float_grav = 0.2;
float_vsp_max = 0.75;
float_counter = 0;

spin_ready = false;
spin = false;
spin_cooldown = 0;

// States
on_ground = false;

freeze_input = 0;

hsp_knockback = 0;
knockback_vsp = 3
knockback_hsp = 1.2;

invincible = false;
invincible_timer = 0;
invincible_duration = 60;

function process_collision() {
	var res = false;
	var TS = 16;
	
	if (tilemap_get_at_pixel(collision_map, x+hsp, y) > 0) {
		x -= x mod TS;
		if (sign(hsp) == 1) x += TS - 1;
		hsp = 0;
		res = true;
	}

	x += hsp;

	if (tilemap_get_at_pixel(collision_map, x, y+vsp) > 0) {
		y -= y mod TS;
		if (sign(vsp) == 1) y += TS - 1;
		vsp = 0;
		res = true;
	}

	y += vsp
}

