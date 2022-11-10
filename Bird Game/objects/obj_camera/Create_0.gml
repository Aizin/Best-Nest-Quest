/// @desc

follow = instance_create_layer(x,y,layer,obj_camera_follower);

timer = 0;

shake_x = 0;
shake_y = 0;





var cx = obj_player.x - CW/2;
var cy = obj_player.y - CH/2;

cx = clamp(cx, 0, room_width-CW);
cy = clamp(cy, 0, room_height-CH);

// Set camera pos
camera_set_view_pos(CAM, cx, cy);
