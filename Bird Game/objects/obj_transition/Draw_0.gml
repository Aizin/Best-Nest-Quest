/// @desc


draw_set_color(c_black);

var x1, y1, x2, y2;

x1 = 0;
y1 = 0;
y2 = CH;
x2 = CW;

switch (transition_type) {
	case 0:
		if (state == 0) {
			x1 = CW - step_size * step;
		} else if (state == 1) {
			x1 = 0; 
		} else {
			x1 = -step_size * step;
			x2 = x1 + CW;
		}

		draw_rectangle(CX + x1, CY + y1, CX + x2, CY + y2, 0);
		break;
	
	case 1:
		draw_sprite_stretched(spr_transition_square, min(floor(timer/30), sprite_get_number(spr_transition_square)-1), CX, CY, CW, CH);
		break;
}

draw_set_color(c_white);



