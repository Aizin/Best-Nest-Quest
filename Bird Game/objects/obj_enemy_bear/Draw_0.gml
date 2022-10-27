/// @desc
draw_set_color(c_lime);
draw_line(x-16, y+24, x-160, y+24);
draw_set_color(c_red);
draw_line(x, y+24, x+160, y+24);

var spr = (alarm[0] != -1) ? damage_sprite[$ sprite_get_name(sprite_index)] : sprite_index;

draw_sprite_ext(spr, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);