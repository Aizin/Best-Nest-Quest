/// @desc

alpha = 0.5;

y = 0;
image_yscale = room_height / sprite_get_height(sprite_index);

sw = sprite_width;
sh = sprite_height;


timer = 0;

surf = -1;

upixel_h = shader_get_uniform(shd_waterfall_distort, "pixelH");
upixel_w = shader_get_uniform(shd_waterfall_distort, "pixelW");
utimer = shader_get_uniform(shd_waterfall_distort, "timer");

