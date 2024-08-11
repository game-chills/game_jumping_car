
move_speed_x = 0;
move_speed_y = 0;

depth = -1;

phantom = instance_create_depth(x, y, -1, o_car_phantom);
phantom.car = self;
phantom.init();

 function check_collision_block(_x, _y, _bbox_bottom) {
	var _list = ds_list_create();
	var _count = instance_place_list(_x, _y, o_platform, _list, false);
	var _inst, i;
	for (i = ds_list_size(_list) - 1; i >= 0; --i) {
		_inst = ds_list_find_value(_list, i);
		
		/* отсев, тех которые слишком высоко */
		var _entry = _bbox_bottom - _inst.bbox_top;
		if (_entry > _inst.sprite_height) {
			ds_list_delete(_list, i);
		}
	}
	
	/* отсев не твёрдых объектов */
	for (i = ds_list_size(_list) - 1; i >= 0; --i) {
		_inst = ds_list_find_value(_list, i);
	
		_inst.events.emit("collision:check");

		if (!instance_exists(_inst)) {
			ds_list_delete(_list, i);
			continue;
		}
		if (!_inst.solid) {
			ds_list_delete(_list, i);
			continue;
		}
	}
	
	_count = ds_list_size(_list);
	if (_count == 0) {
		ds_list_destroy(_list);
		return {
			first: noone,
			has_collision: false
		}
	}
	
	var _first = ds_list_find_value(_list, 0);
	ds_list_destroy(_list);
	
	return {
		first: _first,
		has_collision: true,
	}
}
	
wheel_1_offset_x = 0
wheel_1_offset_y = 0
wheel_2_offset_x = 0
wheel_2_offset_y = 0
wheel_1_sprite = undefined
wheel_2_sprite = undefined
wheel_y_offset = 0;
wheel_y_offset_max = 32;
wheel_1_real_x = 0;
wheel_1_real_y = 0;
wheel_2_real_x = 0;
wheel_2_real_y = 0;

function calculate_wheel_positions() {
	wheel_1_real_x = x + wheel_1_offset_x * image_xscale;
	wheel_1_real_y = y + wheel_1_offset_y + wheel_y_offset;
	wheel_2_real_x = x + wheel_2_offset_x * image_xscale;
	wheel_2_real_y = y + wheel_2_offset_y + wheel_y_offset;
}

function self_draw() {
	draw_self();
	calculate_wheel_positions();

	if (!is_undefined(wheel_1_sprite)) {
		draw_sprite_ext(
			wheel_1_sprite,
			0,
			wheel_1_real_x,
			wheel_1_real_y,
			image_xscale,
			1,
			0,
			image_blend,
			image_alpha,
		);
	}

	if (!is_undefined(wheel_2_sprite)) {
		draw_sprite_ext(
			wheel_2_sprite,
			0,
			wheel_2_real_x,
			wheel_2_real_y,
			image_xscale,
			1,
			0,
			image_blend,
			image_alpha,
		);
	}	
}

flow_x_left = new StateMachineEvflow();
flow_x_right = new StateMachineEvflow();
