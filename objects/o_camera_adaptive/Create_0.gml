
/* listeners */

GlobalEventEmitter("window").on("resize", function(_sizes) {
	var _camera = view_camera[0];
	var _w = _sizes.w / _sizes.h * 1920;
	var _h = 1920;
	
	if (_w < 1080) {
		_w = 1080;
		_h = _sizes.h / _sizes.w * 1080;
	}
	
	window_set_size(_sizes.w, _sizes.h);
	show_debug_message("Resize window to {0}x{1}", _sizes.w, _sizes.h);

	GlobalEventEmitter("camera").emit("resize", {
		w: _w,
		h: _h,
	});
})

GlobalEventEmitter("camera").on("resize", function(_props) {
	var _camera = view_camera[0];
	var _w = _props.w;
	var _h = _props.h;
	
	view_wport[_camera] = _w;
	view_hport[_camera] = _h;
	
	var _x = -(_w - 1080) / 2;
	var _y = -(_h - 1920);
	
	current_camera_w = _w;
	current_camera_h = _h;
	
	camera_set_view_size(_camera, _w, _h);
	camera_set_view_pos(_camera, _x, _y);
	
	show_debug_message("Resize camera to {0}x{1}", _w, _h);
	show_debug_message("Repos camera to {0}x{1}", _x, _y);
	
	surface_resize(application_surface, _w, _h);
	
	display_set_gui_size(_w, _h);
});

GlobalReaderEmitter("camera")
	.provider("x", function() {
		var _camera = view_camera[0];
		return camera_get_view_x(_camera);
	})
	.provider("y", function() {
		var _camera = view_camera[0];
		return camera_get_view_y(_camera);
	})
	.provider("w", function() {
		var _camera = view_camera[0];
		return camera_get_view_width(_camera);
	})
	.provider("h", function() {
		var _camera = view_camera[0];
		return camera_get_view_height(_camera);
	})

GlobalEventEmitter("camera").on("move_up_y", function(_camera_up_y) {
	var _camera = view_camera[0];
	var _camera_x = camera_get_view_x(_camera);
	var _camera_y = camera_get_view_y(_camera);
	
	var _cam_max_y = min(_camera_y, _camera_up_y);
	
	camera_set_view_pos(_camera, _camera_x, _cam_max_y);
})

/* methods */

function get_window_sizes() {
	if (os_browser != browser_not_a_browser) {
		var _scroll_size = 0;
		
		return {
			w: browser_width - _scroll_size,
			h: browser_height - _scroll_size,
		}
	}
	
	return {
		w: window_get_width(),
		h: window_get_height(),
	}
}

/* state */

current_window_w = 0
current_window_h = 0
current_camera_w = 0
current_camera_h = 0

/* init */

alarm_set(0, 1);
 