/// @desc

for (var i = 0; i < array_length(layers); i ++) {
	var l = layers[i];
	
	layer_x(l.id, CX*l.offset);
	
	if (l.y_lock) {
		layer_y(l.id, CY)
	}
}
