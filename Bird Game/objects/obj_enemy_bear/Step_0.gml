/// @desc

image_xscale = xdir;

//Check if grounded
groundCheck();

//do gravity
fall(delta_time);

//Switch on object state
switch(state){
	case States.sleeping:
		sleep();
		break;
		
	case States.waking:
		wake(delta_time);
		break;
		
	case States.rolling:
		roll(delta_time);
		break;
	case States.stunned:
		stunned(delta_time);
		break;
	default:
		break;
	
}


/*
Gator code
if (cooldown == 0 && !collision_point(x+sprite_width/2, y+1, obj_wall, false, true)) {
	dir *= -1;
	cooldown = 16;
}

cooldown = approach(cooldown, 0, 1);

x += spd*dir;

*/

