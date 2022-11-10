/// @desc

s1 = instance_create_depth(x, y, depth, obj_health_egg_shell);
s2 = instance_create_depth(x, y, depth, obj_health_egg_shell);

s1.dir = 1;
s2.dir = -1;

alarm_set(0, 30);

alpha_state = 0;
alpha = 1;