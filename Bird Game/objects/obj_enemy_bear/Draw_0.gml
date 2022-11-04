/// @desc

//debug lines
if(debug)
{
	draw_set_color(c_lime);
	draw_line(x-16, y-12, x-160, y-12);
	draw_set_color(c_red);
	draw_line(x, y-12, x+160, y-12);
	draw_set_color(c_orange);
	draw_line(x+16*xdir, y-20, x+50*xdir, y-20)
}
var spr;
//var spr = (alarm[0] != -1) ? damage_sprite[$ sprite_get_name(sprite_index)] : sprite_index;

if(alarm[0] != -1)
{
	spr =  damage_sprite[$ sprite_get_name(sprite_index)];
}

else
{
	switch(state){
	case States.sleeping:
		spr = sprite_index;
		break;
		
	case States.waking:
		spr =  awake_sprite[$ sprite_get_name(sprite_index)];
		break;
		
	case States.rolling:
		spr =  rolling_sprite[$ sprite_get_name(sprite_index)];
		break;
		
	case States.stunned:
		spr =  stunned_sprite[$ sprite_get_name(sprite_index)];
		break;
	
	default:
		spr = sprite_index;
		break;
	
	}
	
}

draw_sprite_ext(spr, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);