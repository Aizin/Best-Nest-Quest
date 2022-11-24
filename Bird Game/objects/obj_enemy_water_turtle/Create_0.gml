/// @desc


// Inherit the parent event
event_inherited();


function damage() {}

function spin_hit() {
	if (state == 2) {
		if (instance_exists(blast_inst)) {
			with (blast_inst) {
				alarm_set(0, life);
			}
		}
	} else {
		change_state(1);
	}
}

state = 0; // (0, 1, 2) | (idle, blast_ready, blast)

blast_inst = noone;



function change_state(s) {
	state = s;
	image_index = 0;
	
	switch (state) {
		case 0:
			sprite_index = spr_water_turtle_idle;
			break;
		
		case 1:
			sprite_index = spr_water_turtle_blast_ready;
			break;
			
		case 2:
			sprite_index = spr_water_turtle_blast;
			
			blast_inst = instance_create_depth(x, bbox_top+2, depth+5, obj_water_blast);
			blast_inst.parent = self;
			break;
	}
}

function water_blast_finish() {
	change_state(0);
}