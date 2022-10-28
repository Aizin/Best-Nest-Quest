/// @desc

layers = [];

root_depth = depth;

function register_layer(spr, c_offset, y_lock=true) {
	var l = layer_create(root_depth + 50 * array_length(layers));
	var bg_l = layer_background_create(l, spr);
	
	layer_background_htiled(bg_l, 1);
	
	if (!y_lock) {
		layer_y(l, room_height - sprite_get_height(spr) - 8);
	}
	
	array_push(layers,
	{
		id: l,
		offset: c_offset,
		y_lock: y_lock,
	});
}


