/// @desc

var w = CW, h = 8;
var x1 = CX, y1 = CY+CH-h;
var x2 = x1+w, y2 = y1+h;


/*
draw_set_color(c_black);

draw_rectangle(x1, y1, x2, y2, 0);

draw_set_color(c_white);

*/

y1=CY+8;

var h_x = 8;
var h_y = 0;
for (var i = 0; i < global.hp_max; i ++) {
	var filled = i < global.hp;
	draw_sprite(spr_hud_egg, filled, x1+h_x+8*i, y1+h_y);
}

/*

var xx = CX - 16, yy = CY;
draw_rectangle_w(xx + 40, yy + 8 , xx + 44, yy + 16, 1);
draw_rectangle_w(xx + 40, yy + 20, xx + 44, yy + 28, 1);
draw_rectangle_w(xx + 32, yy + 16, xx + 40, yy + 20, !global.key_left);
draw_rectangle_w(xx + 44, yy + 16, xx + 52, yy + 20, !global.key_right);
draw_rectangle_w(xx + 52 + 8 - 4, yy + 18 - 4, xx + 52 + 8 + 4, yy + 18 + 4, !global.key_jump);