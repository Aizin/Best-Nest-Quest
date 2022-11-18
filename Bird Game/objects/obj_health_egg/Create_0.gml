/// @desc

spd = random_range(0.8,1);
hsp = choose(1, -1) * spd;
vsp = -random_range(1.8,2.5);

grav = random_range(0.05, 0.065);

cooldown = 40;

image_speed = sign(hsp);

in_wall = false;
out_wall = false;

timer = 0;