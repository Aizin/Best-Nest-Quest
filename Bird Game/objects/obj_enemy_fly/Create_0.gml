/// @desc






// Inherit the parent event
event_inherited();

y_amp = 32;
timer = random_range(0, 2*pi);

set_hp(1);

function step() {
	
	image_xscale = sign(x - target.x);
	
	y = ystart + y_amp * sin(timer/40);
	
	timer ++;
}