/// @desc

image_xscale = dir;

//Switch on object state
switch(state){
	case States.sleeping:
		sleep();
		break;
		
	case States.waking:
		wake();
		break;
		
	case States.rolling:
		roll();
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

