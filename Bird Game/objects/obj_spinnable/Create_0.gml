/// @desc

function spin_hit() {
	
}

function on_touch() {}
function peck_hit() {}

invincible_duration = 40;
invincible = false;

function set_invincible(t=invincible_duration) {
	invincible = true;
	alarm_set(0, t);
}