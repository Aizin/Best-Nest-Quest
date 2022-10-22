/// @desc


var spr = (alarm[0] != -1) ? damage_sprite[$ sprite_get_name(sprite_index)] : sprite_index;

draw_sprite_ext(spr, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);