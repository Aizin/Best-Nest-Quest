/// @desc






// Inherit the parent event
event_inherited();

function step() {
	if (keyboard_check_pressed(ord("E"))) {
		var xdist = target.x - x;;
		var ydist = abs(y - target.y);
		with (instance_create_depth(x,y,depth,obj_ink_blob)) {
			var t = 60;
			vsp = (ydist - (1/2)*(grav)*t*t)/t;
			hsp = xdist/t;
			log("%, % (%)", hsp, vsp, t);
		}
	}
}