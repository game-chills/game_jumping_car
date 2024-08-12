
if (!ui.open) {
	return;
}

var _cam_w = GlobalReaderEmitter("camera").request("w", 0);
var _cam_h = GlobalReaderEmitter("camera").request("h", 0);
var _button_sprite = s_button;
var _button_width = sprite_get_width(_button_sprite);
var _button_height = sprite_get_height(_button_sprite);

ui.button_play = {
	x: _cam_w / 2,
	y: _cam_h / 2 - _button_height / 2 - 8,
	x1: _cam_w / 2 - _button_width / 2,
	x2: _cam_w / 2 + _button_width / 2,
	y1: _cam_h / 2 - _button_height,
	y2: _cam_h / 2 - 8,
	sprite: _button_sprite,
	text: t(language, "play"),
	type: "play",
}

ui.button_sound_off = {
	x: _cam_w / 2,
	y: _cam_h / 2 + _button_height / 2 + 8,
	x1: _cam_w / 2 - _button_width / 2,
	x2: _cam_w / 2 + _button_width / 2,
	y1: _cam_h / 2 + 8,
	y2: _cam_h / 2 + _button_height,
	sprite: _button_sprite,
	text: t(language, "sound_off"),
	type: "sound_off",
}

if (mouse_check_button_pressed(mb_left)) {
	var _mouse = e_html_touches_mouse_page_position();
	var _mx = _mouse.x;
	var _my = _mouse.y;
	
	var _buttons = [
		ui.button_play,
		ui.button_sound_off,
	];
	var _count = array_length(_buttons)
	
	var _button;
	var _has_collision
	for (var i = 0; i < _count; ++i) {
		_button = _buttons[i];
		_has_collision = point_in_rectangle(
			_mx,
			_my,
			_button.x1,
			_button.y1,
			_button.x2,
			_button.y2,
		);
		
		if (_has_collision) {
			GlobalEventEmitter("menu").emit("click", _button.type);
		}
	}
}
