/// @desc

event_inherited();

function spin_hit() {
	damage(1);
}

function on_touch(player) {
	player.damage(1);
}

function set_hp(val) {
	hp_max = val;
	hp = val;
}

hp_max = 1;
hp = 1;


function damage(str=1) {
	hp = approach(hp, 0, str);
	
	if (hp == 0) {
		instance_destroy();
	} else {
		alarm_set(0, flash_timer);
	}
}

damage_sprite = {}

flash_timer = 15;
flash_color = c_red;