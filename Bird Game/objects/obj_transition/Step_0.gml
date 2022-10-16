/// @desc


switch (state) {
	case 0:
		alpha = approach(alpha, 1, 1/alpha_in);
		
		if (alpha == 1) {
			state = 1;
		}
		break;
	
	case 1:
		if (alarm[0] == -1) {
			if (room_to == -1) {
				room_restart();
			} else {
				room_goto(room_to);
			}
			alarm_set(0, alpha_stay);
		}
		break;
	
	case 2:
		alpha = approach(alpha, 0, 1/alpha_out);
		
		if (alpha == 0) {
			instance_destroy();
		}
		break;
}

