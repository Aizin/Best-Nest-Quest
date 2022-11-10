/// @desc


spawn_timer = 200;

rad = sprite_width/2;
spawn_x = bbox_left + rad;
spawn_y = bbox_top;

vsp = 0.4;

t_spd = 400;

function spawn(xx=spawn_x, yy=spawn_y) {
	var b = instance_create_depth(xx, yy, depth, obj_enemy_leaf_bird_fall);
	b.x_amp = rad;
	b.y_amp = b.x_amp;
	b.parent = self;
	b.vsp = vsp;
	b.t_spd = t_spd;
}

timer = 0;

var count = sprite_height div (spawn_timer * vsp)
log("%, %", spawn_timer * vsp, count)
for (var i = 0; i < count; i ++) {
	spawn(, spawn_y + i * spawn_timer * vsp);
}
