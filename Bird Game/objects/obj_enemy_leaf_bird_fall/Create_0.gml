/// @desc

// Inherit the parent event
event_inherited();

set_hp(2);

state = 0; // (0, 1) | (float, target)

range = 80;

x_amp = 1;
y_amp = 1;

vsp = 0.2;
t_spd = 250;

ignore_room_boundry = true;

image_speed = 0;

parent = noone;

function step() {
	switch (state) {
		case 0:
			
			var timer = 0;
			if (instance_exists(parent)) {
				timer = parent.timer;
				
				if (bbox_top > parent.bbox_bottom) {
					instance_destroy();
				}
			} else {
				instance_destroy();
			}
			
			if (target.y > y && distance_to_object(target) < range) {
				//state = 1;
			}
			
			var t = wrap_pingpong(timer/t_spd, 0, 2*pi);

			x = xstart + x_amp/pi * (t - sin(t)) - x_amp;
			y = ystart + y_amp/2 * (1 - cos(t));
			
			ystart += vsp;
			
			
			var dir = x - xstart;
			var len = x_amp;
			
			if (dir < -len/3) {
				image_index = 0;
			} else if (dir > len/3) {
				image_index = 2;
			} else {
				image_index = 1;
			}
			


			break;
	}
}