/// @desc

event_inherited();

function step() {}

function target_outside_room() {}

function spin_hit() {
	damage(1);
}

function peck_hit(dir) {
	on_peck(dir);
	return damage(1);
	
}

function on_peck() {}

function on_touch(player) {
	player.damage(1);
}

function set_hp(val) {
	hp_max = val;
	hp = val;
}

hp_max = 1;
hp = 1;

ignore_room_boundry = false;

damage_sound = snd_enemy_hit;
die_sound = snd_enemy_die;

damage_range = 4;
shake_x = 0;
shake_y = 0;

damage_flash = false;
damage_flash_duration = 45;
function set_damage_flash() {
	damage_flash = true;
	alarm_set(11, damage_flash_duration);
}

function damage(str=1) {
	
	// Reduce health
	hp = approach(hp, 0, str);
	
	// Start flash
	set_damage_flash();
	
	// Determine if enemy is dead
	if (hp == 0) {
		
		die();
		
		// Enemy is not alive
		return false;
	} else {
		
		// Play damage sound
		play_sound(damage_sound);
		
		// Enemy is still alive
		return true;
	}
}

function die() {
	// Make particle
	instance_create_depth(x,y,depth,obj_sprite_animation,{sprite_index: spr_smoke_poof})
		
	// Destroy self
	instance_destroy();
		
	// Play death sound
	play_sound(die_sound);
}


target = obj_player;


room_inst = instance_place(x,y,obj_room);
