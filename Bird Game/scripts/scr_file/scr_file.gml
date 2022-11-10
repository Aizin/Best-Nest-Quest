
#region Config
function interpret_file(d) {}

global.save_data = {};
#endregion

#region Functions

function create_default_save_file(filename) {
	save_game(filename);
}

function load_game(filename) {
	load_file(filename, interpret_file, create_default_save_file);
}

function load_file(filename, func, err_func=func) {
	// Parse file and get data
	var root_struct = get_file_data(filename);
	
	// File doesn't exist or has no data
	if (is_undefined(root_struct)) {
		
		// Run error function
		err_func(filename);
	} else {
		
		// Run function
		func(root_struct);
	}
}

function save_file(name, struct) {
	
	// Convert to json
	var json = json_stringify(struct);
	
	// Save file
	save_string(json, name);
}



function get_file_data(filename) {
	
	// Make sure file exists in directory
	if (!file_exists(filename)) {
		return undefined;
	}
	
	// Read file
	var json = load_string(filename);
	
	// Parse file
	return json_parse(json);
}

function save_game(filename) {
	save_file(filename, global.save_data);
}


function save_string(str, filename) {
	// Create buffer
	var buffer = buffer_create(string_byte_length(str) + 1, buffer_fixed, 1);
	
	// Write string to buffer
	buffer_write(buffer, buffer_string, str);
	
	// Save buffer to file
	buffer_save(buffer, filename);
	
	// Delete buffer
	buffer_delete(buffer);
}

function load_string(filename) {
	// Load the file into a buffer
	var buffer = buffer_load(filename);
	
	// Read the buffer
	var str = buffer_read(buffer, buffer_string);
	
	// Delete the buffer
	buffer_delete(buffer);
	
	// Return found string
	return str;
}

#endregion
