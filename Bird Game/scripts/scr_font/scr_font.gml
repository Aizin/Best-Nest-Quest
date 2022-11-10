
global.letter_map = {};

global.letter_map[$ "a"] = 0;
global.letter_map[$ "b"] = 1;
global.letter_map[$ "c"] = 2;
global.letter_map[$ "d"] = 3;
global.letter_map[$ "e"] = 4;
global.letter_map[$ "f"] = 5;
global.letter_map[$ "g"] = 6;
global.letter_map[$ "h"] = 7;
global.letter_map[$ "i"] = 8;
global.letter_map[$ "j"] = 9;
global.letter_map[$ "k"] = 10;
global.letter_map[$ "l"] = 11;
global.letter_map[$ "m"] = 12;
global.letter_map[$ "n"] = 13;
global.letter_map[$ "o"] = 14;
global.letter_map[$ "p"] = 15;
global.letter_map[$ "q"] = 16;
global.letter_map[$ "r"] = 17;
global.letter_map[$ "s"] = 18;
global.letter_map[$ "t"] = 19;
global.letter_map[$ "u"] = 20;
global.letter_map[$ "v"] = 21;
global.letter_map[$ "w"] = 22;
global.letter_map[$ "x"] = 23;
global.letter_map[$ "y"] = 24;
global.letter_map[$ "z"] = 25;
global.letter_map[$ "."] = 26;
global.letter_map[$ "?"] = 27;
global.letter_map[$ "!"] = 28;
global.letter_map[$ ","] = 29;
global.letter_map[$ " "] = 30;
global.letter_map[$ ":"] = 31;
global.letter_map[$ "|"] = 32;
global.letter_map[$ "1"] = 33;
global.letter_map[$ "2"] = 34;
global.letter_map[$ "3"] = 35;
global.letter_map[$ "4"] = 36;
global.letter_map[$ "5"] = 37;
global.letter_map[$ "6"] = 38;
global.letter_map[$ "7"] = 39;
global.letter_map[$ "8"] = 40;
global.letter_map[$ "9"] = 41;
global.letter_map[$ "0"] = 42;
global.letter_map[$ ">"] = 43;
global.letter_map[$ "-"] = 44;

function draw_font(x, y, t) {
	t = string_lower(t);
	
	var w = 8 * string_length(t);
	var h = 8;
	
	var halign = draw_get_halign();
	if (halign == fa_center) {
		x -= w/2;
	} else if (halign == fa_right) {
		x -= w;
	}
	
	
	var valign = draw_get_halign();
	if (valign == fa_middle) {
		y -= h/2;
	} else if (valign == fa_bottom) {
		y -= h;
	}
	
	var color = draw_get_color();
	
	for (var i = 0; i < string_length(t); i ++) {
		var c = string_char_at(t, i+1);
		var index = global.letter_map[$ c];
		draw_sprite_ext(spr_font, index, x, y, 1, 1, 0, color, 1);
		x += 8;
	}
	
}