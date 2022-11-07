/// @desc

if (global.transition_scroll_lock) return;

var t = wrap_pingpong(timer/spd, 0, 2*pi);

x = xstart + x_amp * (t - sin(t)) - pi*x_amp;
y = ystart + vsp * timer + y_amp * (1 - cos(t));

var dir = x - xstart;
var len = 6.28 * x_amp;

if (dir < -len/3) {
	image_index = 0;
} else if (dir > len/3) {
	image_index = 2;
} else {
	image_index = 1;
}

timer ++;

