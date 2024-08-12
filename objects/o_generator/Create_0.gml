
/* emitter */
events = new EventEmitter();

/* const */
GENERATOR_TYPES = {
	LADDER: "LADDER",
	ITERATOR: "ITERATOR",
	ELEVATOR: "ELEVATOR",
}

GENERATOR_METAPROPS = {
	LADDER: {
		zona_range: {
			min: room_height * 0.8,
			max: room_height * 2,
		}
	},
	ITERATOR: {
		zona_range: {
			min: room_height * 1.5,
			max: room_height * 2.5,
		}
	},
	ELEVATOR: {
		zona_range: {
			min: room_height * 1.2,
			max: room_height * 2.2,
		}
	}
}

/* state */
generator_current = {
	type: GENERATOR_TYPES.LADDER,
	is_first_block: true,
	is_start: true,
	metadata: {},
	zona: {
		y: {
			start: 0,
			lost: 0,
		},
	},
	last_position_block: {
		x: 0,
		y: 0,
	},
}

generator_previous = {
	type: GENERATOR_TYPES.LADDER,
}

/* state flags */
object_ready = true;
active_generator = false;
active_generations = false;

/* methods */
function init_generator(_first_block) {
	object_ready = true;
	generator_current.last_position_block.x = _first_block.x;
	generator_current.last_position_block.y = _first_block.y;
}

function push_generator(_type, _is_first_block=false) {
	if (!object_ready) {
		throw new Error("[o_generator] is not ready");
	}
	if (!active_generator) {
		throw new Error("[o_generator] is not active generator");
	}
	
	var _previous = generator_current;
	var _metadata = {};
	
	generator_previous = {
		type: _type,
	}
	
	generator_current = {
		type: _type,
		is_first_block: _is_first_block,
		is_start: true,
		metadata: _metadata,
		zona: {
			y: {
				start: _previous.last_position_block.y,
				lost: 0,
			}
		},
		last_position_block: {
			x: _previous.last_position_block.x,
			y: _previous.last_position_block.y,
		},
	}
	
	active_generations = true;
	
	switch (_type) {
		case GENERATOR_TYPES.LADDER: {
			generator_current.zona.y.lost = irandom_range(
				GENERATOR_METAPROPS.LADDER.zona_range.min,
				GENERATOR_METAPROPS.LADDER.zona_range.max
			);
			_metadata.previous_sign = 1
			return;
		}
		case GENERATOR_TYPES.ITERATOR: {
			generator_current.zona.y.lost = irandom_range(
				GENERATOR_METAPROPS.ITERATOR.zona_range.min,
				GENERATOR_METAPROPS.ITERATOR.zona_range.max
			);
			_metadata.stage = {
				type: "disposable",
				length: irandom_range(2, 3),
				time: get_timer(),
			};
			return;
		}
		case GENERATOR_TYPES.ELEVATOR: {
			generator_current.zona.y.lost = irandom_range(
				GENERATOR_METAPROPS.ELEVATOR.zona_range.min,
				GENERATOR_METAPROPS.ELEVATOR.zona_range.max
			);
			_metadata.previous_sign = 1
			return;
		} 
		
		default: 
			return push_generator(GENERATOR_TYPES.LADDER, _is_first_block);
	}
}

/* subscribers */

events.on("generation_ended", function() {
	var _cam_y = GlobalReaderEmitter("camera").request("y");
	if (is_undefined(_cam_y)) {
		return;	
	}
	
	var _cam_y_limit = _cam_y - room_height * 0.7;
	if (generator_current.last_position_block.y < _cam_y_limit) {
		return
	}
	
	event_user(1);
});

GlobalEventEmitter("game").on("play", function() {
	var _cam_h = GlobalReaderEmitter("camera").request("h");
	var _cam_y = GlobalReaderEmitter("camera").request("y");
	var _start_y = _cam_y - _cam_h * 0.75;
	
	with o_platform {
		if (bbox_bottom + 48 < _cam_y) {
			instance_destroy(id, false);
		}
	}
	with (o_car) {
		instance_destroy();
	}
	
	var _first_block = instance_create_depth(
		room_width / 2,
		_start_y,
		0,
		o_platform_first,
	)
	var _car = instance_create_depth(
		_first_block.x,
		_first_block.y - 256,
		0,
		o_car_spawner,
	)
	
	init_generator(_first_block);
	
	active_generator = true;
	
	push_generator(GENERATOR_TYPES.LADDER, true);
});

GlobalEventEmitter("game").on("dead", function() {
	active_generator = false;	
});
