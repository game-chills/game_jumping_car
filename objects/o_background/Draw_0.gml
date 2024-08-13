
#region draw background ground

var _back_sprite = s_background
var _back_sprite_width = sprite_get_width(_back_sprite)
var _back_sprite_height = sprite_get_height(_back_sprite)

var _cam_y = GlobalReaderEmitter("camera").request("y", 0);
var _cam_w = GlobalReaderEmitter("camera").request("w", 0);
var _cam_h = GlobalReaderEmitter("camera").request("h", 0);

var _anchor = 1080
var _wcount 
	= ceil((_cam_w - _anchor) / 2 / _back_sprite_width) + 4
var _hcount
	= ceil(_cam_h / _back_sprite_height)

var lx, rx, yy;
for (var i = 0; i < _wcount; ++i) {
	lx = (-i - 1) * _back_sprite_width;
	rx = _anchor + i * _back_sprite_width;
	
	for (var j = -2; j < _hcount; ++j) {
		yy 
			= (_cam_y + j * _back_sprite_height) 
			+ (abs(_cam_y * 1.1) % _back_sprite_height);
		
		draw_set_color(c_white);
		draw_set_alpha(1);
		draw_sprite(_back_sprite, 0, lx, yy);
		draw_sprite(_back_sprite, 0, rx, yy);
	}
}

#endregion
