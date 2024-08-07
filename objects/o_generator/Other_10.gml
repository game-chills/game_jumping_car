
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

function pop_start() {
	var _start = generator_current.is_start;
	generator_current.is_start = false;
	
	return _start;
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

function generate_fragile(_x1, _y1, _x2, _y2, _count, _metastring=undefined) {
	var _tryes = 20;
	
	if (_count <= 0) {
		return;
	}
	
	var _swap;
	if (_x1 > _x2) {
		_swap = _x2;
		_x2 = _x1;
		_x1 = _swap;
	}
	if (_y1 > _y2) {
		_swap = _y2;
		_y2 = _y1;
		_y1 = _swap;
	}
	
	var _inst, _xrand, _yrand;
	var _has_collision;
	while (_tryes-- && _count > 0) {
		_xrand = random_range(_x1, _x2);
		_yrand = random_range(_y1, _y2);
		
		_has_collision = sprite_check_collision(
			s_platform_fragile, 
			0, 
			_xrand, 
			_yrand,
			1.5,
			2,
			o_platform
		);
		if (_has_collision) {
			continue;
		}
		
		--_count;
		
		_inst = instance_create_depth(
			_xrand, 
			_yrand, 
			0, 
			o_platform_fragile
		);
		
		_inst.provided_metastring = _metastring;
	}
}

#endregion

#region GENERATOR_TYPES.LADDER
if (generator_current.type == GENERATOR_TYPES.LADDER) {
	/* input */
	var _metadata = generator_current.metadata;
	var _is_first_block = pop_first_block();
	var _from_y = generator_current.last_position_block.y
	
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
	
	/* mutation */
	_metadata.previous_sign = _random_sign;
	
	/* case: is_first_block */
	if (_is_first_block) {
		var _mstype = "ladder:is_first_block"
		
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
		var _mstype = "ladder:up";
		
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
		
		var _inst = push_block(_pos_x, _pos_y, o_platform, _mstype, _height);
		
		generate_fragile(
			_const_for__o_platform__min_x,
			_from_y - random(30),
			_const_for__o_platform__max_x,
			generator_current.last_position_block.y + random(30),
			irandom(2),
			_mstype
		);
		
		return;
	}
	
	/* case: pattern - move */
	if (_pattern == "move") {
		var _mstype = "ladder:move";
		
		var _height = random_range(
			_const_up_height_min,
			_const_up_height_max
		);
		
		var _pos_x = generator_current.last_position_block.x;
		var _pos_y = generator_current.last_position_block.y - _height;
		
		_pos_x += random_range(300, 500) * _random_sign;
		_pos_x = clamp(
			_pos_x,
			_const_for__o_platform__min_x,
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
		
		var _inst = push_block(_pos_x, _pos_y, o_platform, _mstype, _height);
		
		generate_fragile(
			_const_for__o_platform__min_x,
			_from_y - random(30),
			_const_for__o_platform__max_x,
			generator_current.last_position_block.y + random(30),
			choose(1, irandom(2), irandom(3)),
			_mstype
		);
		
		return;
	}
	
	/* case: pattern - teleport */
	if (_pattern == "teleport") {
		var _mstype = "ladder:teleport";
		
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
		
		var _first = push_block(_pos_x, _pos_y, o_platform, _mstype + "0", _height);
		
		_height = random_range(
			_const_up_height_min / 3,
			_const_up_height_max
		);
		
		_pos_y -= _height;
		_pos_x = _bound.bound_end - random_range(0, 150) * _bound.bound_sign;
		
		var _second = push_block(_pos_x, _pos_y, o_platform, _mstype + "0", _height);
		
		generate_fragile(
			_const_for__o_platform__min_x,
			_from_y - random(30),
			_const_for__o_platform__max_x,
			generator_current.last_position_block.y + random(30),
			choose(0, irandom(3), irandom(5)),
			_mstype
		);
		
		return;
	}

}
#endregion

#region GENERATOR_TYPES.ITERATOR
if (generator_current.type == GENERATOR_TYPES.ITERATOR) {
	/* input */
	var _metadata = generator_current.metadata;
	var _from_x = generator_current.last_position_block.x
	var _from_y = generator_current.last_position_block.y
	
	/* constants */
	
	var _const_up_height_min = 250;
	var _const_up_height_max = 360;
	
	/* variables */
	
	/* mutation */
	
	/* case: stage - disposable */
	if (_metadata.stage.type == "disposable") {
		var _mstype = "iterator:disposable"
		
		var _current_direction =
			_from_x > _const_center_x
			? 1
			: -1
			
				
		var _pos_x = generator_current.last_position_block.x;
		
		var _pos_y;
		var _height;
		
		var _count = min(2, _metadata.stage.length);
		_metadata.stage.length -= _count;
		
		for (var i = 0; i < _count; ++i) {
			if (
				_pos_x == _const_for__o_platform__min_x || 
				_pos_x == _const_for__o_platform__max_x
			) {
				_current_direction *= -1;	
			}
			
			_height = random_range(
				_const_up_height_min,
				_const_up_height_max
			);
			
			_pos_y = generator_current.last_position_block.y - _height;
			_pos_x += random_range(300, 500) * _current_direction;
			_pos_x = clamp(
				_pos_x,
				_const_for__o_platform__min_x,
				_const_for__o_platform__max_x
			);
			
			push_block(_pos_x, _pos_y, o_platform_disposable, _mstype, _height);
		}
		
		if (_metadata.stage.length == 1) {
			var _teleport_pos =
				generator_current.last_position_block.x > _const_center_x
				? {
					from: _const_for__o_platform__min_x,
					to: _const_for__o_platform__max_x,
					direction: 1
				}
				: {
					from: _const_for__o_platform__max_x,
					to: _const_for__o_platform__min_x,
					direction: -1
				}
				
			_height = random_range(
				_const_up_height_min * 1.5,
				_const_up_height_max
			);
			
			_pos_y = generator_current.last_position_block.y - _height;
			_pos_x = _teleport_pos.from + random_range(0, 150) * _teleport_pos.direction;
			
			push_block(_pos_x, _pos_y, o_platform_disposable, _mstype, _height);
		}
		
		_metadata.stage.type = "move_chaos";
		_metadata.stage.p = 0;
		
		return;
	}
	
	/* case: stage - move_chaos */
	if (_metadata.stage.type == "move_chaos") {
		var _mstype = "iterator:move_chaos"
		
		var _height = random_range(
			_const_up_height_min * 0.7,
			_const_up_height_max * 0.7
		);
		
		var _teleport_pos =
			generator_current.last_position_block.x > _const_center_x
			? {
				from: _const_for__o_platform__min_x,
				to: _const_for__o_platform__max_x,
				direction: 1
			}
			: {
				from: _const_for__o_platform__max_x,
				to: _const_for__o_platform__min_x,
				direction: -1
			}
			
		var _is_teleport_mode = choose(false, false, true, true);
		if (_is_teleport_mode) {
			if (_teleport_pos.direction == 1) {
				_teleport_pos = {
					from: _const_for__o_platform__max_x,
					to: _const_for__o_platform__min_x,
					direction: -1
				}
			} else {
				_teleport_pos = {
					from: _const_for__o_platform__min_x,
					to: _const_for__o_platform__max_x,
					direction: 1
				}
			}
		}
		
		var _pos_x = _teleport_pos.from + random_range(0, 150) * _teleport_pos.direction
		var _pos_y = generator_current.last_position_block.y - _height;
		
		var _move_chaos = push_block(
			_pos_x, 
			_pos_y, 
			o_platform_move_chaos,
			_mstype,
			_height
		); 
		
		_move_chaos.selector = _metadata.stage.time
		_move_chaos.move_p = _metadata.stage.p
		
		_metadata.stage.p = _metadata.stage.p == 1 ? 0 : 1
		
		_height = random_range(
			_const_up_height_min * 1.2,
			_const_up_height_max * 1.2
		);
		
		_move_chaos.move_x2 = _teleport_pos.to - random_range(0, 150) * _teleport_pos.direction
		_move_chaos.move_y2 = generator_current.last_position_block.y - _height;
		
		if (_move_chaos.move_p == 1) {
			_move_chaos.move_x = _move_chaos.move_x2
			_move_chaos.move_y = _move_chaos.move_y2
		}
		
		generator_current.last_position_block.x = _move_chaos.move_x2;
		generator_current.last_position_block.y -= _height
		generator_current.zona.y.lost -= _height
		
		var _is_need_change_stage = random(100) < 20;
		
		if (_is_need_change_stage) {
			_metadata.stage.type = "disposable";
			_metadata.stage.length = irandom_range(2, 3);
			_metadata.stage.time = get_timer()
		}
	}
}
#endregion