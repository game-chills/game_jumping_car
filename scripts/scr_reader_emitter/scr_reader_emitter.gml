
function ReaderEmitter() constructor {
	#region __constructor
	{
		self.__events = {};	
	}
	#endregion
	
	function provider(_event_name, _callback) {
		struct_set(self.__events, _event_name, _callback);
		
		return self;
	}
	
	function request(_event_name, _default=undefined) {
		if (!variable_struct_exists(self.__events, _event_name)) {
			return _default;
		}
		
		var _reader = variable_struct_get(self.__events, _event_name);
		return _reader();
	}
}

function __GlobalReaderEmitter() {
	static _gmap = {};
	return _gmap;
}

function GlobalReaderEmitter(_name) {
	static _gmap = __GlobalReaderEmitter();
	
	var _emitter = struct_get(_gmap, _name);
	if (is_struct(_emitter)) {
		return _emitter;
	}
	
	var _emitter = new ReaderEmitter();
	struct_set(_gmap, _name, _emitter);
	
	return _emitter;
}

function GlobalReaderEmitterClear() {
	struct_foreach(__GlobalReaderEmitter(), function(_name) {
		struct_remove(__GlobalReaderEmitter(), _name);
	})
}
