
calculate_wheel_positions();

var _touch_left = false;
var _touch_right = false;

var _html_touches = GlobalReaderEmitter("@html:touches").request("all");
if (!is_undefined(_html_touches)) {
	var _rect = _html_touches.rect;
	var _touches = _html_touches.touches;
	var _max_handlers = min(2, array_length(_touches));
	
	if (_max_handlers > 0) {
		var _e_width = _rect.width;
		var _e_height = _rect.height;
	
		var _touch;
		var _t_ex;
		var _t_ey;
	
		for (var i = 0; i < _max_handlers; ++i) {
			_touch = _touches[i];
			_t_ex = _touch.pageX;
			_t_ey = _touch.pageY;
		
			if (_t_ex > _e_width / 2) {
				_touch_right = true;
			} else {
				_touch_left = true;
			}
		}
	} else if (mouse_check_button(mb_left)) {
		if (mouse_x > room_width / 2) {
			_touch_right = true;
		} else {
			_touch_left = true;
		}
	}
} 

var _is_press_x_left =
	keyboard_check(ord("A")) ||
	_touch_left

var _is_press_x_right =
	keyboard_check(ord("D")) ||
	_touch_right
	
flow_x_left.input(_is_press_x_left)
flow_x_right.input(_is_press_x_right)
