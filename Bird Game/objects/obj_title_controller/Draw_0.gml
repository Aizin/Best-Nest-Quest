/// @desc


cur_page.draw_options(216, 80);



var frame_step = 6;

if (!instance_exists(obj_transition)) {
	intro_step += 1/frame_step;
}

var step_size = 16;
var s = floor(intro_step);
var rw = CW;

draw_set_color(c_black);

draw_rectangle(0, 0, rw/2 - s*step_size, CH, 0);
draw_rectangle(CW, 0, rw/2 + s*step_size, CH, 0);

draw_set_color(c_white);

