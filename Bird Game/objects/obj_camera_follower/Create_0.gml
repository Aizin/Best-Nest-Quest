/// @desc

follow = obj_player;

function step() {
	if (!instance_exists(follow)) return;
	
	var xx = follow.x;
	var yy = follow.y;
	
	x = xx;
	y = yy;
		
	if (instance_exists(global.cur_room)) {
		x = clamp(x, global.cur_room.bbox_left + CW/2, global.cur_room.bbox_right - CW/2);
		y = clamp(y, global.cur_room.bbox_top + CH/2, global.cur_room.bbox_bottom - CH/2);
	}
	
	
	var a = collision_point(xx, yy, obj_camera_anchor, 0, 1);
	if (instance_exists(a)) {
		var ax = a.x_anchor;
		var ay = a.y_anchor;
		
		x = lerp(x, ax, 0.2);
		y = lerp(y, ay, 0.35);
	}
}

