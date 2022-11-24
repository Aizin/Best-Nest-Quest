/// @desc

if (collected) return;

collected = true;

timer = 0;

play_sound(snd_checkpoint);

//for (var i = 0; i < array_length(target_layers); i ++) {
//	var l = target_layers[i];
	//layer_script_begin(l, function() {
	//	gpu_set_fog(1, c_white, 1, 0);
	//})
	//layer_script_end(l, function() {
	//	gpu_set_fog(0, c_white, 1, 0);
	//})
//}

if (instance_exists(obj_player)) {
	var p = instance_create_layer(obj_player.x, obj_player.y, obj_player.layer, obj_player_victory, {sprite_index: obj_player.sprite_index})
	p.hsp = obj_player.dir * obj_player.spd/2;
	p.vsp = obj_player.vsp;
	p.dir = obj_player.dir;
	p.xgoal = bbox_left + sprite_width/2;
	
	with (obj_player) {
		instance_destroy();
	}
}