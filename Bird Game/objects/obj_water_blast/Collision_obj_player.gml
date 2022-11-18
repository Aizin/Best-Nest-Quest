/// @desc

if (!active) return;

var s = strength;
var extra = global.key_jump;

other.spinning = true;
other.spin_ready = false;
other.gliding = false;

if (other.vsp < 1) {
	s += extra/2;
}

if (other.vsp > -5) {
	other.vsp -= s;
}

