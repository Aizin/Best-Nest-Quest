/// @desc

function Option(name_, press_) constructor {
	name = name_;
	func = press_;
	press = function() {
		if (!is_undefined(func)) {
			func();
		}
		if (focus) {
			parent.focused = true;
			focused = true;
		}
	};
	
	focus = false; // Should focus when selected
	focused = false; // Currently focused
		
	function draw(x, y) {
		draw_font(x, y, name);
	}
	
	function input() {}
	function unfocus() {}
}
function OptionSlider(name_, save_var_, min_, max_, func_=function(){}) : Option(name_) constructor {
	name = name_;
	
	change = func_;
	focus = true;
	
	save_var = save_var_;
	
	val = global.save_data[$ save_var];
	
	min_val = min_;
	max_val = max_;
	step = 0.1;
	
	function input(dir) {
		var v = val;
		
		val = clamp(val + step * dir, min_val, max_val);
		
		if (v != val) {
			global.save_data[$ save_var] = val;
			change(val);
			
			play_sound(snd_menu_change);
		}
	}
	
	function unfocus() {
		save_game();
	}

	function draw(x, y) {
		draw_font(x, y, name);
		
		var sw = 8*string_length(name) + 8;
		
		var w = 64;
		var h = 4;
		var knob_w = 4;
		var knob_h = 8;
		var amount = (val - min_val) / (max_val - min_val);
		
		draw_sprite_stretched(spr_ui_bar, 0, x+sw, y+4-h/2, w+knob_w, h);
		draw_sprite_stretched_ext(spr_ui_bar, 0, x+sw+amount*w, y, knob_w, knob_h, focused ? c_yellow : c_white, 1);
		
	}
}

function Page(name_, page_name) : Option() constructor {
	name = name_;
	press = function() {
		controller.cur_page = self;
	}
	
	
	options = [];
	parent = noone;
	controller = other;
	
	display_text = [];
	
	cursor = 0;
	
	function add_option_button(name, press) {
		var o = new controller.Option(name, press);
		add_option(o);
		
		return o;
	}
	
	function add_option_slider(name, save_var, min_, max_, func) {
		var o = new controller.OptionSlider(name, save_var, min_, max_, func);
		add_option(o);
		
		return o;
	}
	
	function add_option_page(name, page_name=name) {
		var p = new controller.Page(name, page_name);
		add_option(p);
		
		p.page = page_name;
		
		return p;
	}
	
	function set_display_text(t) {
		display_text = string_split(t, "#");
	}
	
	function add_option(o) {
		o.parent = self;
		o.controller = controller;
		
		array_push(options, o);
		
		return o;
	}
	
	
	
	function input(dir) {
		if (focused) {
			options[cursor].input(dir);
		} else {
			var c = cursor;
			cursor = modulus(cursor+dir, array_length(options));
			
			if (c != cursor) {
				play_sound(snd_menu_change);
			}
		}
	}
	
	function select() {
		play_sound(snd_menu_select);
		
		if (focused) {
			focused = false;
			options[cursor].unfocus();
			options[cursor].focused = false;
		} else {
			options[cursor].press();
		}
	}
	
	function draw_options(x, y, w, h) {
		var oy = 0;
		
		if (array_length(display_text) != 0) {
			
			draw_set_halign(fa_center);
			draw_set_color(c_aqua);
			
			for (var i = 0; i < array_length(display_text); i ++) {
				
				draw_font(x + w/2, y+10*i, display_text[i]);
				oy += 10;
			}
			
			draw_set_halign(fa_left);
			draw_set_color(c_white);

		}
		
		for (var i = 0; i < array_length(options); i ++) {
			var xx = x + 16;
			var yy = y + oy + 16*i;
			
			if (cursor == i && !focused) {
				draw_font(x, yy, ">");
			}
			
			options[i].draw(xx, yy, w, h);
		}
	}
	
	function back() {
		if (focused) {
			focused = false;
			options[cursor].unfocus();
			options[cursor].focused = false;
		} else {
			if (parent == noone) {
				controller.back();
			} else {
				controller.cur_page = parent;
			}
		}
	}
}

function back() {}

active = true;

root = new Page("Root");
cur_page = root;


