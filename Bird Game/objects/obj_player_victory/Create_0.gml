/// @desc


grav = 0.27;
glide_grav = 0.1;

spd = 1.6;
jump_spd = 5.75;

hsp = 0;
vsp = 0;

dir = 1

state = 0;

xgoal = x;

if (instance_exists(obj_camera_follower)) {
	obj_camera_follower.follow = self;
}

finished = false;