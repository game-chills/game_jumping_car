
var _size = get_window_sizes();
var _w = _size.w;
var _h = _size.h;

if (!window_has_focus()) {
	return;	
}
if (_size.w == 0 || _size.h == 0) {
	return;
}

if (_w != current_window_w || _h != current_window_h) {
	current_window_w = _w;
	current_window_h = _h;
	
	GlobalEventEmitter("window").emit("resize", {
		w: _w,
		h: _h,
	});
}
