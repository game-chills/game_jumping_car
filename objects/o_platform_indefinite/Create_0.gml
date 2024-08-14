event_inherited();

move_x = x;
first_unmove = 2;

incline_time = random_range(0.2, 2);

GlobalEventEmitter("ev:indefinite").on("collision", function(_id) {
	var _is_teleport = choose(true, true, false);
	var _offset = sprite_get_width(sprite_index) / 2 * 1.3;
	var _available_space = room_width - _offset * 2 * 0.5;
	
	if (instance_exists(_id) && _id == id) {
		if (first_unmove > 0) {
			--first_unmove;
			return;
		}
	}
	
	if (_is_teleport) {
		if (x > room_width / 2) {
			move_x = _offset + random(_available_space / 2);
		} else {
			move_x = room_width - _offset - random(_available_space / 2);
		}
	} else {
		if (x > room_width / 2) {
			move_x = room_width - _offset - random(_available_space / 2);
		} else {
			move_x = _offset + random(_available_space / 2);
		}
	}
})
