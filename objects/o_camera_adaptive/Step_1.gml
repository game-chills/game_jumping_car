
var _size = get_window_sizes();
var _w = _size.w;
var _h = _size.h;

if (_w != current_window_w || _h != current_window_h) {
	current_window_w = _w;
	current_window_h = _h;
	
	GlobalEventEmitter("window").emit("resize", {
		w: _w,
		h: _h,
	});
}
