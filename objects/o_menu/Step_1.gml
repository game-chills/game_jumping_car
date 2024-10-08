
if (!ui.open) {
	return;
}

if (!is_undefined(ui.transition)) {
	ui.active = false;
}

if (ads_mode.active) {
	
	{
		if (--ads_mode.time_curr < 0) {
			ads_mode.available = false;
			ads_mode.active = false;
			
			GlobalEventEmitter("ads").emit("show");
			GlobalEventEmitter("pause").emit("set", true);
			GlobalEventEmitter("menu").emit("click:play");
			
			ui.open = true;
			ui.active = true;
			ui.alpha = 1;
			ui.menu_type = "continue";
		}
	}
	
	return;	
}

var _cam_w = GlobalReaderEmitter("camera").request("w", 0);
var _cam_h = GlobalReaderEmitter("camera").request("h", 0);
var _button_sprite = s_button;
var _button_width = sprite_get_width(_button_sprite);
var _button_height = sprite_get_height(_button_sprite);
var _is_mobile = is_mobile();

if (ui.menu_type == "main") {
	
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

}

if (ui.menu_type == "hint") {
	
	ui.button_hint_okey = {
		x: _cam_w / 2,
		y: _cam_h - 32 - _button_height / 2,
		x1: _cam_w / 2 - _button_width / 2,
		x2: _cam_w / 2 + _button_width / 2,
		y1: _cam_h - 32 - _button_height,
		y2: _cam_h - 32,
		sprite: _button_sprite,
		text: t(language, "okey"),
		type: "hint_okey",
		
		text_regions: {
			hint_left: {
				x: _cam_w / 2,
				y: _cam_h * 0.1,
				text: t(language, _is_mobile ? "hint_left_mobile" : "hint_left_pc"),
			},
			hint_right: {
				x: _cam_w / 2,
				y: _cam_h * 0.4,
				text: t(language, _is_mobile ? "hint_right_mobile" : "hint_right_pc"),
			},
			hint_teleport: {
				x: _cam_w / 2,
				y: _cam_h * 0.7,
				text: t(language, "hint_teleport"),
			},
		}
	}

}

if (ui.menu_type == "continue") {
	
	ui.button_continue = {
		x: _cam_w / 2,
		y: _cam_h / 2,
		x1: _cam_w / 2 - _button_width / 2,
		x2: _cam_w / 2 + _button_width / 2,
		y1: _cam_h / 2 - 32 - _button_height / 2,
		y2: _cam_h / 2 - 32 + _button_height / 2,
		sprite: _button_sprite,
		text: t(language, "cont"),
		type: "continue",
	}

}

if (!ui.active) {
	return;
}

var _buttons = [];

if (ui.menu_type == "main") {
	
	array_push(_buttons,
		ui.button_play,
		ui.button_sound_off,
	);
	
}

if (ui.menu_type == "hint") {
	
	array_push(_buttons,
		ui.button_hint_okey,
	);
	
}

if (ui.menu_type == "continue") {
	
	array_push(_buttons,
		ui.button_continue,
	);
	
}

if (mouse_check_button_pressed(mb_left)) {
	
	var _mouse = e_html_touches_mouse_page_position();
	var _mx = _mouse.x;
	var _my = _mouse.y;
	
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
	