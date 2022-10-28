/// @desc Init variables

// Speeds
spd = 1.6;
jump_spd = 5;
hsp = 0;
vsp = 0;
vsp_max = 5.5;

// Environment
grav = 0.19;
fric = 0.3;
acc = 0.3;

dir = 1;

on_ground_buffer = 0;
on_ground_buffer_max = 8;
jump_buffer = 0;
jump_buffer_max = 8;

float_grav = 0.2;
float_vsp_max = 0.75;
float_counter = 0;

spin_ready = false;
spin = false;
spin_cooldown = 0;

// States
on_ground = false;

freeze_input = 0;

// Knockback
hsp_knockback = 0;
knockback_vsp = 3
knockback_hsp = 1.2;

// Invincible states
invincible = false;
invincible_timer = 0;
invincible_duration = 60;

function damage(str=1) {
	
	// Make sure we aren't invinvible
	if (invincible) return;
	
	// Start being invincible
	invincible = true;
	invincible_timer = invincible_duration;
	
	// Stop input
	freeze_input = 30;
	
	// Apply knockback
	vsp = -knockback_vsp;
	hsp = 0;
	hsp_knockback = -dir * knockback_hsp;
	
	// Decrease health
	global.hp = approach(global.hp, 0, str);
	
	// Make health egg particles
	repeat(str) {
		instance_create_depth(x, y-16, depth-10, obj_health_egg);
	}
}

function heal(str=1) {
	global.hp = approach(global.hp, global.hp_max, str);
	
	repeat (irandom_range(3, 5)) {
		var xx = irandom_range(bbox_left-6, bbox_right+6);
		var yy = irandom_range(bbox_top-6, bbox_bottom+6);
		instance_create_depth(xx, yy, depth-10, obj_sparkle);
	}
}

global.hp = global.hp_max;