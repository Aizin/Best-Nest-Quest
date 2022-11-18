/// @desc
if (!instance_exists(follow)) exit;

var cx = CX;
var cy = CY;
var cw = CW;
var ch = CH;

follow.step();

if (instance_exists(global.cur_room) && !init) {
	init = true;
	camera_set_view_pos(CAM, global.cur_room.bbox_left, global.cur_room.bbox_top);
	cx = CX;
	cy = CY;
	return;	
}

var cx_goal = follow.x - CW/2;
var cy_goal = follow.y - CH/2;

if (global.transition_scroll_lock) {
	cx = approach(cx, cx_goal, 8);
	
	if (cx == cx_goal) {
		global.transition_scroll_lock = false;
		
		if (instance_exists(obj_player)) {
			with (obj_player) {
				if (instance_exists(old_room)) {
					old_room.enter_room();
				}
			}
		}
	}
} else {
	cx = lerp(cx, cx_goal, 0.1);
	cy = lerp(cy, cy_goal, 0.1);
}

cx += shake_x;
cy += shake_y;

cx = clamp(cx, 0, room_width-CW);
cy = clamp(cy, 0, room_height-CH);

var xx = cx;
var yy = cy;

// Set camera pos
camera_set_view_pos(CAM, xx, yy);

