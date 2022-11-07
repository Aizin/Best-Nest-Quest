
function log(str) {
	for (var i = 1; i < argument_count; i ++) {
		var arg = argument[i];
		str = string_replace(str, "%", string(arg));
	}
	show_debug_message(str);
	return str;
}

function stringf(str) {
	for (var i = 1; i < argument_count; i ++) {
		var arg = argument[i];
		str = string_replace(str, "%", string(arg));
	}
	return str;
}

function show_log(str) {
	for (var i = 1; i < argument_count; i ++) {
		var arg = argument[i];
		str = string_replace(str, "%", string(arg));
	}
	show_message(str);
	return str;
}

function modulus(numb, divider) {
	var val = numb % divider;
	if (val < 0) {
		val += divider;
	}
	return val;
}

function wrap_pingpong(v, min, max, spd=1) {
	var a = max - min;
	return 2*a*abs(v/spd - floor(v/spd + 0.5)) - min;
}


function approach(val, goal, step) {
	return val < goal ? min(val+step, goal) : max(val-step, goal);
}

function assert(bool, message) {
	if (!bool) return;
	show_error(message, 1);
}

function string_split(str, flag) {
	var res = [];
	
	var t = "";
	
	for (var i = 0; i < string_length(str); i++) {
		var c = string_char_at(str, i+1);
		
		if (c == flag) {
			array_push(res, t);
			t = "";
		} else {
			t += c;
		}
	}
	
	if (t != "") {
		array_push(res, t);
	}
	
	return res;
}


