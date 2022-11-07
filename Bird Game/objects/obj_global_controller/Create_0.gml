/// @desc Init variables

randomize();

global.debug = false;
global.cur_room = noone;

global.transition_scroll_lock = false;

global.player_frozen = false;

draw_set_font(fnt_main);

load_game("save0.txt");

music_ag_loaded = false;
audio_group_load(ag_music);
audio_group_load(ag_sounds);

global_timer = 0;

#macro DEVICE_INDEX 0
gp_axis_pressed_cooldown = 15;

function get_input() {
	global.key_right = keyboard_check(vk_right);
	global.key_left = keyboard_check(vk_left);
	global.key_jump = keyboard_check(ord("Z"))
	global.key_peck = keyboard_check(ord("X"))
	
	global.key_right_pressed = keyboard_check_pressed(vk_right);
	global.key_left_pressed = keyboard_check_pressed(vk_left);
	global.key_up_pressed = keyboard_check_pressed(vk_up);
	global.key_down_pressed = keyboard_check_pressed(vk_down);
	
	global.key_jump_pressed = keyboard_check_pressed(ord("Z"));
	global.key_peck_pressed = keyboard_check_pressed(ord("X"));
	
	global.key_jump_released = keyboard_check_released(ord("Z"));
	
	global.key_pause_pressed = keyboard_check_pressed(vk_escape);
	
	if (gamepad_is_connected(DEVICE_INDEX)) {
		var deadzone = 0.2;
		
		var h_stick = gamepad_axis_value(DEVICE_INDEX, gp_axislh);
		var v_stick = gamepad_axis_value(DEVICE_INDEX, gp_axislv);
		
		global.key_right |= gamepad_button_check(DEVICE_INDEX, gp_padr) || h_stick > deadzone;
		global.key_left  |= gamepad_button_check(DEVICE_INDEX, gp_padl) || h_stick < -deadzone;
		global.key_jump  |= gamepad_button_check(DEVICE_INDEX, gp_face1);
		global.key_peck  |= gamepad_button_check(DEVICE_INDEX, gp_face3);
		
		h_stick *= alarm[11] == -1;
		v_stick *= alarm[11] == -1;
		
		global.key_right_pressed |= gamepad_button_check_pressed(DEVICE_INDEX, gp_padr) || h_stick > deadzone;
		global.key_left_pressed  |= gamepad_button_check_pressed(DEVICE_INDEX, gp_padl) || h_stick < -deadzone;
		global.key_up_pressed    |= gamepad_button_check_pressed(DEVICE_INDEX, gp_padu) || v_stick < -deadzone;
		global.key_down_pressed  |= gamepad_button_check_pressed(DEVICE_INDEX, gp_padd) || v_stick > deadzone;
		
		if (abs(h_stick) > deadzone || abs(v_stick) > deadzone) {
			alarm_set(11, gp_axis_pressed_cooldown)
		}
		
		global.key_jump_pressed |= gamepad_button_check_pressed(DEVICE_INDEX, gp_face1);
		global.key_peck_pressed |= gamepad_button_check_pressed(DEVICE_INDEX, gp_face3);
	
		global.key_jump_released |= gamepad_button_check_released(DEVICE_INDEX, gp_face1);
		
		global.key_pause_pressed |= gamepad_button_check_pressed(DEVICE_INDEX, gp_start);
	}
}
get_input();

global.hp_max = 5;
global.hp = 5;

#macro CAM view_camera[0]
#macro CX camera_get_view_x(CAM)
#macro CY camera_get_view_y(CAM)
#macro CW camera_get_view_width(CAM)
#macro CH camera_get_view_height(CAM)