/// @desc

function draw_rectangle_w(x1, y1, x2, y2, outline, w=1) {
	x1 --; y1 --; x2 --; y2 --;
	draw_line_width(x1, y1, x2, y1, w);
	draw_line_width(x2, y1, x2, y2, w);
	draw_line_width(x2, y2, x1, y2, w);
	draw_line_width(x1, y2, x1, y1, w);
	
	if (!outline) {
		draw_rectangle(x1+1, y1+1, x2, y2, 0);
	}
}