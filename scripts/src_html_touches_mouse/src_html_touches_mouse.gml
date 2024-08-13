function e_html_touches_mouse_page_position() {
	static _last_position = {
		x: 0,
		y: 0,
		xcf: 0,
		ycf: 0,
		w: browser_width,
		h: browser_height,
	};
	
	if (os_browser == browser_not_a_browser) {
		var _mxc = window_mouse_get_x() / window_get_width();
		var _w = display_get_gui_width();
		var _mx = _mxc * _w;
		
		var _myc = window_mouse_get_y() / window_get_height();
		var _h = display_get_gui_height();
		var _my = _myc * _h;
		
		return {
			x: _mx,
			y: _my,
			xcf: _mxc,
			ycf: _myc,
			w: _w,
			h: _h,
		}
	}
	
	if (is_mobile()) {
		var _page_state = e_html_touches_get();
		var _page_state_json = json_parse(_page_state)

		var _crect = _page_state_json.crect;
		var _ctouches = _page_state_json.ctouches;
		
		var _w = display_get_gui_width()
		var _h = display_get_gui_height()
	
		_last_position.w = _w;
		_last_position.h = _h;
	
		if (array_length(_ctouches) > 0) {
			var _first = _ctouches[0];
			var _t_ex = _first.pageX;
			var _t_ey = _first.pageY;
		
			_last_position.xcf = _t_ex / _crect.width;
			_last_position.ycf = _t_ey / _crect.height;
			
			_last_position.x = _last_position.xcf * _last_position.w;
			_last_position.y = _last_position.ycf * _last_position.h;
		}
	} else {
		var _page_mouse_state = e_html_touches_get_mouse();
		var _page_mouse_state_json = json_parse(_page_mouse_state);
		
		var _mouse = _page_mouse_state_json.mouse;
		
		var _w = display_get_gui_width()
		var _h = display_get_gui_height()
		
		_last_position.w = _w;
		_last_position.h = _h;
		
		_last_position.x = _mouse.xc * _last_position.w;
		_last_position.y = _mouse.yc * _last_position.h;
		_last_position.xcf = _mouse.xc;
		_last_position.ycf = _mouse.yc;
		
	}
	
	return {
		x: _last_position.x,
		y: _last_position.y,
		xcf: _last_position.xcf,
		ycf: _last_position.ycf,
		w: _last_position.w,
		h: _last_position.h,
	}
}
