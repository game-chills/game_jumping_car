
function Timer() constructor {
	
	#region __constructor
	{
		self.__timeout_id_counter = 0;
		self.__timeouts_sync = [];
		self.__timeouts_async = [];
	}
	#endregion
	
	function set_timeout_async(_callback, _milliseconds) {
		var _id = self.__timeout_id_counter++;
		var _t_milliseconds;
		var _t_begin = current_time;
		var _t_min = 4;
	
		if (is_numeric(_milliseconds)) {
			if (is_nan(_milliseconds) || is_infinity(_milliseconds)) {
				_t_milliseconds = _t_min;
			} else {
				_t_milliseconds = max(_t_min, _milliseconds);
			}
		} else {
			_t_milliseconds = _t_min;
		}
	
		var _r_id = "timeout:async:" + string(_id);
		var _data = {
			id: _r_id,
			callback: _callback,
			milliseconds: _t_milliseconds,
			time_begin: _t_begin,
		}
	
		array_push(self.__timeouts_async, _data);
		return _r_id
	}
	
	function set_timeout_sync(_callback, _frames) {
		var _id = self.__timeout_id_counter++;
		var _t_frames;
		var _t_min = 1;
	
		if (is_numeric(_frames)) {
			if (is_nan(_frames) || is_infinity(_frames)) {
				_t_frames = _t_min;
			} else {
				_t_frames = max(_t_min, _frames);
			}
		} else {
			_t_frames = _t_min;
		}
	
		var _r_id = "timeout:sync:" + string(_id);
		var _data = {
			id: _r_id,
			callback: _callback,
			frames: _t_frames
		}
	
		array_push(self.__timeouts_sync, _data);
		return _r_id
	}
	
	function clear(_id) {
		var _uri_decompose = string_split(_id, ":");
		var _kind = _uri_decompose[0];
	
		if (_kind == "timeout") {
			var _type = _uri_decompose[1];
			var _array = 
				_kind == "sync" 
				? self.__timeouts_sync
				: self.__timeouts_async;
		
			var _index = array_find_index(_array, function(_data) {
				return _data.id == _id;
			});
		
			if (_index == -1) {
				return;
			}
		
			array_delete(_array, _index, 1);
		}
	}
	
	function update() {
		var _data;
		var i;
	
		/* timeouts sync */
		var _update_timeouts_sync = [];
		var _timeouts_sync_calls = [];
		var _timeouts_sync_count = array_length(self.__timeouts_sync);
	
		for (i = 0; i < _timeouts_sync_count; ++i) {
			_data = self.__timeouts_sync[i];
		
			if (_data.frames <= 0) {
				array_push(_timeouts_sync_calls, _data);
				continue;
			}
		
			--_data.frames;
			array_push(_update_timeouts_sync, _data);
		}
	
		/// TODO: swap
		array_resize(self.__timeouts_sync, 0);
		self.__timeouts_sync = _update_timeouts_sync;
	
		/* timeouts async */
		var _update_timeouts_async = [];
		var _timeouts_async_calls = [];
		var _timeouts_async_count = array_length(self.__timeouts_async);
		var _async_time = current_time;
		var _async_dead_time;
	
		for (i = 0; i < _timeouts_async_count; ++i) {
			_data = self.__timeouts_async[i];
			_async_dead_time = _data.time_begin + _data.milliseconds;
		
			if (_async_dead_time < _async_time) {
				array_push(_timeouts_async_calls, _data);
				continue;
			}
		
			array_push(_update_timeouts_async, _data);
		}
	
		/// TODO: swap
		array_resize(self.__timeouts_async, 0);
		self.__timeouts_async = _update_timeouts_async;
	
		/* calls */
		var _count;
	
		_count = array_length(_timeouts_sync_calls);
		for (i = 0; i < _count; ++i) {
			_data = _timeouts_sync_calls[i];
			_data.callback({
				callback: _data.callback,
			});
		}
		
		_count = array_length(_timeouts_async_calls);
		for (i = 0; i < _count; ++i) {
			_data = _timeouts_async_calls[i];
			_data.callback({
				callback: _data.callback,
			});
		}
	}
	
}

function __timers_memory() {
	
	static _memory = new Timer();
	return _memory;
	
}

function timer_set_timeout_async(_callback, _milliseconds) {
	
	static _memory = __timers_memory();
	return _memory.set_timeout_async(_callback, _milliseconds);
	
}

function timer_set_timeout_sync(_callback, _frames) {
	
	static _memory = __timers_memory();
	return _memory.set_timeout_sync(_callback, _frames);
	
}

function timer_clear(_id) {
	
	static _memory = __timers_memory();
	return _memory.clear(_id);
	
}

function timer_update() {
	
	static _memory = __timers_memory();
	return _memory.update();
	
}
