/// @desc

state = 2;

if (room_to == -1) {
	room_restart();
} else {
	room_goto(room_to);
}

if (finish_early) {
	instance_destroy();
}
