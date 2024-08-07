
move_speed_x = 0;
move_speed_y = 0;

depth = -1;

phantom = instance_create_depth(x, y, -1, o_car_phantom);
phantom.car = self;
phantom.init();

function check_collision_block(_x, _y, _bbox_bottom) {
	var _list = ds_list_create();
	var _count = instance_place_list(_x, _y, o_platform, _list, false);
	var _inst;
	for (var i = ds_list_size(_list) - 1; i >= 0; --i) {
		_inst = ds_list_find_value(_list, i);
		
		var _entry = _bbox_bottom - _inst.bbox_top;
		if (_entry > _inst.sprite_height) {
			ds_list_delete(_list, i);
			--_count;
		}
	}
	
	if (_count == 0) {
		ds_list_destroy(_list);
		
		return {
			has_collision: false
		}
	}
	
	ds_list_destroy(_list);
	
	return {
		has_collision: true,
	}
}