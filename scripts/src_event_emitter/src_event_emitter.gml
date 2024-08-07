

function EventEmitter() constructor {
	#region __constructor
	{
		self.__events = {};
	}
	#endregion
	
	function on(_event_name, _callback, _callback_id=other) {
		var _event = {
			id: _callback_id ?? _callback,
			callback: _callback,
		};
		
		var _events = struct_get(self.__events, _event_name) ?? [];
		struct_set(self.__events, _event_name, _events);
		
		array_push(_events, _event);
		
		return self;
	}
	
	function off(_event_name_or_callback_id=other, _callback_or_callback_id=other) {
		if (!is_string(_event_name_or_callback_id)) {
			var _keys = struct_get_names(self.__events);
			var _size = array_length(_keys);
			
			var _key;
			for (var i = 0; i < _size; ++i) {
				_key = _keys[i];
				
				self.off(_key, _event_name_or_callback_id);
			}
			
			return self;
		}
		
		var _events = struct_get(self.__events, _event_name_or_callback_id);
		
		if (!is_array(_events)) {
			return self;
		}
		
		if (is_undefined(_callback_or_callback_id)) {
			struct_remove(self.__events, _event_name_or_callback_id);
			return self;
		}
		
		var _event;
		for (var i = array_length(_events) - 1; i >= 0; --i) {
			_event = _events[i];
			
			if (
				_event.id == _callback_or_callback_id ||
				_event.callback == _callback_or_callback_id
			) {
				array_delete(_events, i, 1);
			}
		}
		
		if (array_length(_events) == 0) {
			struct_remove(self.__events, _event_name_or_callback_id);
			return self;
		}
		
		return self;
	}
	
	function emit(_event_name, _value=undefined) {
		var _events = struct_get(self.__events, _event_name);
		
		if (!is_array(_events)) {
			return self;
		}
		
		var _size = array_length(_events);
		var _cloned_events = array_create(_size);
		array_copy(_cloned_events, 0, _events, 0, _size);
		
		var _event;
		for (var i = 0; i < _size; ++i) {
			_event = _cloned_events[i];
			_event.callback(_value, {
				id: _event.id,
				callback: _event.callback,
			});
		}
		
		return self;
	}
}

function __GlobalEventEmitterMap() {
	static _gmap = {};
	return _gmap
}

function GlobalEventEmitter(_name) {
	static _gmap = __GlobalEventEmitterMap()
	
	var _emitter = struct_get(_gmap, _name);
	if (is_struct(_emitter)) {
		return _emitter;
	}
	
	var _emitter = new EventEmitter();
	struct_set(_gmap, _name, _emitter);
	
	return _emitter;
}

function GlobalEventEmitterClear() {
	struct_foreach(__GlobalEventEmitterMap(), function(_name) {
		struct_remove(__GlobalEventEmitterMap(), _name);
	})
}
