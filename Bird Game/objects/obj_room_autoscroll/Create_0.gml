/// @desc

// Inherit the parent event
event_inherited();

if (debug_stop && global.debug) {
	instance_destroy();
	instance_create_depth(x, y, depth, obj_room, {image_xscale: (bbox_right - bbox_left)/sprite_get_width(sprite_index), image_yscale: (bbox_bottom - bbox_top)/sprite_get_height(sprite_index)})
	
	if (instance_exists(obj_enemy_parent)) {
		with (obj_enemy_parent) {
			if (variable_struct_get(self, "calibrate_room") != undefined) {
				calibrate_room();
			}
		}
	}
}

wall_instances = [];

boundry_kill = false;

xdir = 1;
ydir = 1;

x_goal = x;
y_goal = y;

width = CW;
height = CH;

wait_timer = 120;
wait_finished = false;

spd = 0.32;

full_width = sprite_width;
full_height = sprite_height;

function set_dims(w, h) {
	image_xscale = w / sprite_get_width(sprite_index);
	image_yscale = h / sprite_get_height(sprite_index);
}

function enter_room() {
	if (xdir == 1) {
		x_goal = bbox_right - width;
		x = bbox_left;
	} else {
		x_goal = bbox_left;
		x = bbox_right - width;
		
	}
	
	if (ydir == 1) {
		y_goal = bbox_top;
		y = bbox_bottom - height;
		
	} else {
		y_goal = bbox_bottom - height;
		y = bbox_top;
		
	}
	
	set_dims(width, height);
	
	var padding = 2;
	
	var w_top = instance_create_layer(x, y-32, "Walls", obj_wall_nopeck, 
	{
		image_xscale: width/16, 
		ox:0, oy:-32
	});
	//var w_right = instance_create_layer(x + width, y, "Walls", obj_wall_nopeck, 
	//{
	//	image_yscale: height/16,
	//	ox: width, oy:0
	//});
	//var w_left = instance_create_layer(x-16, y, "Walls", obj_wall_nopeck, 
	//{
	//	image_yscale: height/16,
	//	ox: -16, oy:0
	//});
	instance_create_layer(x-16, y, "Walls", obj_wall_nopeck, {image_yscale: height/16+padding,});
	var w_bottom = instance_create_layer(x, y + height+padding*16, "Walls", obj_death_zone, 
	{
		image_xscale: width/16, 
		ox:0, oy:height+padding*16
	})
	
	array_push(wall_instances, w_top/*, w_left, w_right*/, w_bottom);
}

function exit_room() {
	x = xstart;
	y = ystart;
	set_dims(full_width, full_height);
	
	active = false;
	
	for (var i = 0; i < array_length(wall_instances); i ++) {
		var w = wall_instances[i];
		
		if (instance_exists(w)) {
			with (w) {
				instance_destroy();
			}
		}
	}
	
	instance_create_layer(bbox_left, bbox_top, "Walls", obj_wall_nopeck, {image_yscale: full_height/16})
	instance_create_layer(bbox_left, bbox_top, "Walls", obj_wall_nopeck, {image_xscale: full_width/16})
	instance_create_layer(bbox_right-16, bbox_top, "Walls", obj_wall_nopeck, {image_yscale: full_height/16})
	instance_create_layer(bbox_left, bbox_bottom-16, "Walls", obj_wall_nopeck, {image_xscale: full_width/16})
}

function step() {
	if (!global.transition_scroll_lock) {
		if (!wait_finished && alarm[0] == -1) {
			alarm_set(0, wait_timer);
		}
	}
	if (wait_finished) {
		var x_prev = x;
		var y_prev = y;
		x = approach(x, x_goal, spd);
		y = approach(y , y_goal, spd);
		
		for (var i = 0; i < array_length(wall_instances); i ++) {
			var w = wall_instances[i];
			w.x = x + w.ox;
			w.y = y + w.oy;
			w.hsp = x - x_prev;
			w.vsp = y - y_prev;
		}
	}
	
}