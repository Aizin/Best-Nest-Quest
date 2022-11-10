/// @desc

event_inherited();

width = 200;
height = 150;

function draw() {
	var w = width;
	var h = height;
	draw_sprite_stretched(spr_pause_menu_bg, 0, CX + CW/2 - w/2, CY + CH/2 - h/2, w, h);
	
	cur_page.draw_options(CX + CW/2 - w/2 + 10, CY + CH/2 - h/2 + 10, w, h);

}

function back() {
	obj_pause_controller.toggle_pause();
	active = false;
}

function quit() {
	var t = instance_create_depth(0,0,-999999, obj_transition);
	t.room_to = rm_title;
	t.step_timer_stay = 1;
	t.finish_early = true;
	
	active = false;
	
	if (global.cur_music != -1) {
		music_set_gain(global.cur_music, 0, 500);
	}
	
	if (instance_exists(obj_pause_controller)) {
		with (obj_pause_controller) {
			toggle_pause();
		}
	}
}



root.add_option_button("Back", root.back);
root.set_display_text("-Options-")

root.add_option_slider("Sound", "volume_sound", 0, 1, function(val) {
	audio_group_set_gain(ag_sounds, val/2, 0);
});
root.add_option_slider("Music", "volume_music", 0, 1, function(val) {
	audio_group_set_gain(ag_music, val, 0);
});

root.add_option_button("Fullscreen", toggle_fullscreen)


quit_confirm = root.add_option_page("Quit");

quit_confirm.set_display_text("Are you sure#you want to quit?");
quit_confirm.add_option_button("No", quit_confirm.back);
quit_confirm.add_option_button("Yes", method(self, quit));

cur_page = root;