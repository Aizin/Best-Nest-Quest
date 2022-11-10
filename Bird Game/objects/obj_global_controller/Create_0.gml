/// @desc Init variables

randomize();

global.debug = true;
global.cur_room = noone;

global.transition_scroll_lock = false;

function get_input() {
	global.key_left = keyboard_check(vk_left);
	global.key_right = keyboard_check(vk_right);
	global.key_jump = keyboard_check(ord("Z"));
	
	global.key_jump_pressed = keyboard_check_pressed(ord("Z"));
	
	global.key_jump_released = keyboard_check_released(ord("Z"));
}
get_input();

global.hp_max = 5;
global.hp = 5;

#macro CAM view_camera[0]
#macro CX camera_get_view_x(CAM)
#macro CY camera_get_view_y(CAM)
#macro CW camera_get_view_width(CAM)
#macro CH camera_get_view_height(CAM)