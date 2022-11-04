/// @desc

event_inherited();

image_speed = 0;

wall = instance_create_depth(x, y, 0, obj_wall);

state = 0;
state_max = image_number;

function spin_hit() {
	state = approach(state, state_max, 1);
	
	if (state == state_max) {
		instance_destroy();
		
		instance_create_depth(x, y, depth, obj_debris, {xdir: 1, ydir:1});
		instance_create_depth(x, y, depth, obj_debris, {xdir: -1, ydir:1});
		instance_create_depth(x, y, depth, obj_debris, {xdir: 1, ydir:0});
		instance_create_depth(x, y, depth, obj_debris, {xdir: -1, ydir:0});
	} else {
		image_index = state;
	}
}
