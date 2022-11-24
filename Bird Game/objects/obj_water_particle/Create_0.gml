/// @desc

color = make_color_rgb(0, 136, 252);

hsp = choose(1, -1) * random_range(0.5,1);
vsp = random_range(-1, -2);

grav = 0.1;

life = irandom_range(20, 40);

alarm_set(0, life);

