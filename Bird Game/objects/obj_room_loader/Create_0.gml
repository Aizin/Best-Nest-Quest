/// @desc

if (!instance_exists(obj_global_controller)) {
	instance_create_depth(0, 0, 0, obj_global_controller);
}

filename = get_open_filename("room file|*.json", "room.json")
//"room.json";

global.collision_map = -1;

function load_room(fn) {
	load_file(fn, function(d) {
		room_width = d.roomSettings.Width;
		room_height = d.roomSettings.Height;
		
		camera_set_view_size(view_camera[0], room_width, room_height);
		
		var layers = d.layers;
		for (var i = 0; i < array_length(layers); i ++) {
			make_layer(layers[i]);
		}
	}, function(fn) {
		show_log("\"%\" file not found", fn);
		save_file(fn, {test: 2});
	});
}

function make_layer(data) {
	var type = data.resourceType;
	
	
	
	var layer_base = layer_create(data.depth, data.name);
	layer_set_visible(layer_base, data.visible);
	
	switch (type) {
		case "GMRInstanceLayer":
			var l = make_instance_layer(data, layer_base);
			break;
		
		case "GMRBackgroundLayer":
			var spr_name = data.spriteId;
			var spr = -1;
			if (!is_ptr(spr_name) && spr_name != "null") {
				spr = asset_get_index(spr_name.name);
			}
			
			var l = layer_background_create(layer_base, spr);
			layer_background_visible(l, data.visible);
			layer_x(l, data.x);
			layer_y(l, data.y);
			layer_background_vtiled(l, data.vtiled);
			layer_background_htiled(l, data.htiled);
			layer_background_blend(l, data.colour);
			layer_background_stretch(l, data.stretch);
			break
		
		case "GMRTileLayer":
			var ts = asset_get_index(data.tilesetId.name);
			var tw = data.tiles.SerialiseWidth;
			var th = data.tiles.SerialiseHeight;
			
			assert(ts==-1, stringf("Tileset [%] not found", data.tilesetId.name))
			
			var map_id = layer_tilemap_create(layer_base, data.x, data.y, ts, tw, th);
			global.collision_map = map_id;
			
			var t_data = data.tiles.TileCompressedData;
			
			var j = 0;
			for (var i = 0; i < array_length(t_data); i ++) {
				var t = t_data[i];
				var xx = j % tw;
				var yy = j div tw;
				
				if (t >= 0) {
					set_tile(map_id, t, xx, yy);
					j ++;
				} else {
					var len = -t;
					
					xx = j % tw;
					yy = j div tw;
					i ++;
					t = t_data[i];
					
					repeat(len+1) {
						set_tile(map_id, t, xx, yy);
						
						xx = j % tw;
						yy = j div tw;
						j ++;
					}
					j --
					
					i ++;
					if (i < array_length(t_data)) {
						t = t_data[i];
						if (t < 0) {
							i --;
						}
					}
				}
			}
			break;
	}
}

function set_tile(map_id, ind, xx, yy) {
	if (ind == 0) return;
	
	var tile = tilemap_get(map_id, xx, yy);
	//var ind = tile_get_index(tile);
	tile = tile_set_index(tile, ind);
	tilemap_set(map_id, tile, xx, yy);
}

function make_instance_layer(data, l) {
	var insts = data.instances;
	
	for (var i = 0; i < array_length(insts); i ++) {
		var inst = insts[i].data;
		make_instance(l, inst);
	}
}

function make_instance(l, i) {
	
	// TODO: Account for persistant objects?
	
	var name = i.objectId.name;
	var xx = i.x;
	var yy = i.y;
	var xscale = i.scaleX;
	var yscale = i.scaleY;
	
	var asset = asset_get_index(name);
	
	assert(asset == -1, stringf("Object [%] not found", name));
	
	with (instance_create_layer(xx, yy, l, asset)) {
		image_xscale = xscale;
		image_yscale = yscale;
	}
}


load_room(filename);

