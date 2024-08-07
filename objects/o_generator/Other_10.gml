
#region constants

var _const_center_x = room_width / 2;
var _const_for__o_platform__min_x = sprite_get_width(s_platform) / 2 * 1.4;
var _const_for__o_platform__max_x = room_width - _const_for__o_platform__min_x ;

#endregion

#region methods

function pop_first_block() {
	var _is_first_block = generator_current.is_first_block;
	generator_current.is_first_block = false;
	
	return _is_first_block;
}

function push_block(_x, _y, _object, _metastring=undefined, _height=undefined) {
	var _inst = instance_create_depth(
		_x,
		_y,
		0,
		_object
	);
	
	_inst.provided_metastring = _metastring;
	
	generator_current.last_position_block.x = _x;
	generator_current.last_position_block.y = _y;
	
	if (is_numeric(_height)) {
		generator_current.zona.y.lost -= _height;
	}
	
	return _inst;
}

#endregion

#region GENERATOR_TYPES.LADDER
if (generator_current.type == GENERATOR_TYPES.LADDER) {
	/* input */
	var _metadata = generator_current.metadata;
	var _is_first_block = pop_first_block();
	
	/* constants */
	
	var _const_up_height_min = 250;
	var _const_up_height_max = 360;
	
	/* variables */
	var _desired = (
		generator_current.last_position_block.x > _const_center_x
		? -1
		: 1
	);
	var _random_sign = choose(1, -1, _desired, _desired, -_metadata.previous_sign);
	
	/* */
	_metadata.previous_sign = _random_sign;
	
	/* case: is_first_block */
	if (_is_first_block) {
		var _height = random_range(
			_const_up_height_min,
			_const_up_height_max
		);
		
		var _x = random_range(
			_const_for__o_platform__min_x,
			_const_for__o_platform__max_x
		);
		var _y = generator_current.last_position_block.y - _height
		
		push_block(_x, _y, o_platform, "ladder:is_first_block", _height);
		return;
	}
	
	var _pattern = choose(
		"up", 
		"move", 
		"move", 
		"move",
		"teleport",
		"teleport",
	);
	
	/* case: pattern - up */
	if (_pattern == "up") {
		var _is_need_add_offset = choose(true, true, true, false);
		
		var _height = random_range(
			_const_up_height_min,
			_const_up_height_max
		);
		
		var _pos_x = generator_current.last_position_block.x;
		var _pos_y = generator_current.last_position_block.y - _height;
		
		if (_is_need_add_offset) {
			_pos_x += random_range(30, 200) * _random_sign;
			_pos_x = clamp(
				_pos_x,
				_const_for__o_platform__min_x,
				_const_for__o_platform__max_x
			);
		}
		
		push_block(_pos_x, _pos_y, o_platform, "ladder:up", _height);
		return;
	}
	
	/* case: pattern - move */
	if (_pattern == "move") {
		var _height = random_range(
			_const_up_height_min,
			_const_up_height_max
		);
		
		var _pos_x = generator_current.last_position_block.x;
		var _pos_y = generator_current.last_position_block.y - _height;
		
		_pos_x += random_range(300, 500) * _random_sign;
		_pos_x = clamp(
			_pos_x,
			_const_for__o_platform__min_x * 1.4,
			_const_for__o_platform__max_x
		);
		
		var _move_is_need_shift = (
			_pos_x == _const_for__o_platform__min_x ||
			_pos_x == _const_for__o_platform__max_x ||
			_pos_x == generator_current.last_position_block.x
		);
			
		if (_move_is_need_shift) {
			_pos_x -= random_range(32, 200) * _random_sign
		}
		
		push_block(_pos_x, _pos_y, o_platform, "ladder:move", _height);
		return;
	}
	
	/* case: pattern - teleport */
	if (_pattern == "teleport") {
		var _height = random_range(
			_const_up_height_min,
			_const_up_height_max
		);
		
		var _bound = 
			generator_current.last_position_block.x > _const_center_x
			? { 
				bound: _const_for__o_platform__min_x, 
				bound_end: _const_for__o_platform__max_x,
				bound_sign: 1,
			}
			: { 
				bound: _const_for__o_platform__max_x, 
				bound_end: _const_for__o_platform__min_x,
				bound_sign: -1,
			}
		
		var _pos_x = _bound.bound + random_range(0, 250) * _bound.bound_sign;
		var _pos_y = generator_current.last_position_block.y - _height;
		
		var _first = push_block(_pos_x, _pos_y, o_platform, "ladder:teleport:0", _height);
		
		_height = random_range(
			_const_up_height_min / 3,
			_const_up_height_max
		);
		
		_pos_y -= _height;
		_pos_x = _bound.bound_end - random_range(0, 150) * _bound.bound_sign;
		
		var _second = push_block(_pos_x, _pos_y, o_platform, "ladder:teleport:1", _height);
		
		return;
	}
}
#endregion
