/// @desc

// Inherit the parent event
event_inherited();

set_hp(1);

state = 0; // (0, 1) | (float, target)

range = 8;
max_range = CW/2
x_amp = 48;
y_amp = 32;

vsp = 0.2;
t_spd = 250;

dir = -1;

image_speed = 0;

timer = 0;
angle = 0;

function target_outside_room() {
	x_anchor = xstart;
	y_anchor = ystart;
}

function step() {
	timer ++;
	
	switch (state) {
		case 0:
			
			var t = wrap_pingpong(timer/t_spd, 0, 2*pi);

			x = x_anchor + x_amp/pi * (t - sin(t)) - x_amp;
			y = y_anchor + y_amp/2 * (1 - cos(t));
			
			var dist = x - target.x;
			
			if (abs(dist) < max_range) {
				y_anchor += vsp;
			}
			
			
			var dir = x - x_anchor;
			var len = x_amp;
			
			if (dir < -len/3) {
				if (dist > range && dist < max_range && state_cooldown == 0) {
					change_state(1);
				}
				
				image_index = 1 - self.dir;
			} else if (dir > len/3) {
				image_index = 1 + self.dir;
			} else {
				image_index = 1;
				
				if (dist > -max_range && dist < -range && state_cooldown == 0) {
					change_state(1);
				}
			}
			
			state_cooldown = approach(state_cooldown, 0, 1);
			break;
		
		case 1:
			if (wait_cooldown == 0) {
				x += lengthdir_x(spd, angle);
				y += lengthdir_y(spd, angle);
				
				spd = approach(spd, 0, 0.025);
				
				if (sign(target.x - x) != self.dir) {
					spd = approach(spd, 0, 0.1);
				}
				
				if (spd == 0) {
					change_state(0);
				}
			} else {
				wait_cooldown = approach(wait_cooldown, 0, 1);
				
				if (wait_cooldown % 4 == 0) {
					x = x_anchor + irandom_range(-3, 3);
					y = y_anchor + irandom_range(-3, 3);
				}
				if (wait_cooldown == 0) {
					x = x_anchor;
					y = y_anchor;
					
					
					spd = max_spd * clamp(distance_to_object(target)/100, 1, 3) * random_range(0.95, 1.05);
				}
			}
			
			break;
	}
}
x_anchor = x;
y_anchor = y;

state_cooldown = 0;

spd = 0;
max_spd = 2.5;

function change_state(s) {
	state = s;
	
	x_anchor = x;
	y_anchor = y;
	
	dir = sign(target.x - x);
	image_xscale = dir;

	switch (state) {
		case 1:
			angle = point_direction(x, y, target.x, target.y) + random_range(-5, 5);
			
			wait_cooldown = 40;
			break;
		
		case 0:
			if (dir == 1) {
				timer = 0;
				x_anchor += x_amp;
			} else {
				timer = pi/2 * t_spd;
				x_anchor -= x_amp;
			}
			
			state_cooldown = 60;
			break;
	}
}