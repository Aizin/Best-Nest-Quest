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
		
		break;
	
	case 2:
		step = approach(step, step_max, 1);
		
		if (step == step_max) {
			instance_destroy();
		}
		break;
}

