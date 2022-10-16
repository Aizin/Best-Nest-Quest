/// @desc

var cx = CX;
var cy = CY;

if (instance_exists(target)) {
	cx = target.x;
	cy = target.y;
	
	cx = clamp(cx-CW/2, 0, room_width-CW);
	cy = clamp(cy-CH/2, 0, room_height-CH);
	
	cx = lerp(CX, cx, 0.4);
	cy = lerp(CY, cy, 0.4);
	
	camera_set_view_pos(CAM, cx, cy);
	
	layer_x("Background_0", cx/2);
	layer_x("Background_1", cx/3);
	layer_x("Background_2", cx/5);
}

