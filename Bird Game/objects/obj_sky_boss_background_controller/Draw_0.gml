/// @desc

if (jellyfish_active) {
	var xx = CX + CW/2;
	var yy = CY + CH * 3/2 - jellyfish_progress * CH;
	
	draw_sprite(state == 0 ? spr_jellyfish_boss : spr_jellyfish_boss_night, -1, xx, yy + 2*sin(timer/50));
}



