/// @desc

timer ++;

if (timer % timer_step != 0) return;

switch (state) {
	case 0:
		step = approach(step, step_max, 1);
		
		if (step == step_max) {
			state = 1;
			step = 0;
		}
		break;
	
	case 1:
		if (alarm[0] == -1) {
			
			alarm_set(0, step_timer_stay);
		}
		break;
	
	case 2:
		step = approach(step, step_max, 1);
		
		if (step == step_max) {
			instance_destroy();
		}
		break;
}

