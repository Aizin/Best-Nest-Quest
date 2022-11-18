/// @desc

state = 0;

alpha = 0;

global.player_frozen = true;


step_size = 16;
step_timer_stay = 20;

timer_step = 4;
timer = 0;

finish_early = false;

step = 0;
step_max = ceil(CW / step_size);

room_to = -1;

depth -= 1000;

transition_type = 0;

function xpos() {return CX};
function ypos() {return CY};

function set_step_size(v) {
	step_size = v;
	step_max = ceil(CW / step_size);

}