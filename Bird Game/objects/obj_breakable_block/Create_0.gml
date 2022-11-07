/// @desc

event_inherited();

image_speed = 0;

wall = instance_create_depth(x, y, 0, obj_wall);
wall.spinnable = true;

state = 0;
state_max = image_number;

function damage() {
	state = approach(state, state_max, 1);
	
	if (state == state_max) {
		instance_destroy();
		
		play_sound(snd_breakable_block_destroy);
		
		instance_create_depth(x, y, depth, obj_debris, {xdir: 1, ydir:1});
		instance_create_depth(x, y, depth, obj_debris, {xdir: -1, ydir:1});
		instance_create_depth(x, y, depth, obj_debris, {xdir: 1, ydir:0});
		instance_create_depth(x, y, depth, obj_debris, {xdir: -1, ydir:0});
	} else {
		image_index = state;
		
		play_sound(snd_breakable_block_hit);
	}
}

function peck_hit() {
	damage();
}

function spin_hit() {
	damage();
}
