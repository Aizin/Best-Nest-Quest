/// @desc

event_inherited();

register_layer([spr_bg_sky_clouds_5, spr_bg_sky_clouds_5_night], 1-0.12);
register_layer([spr_bg_sky_clouds_4, spr_bg_sky_clouds_4_night], 1-0.09);
register_layer([spr_bg_sky_clouds_3, spr_bg_sky_clouds_3_night], 1-0.06);
register_layer([spr_bg_sky_clouds_2, spr_bg_sky_clouds_2_night], 1-0.03);
register_layer([spr_bg_sky_clouds_1, spr_bg_sky_clouds_1_night], 1);

play_music(snd_mus_sky);

set_stage_direction("vertical");

image_speed = 0.08;


target_layers = [
	layer_get_id("Player"),
	layer_get_id("Tiles_1"),
	layer_get_id("Enemies"),
]

jellyfish_active = false;

function change_state(s) {
	state = s;
	
	jellyfish_active = true;
	
	change_layers();
	
	if (state == 1) {
		for (var i = 0; i < array_length(target_layers); i ++) {
			var l = target_layers[i]
			
			if (layer_get_name(l) == "Player") {

				layer_script_begin(l, function() {
					if (instance_exists(obj_player) && obj_player.sprite_index == spr_player_glide_spinready && obj_player.image_index < 2) {
						gpu_set_fog(1, c_white, 1, 0);
					} else {
						gpu_set_fog(1, c_black, 1, 0);
					}
				})
			} else {
				layer_script_begin(l, function() {
					gpu_set_fog(1, c_black, 1, 0);
				});
			}
			layer_script_end(l, function() {
				gpu_set_fog(0, c_black, 1, 0);
			});
		}
	} else {
		for (var i = 0; i < array_length(target_layers); i ++) {
			var l = target_layers[i]
			layer_script_begin(l, function() {});
			layer_script_end(l, function() {});
		}
	}
}

transitioning = false;
transition_duration = 60*5;
transition_amp = 60;
jellyfish_progress = 0;

function start_night() {
	transitioning = true;
	alarm_set(0, transition_duration);
}

function deactivate_jellyfish() {
	jellyfish_active = 2;
}

timer = 0;