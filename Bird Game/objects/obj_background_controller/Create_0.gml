/// @desc

layers = [];

root_depth = depth;

state = 0;

function register_layer(spr, c_offset, y_lock=true) {
	if (!is_array(spr)) {
		spr = [spr];
	}
	
	var l = layer_create(root_depth + 50 * array_length(layers));
	var bg_l = layer_background_create(l, spr[state]);
	
	layer_background_htiled(bg_l, 1);
	
	if (!y_lock) {
		layer_y(l, room_height - sprite_get_height(spr[state]) - 8);
	}
	
	
	
	array_push(layers,
	{
		id: l,
		bg_id: bg_l,
		offset: c_offset,
		y_lock: y_lock,
		spr: spr,
	});
}

function change_state(s) {
	state = s;
	
	change_layers();
}

function change_layers(s=state) {
	for (var i = 0; i < array_length(layers); i ++) {
		var l = layers[i];
		layer_background_sprite(l.bg_id, l.spr[s]);
	}
}

function set_stage_direction(dir) {
	global.stage_direction = (dir == "horizontal" ? 0 : 1);
}

set_stage_direction("horizontal");