/// @desc

if (x + sw < CX || x > CX+CW) return;

if (!surface_exists(surf)) {
	surf = surface_create(sw, sh);
}

var texture_id = surface_get_texture(surf);
texel_w = texture_get_texel_width(texture_id);
texel_h = texture_get_texel_height(texture_id);



surface_set_target(surf);
	
	draw_clear_alpha(c_white, 0);
	
	shader_set(shd_waterfall_distort);
		shader_set_uniform_f(upixel_h, texel_h);
		shader_set_uniform_f(upixel_w, texel_w);
		shader_set_uniform_f(utimer, timer/10);
		
		var scale = 3;
		
		var yy = y < CY ? y+CY : 0;
		var top = y > CY ? (y-CY)*scale : 0;
		
		draw_surface_part_ext(application_surface, (x-CX)*scale, top, sw*scale, min(sh, CH)*scale, 0, yy, 1/scale, 1/scale, c_white, 1);
	shader_reset();
surface_reset_target();

draw_sprite_stretched(sprite_index, image_index, x, y, sw, sh);

draw_surface_ext(surf, x, y, 1, 1, 0, c_white, alpha);


