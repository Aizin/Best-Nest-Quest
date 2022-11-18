/// @desc






// Inherit the parent event
event_inherited();

set_hp(1);

hsp = 0;
vsp = 0;
grav = 0.05;

function spin_hit() {
	if (instance_exists(target)) {
		if (target.vsp > 0) {
			damage(1);
		}
	}
}

function step() {
	if (place_meeting(x, y, obj_wall)) {
		instance_create_depth(x,y,depth,obj_sprite_animation,{sprite_index: spr_ink_blob_splat})
		instance_destroy();
	}
	
	vsp += grav;
	
	x += hsp;
	y += vsp;
	
}