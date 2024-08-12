depth = -10000;

surface_clouds = undefined;

/* methods */

function get_surface_for_clouds() {
	var _cam_h = GlobalReaderEmitter("camera").request("h", room_height);
	
	var _w = _cam_h + 400;
	var _h = room_width / 2;
	
	var _surface_is_exists =
		!is_undefined(surface_clouds) &&
		surface_exists(surface_clouds);
	
	if (!_surface_is_exists) {
		surface_clouds = surface_create(_w, _h);
	}
	
	var _is_surface_valid_size =
		surface_get_width(surface_clouds) == _w &&
		surface_get_height(surface_clouds) == _h
		
	if (!_is_surface_valid_size) {
		surface_resize(surface_clouds, _w, _h)	
	}
	
	return surface_clouds;
}

function draw_clouds_to_surface() {
	var _surface = get_surface_for_clouds();
	var _width = surface_get_width(_surface);
	var _height = surface_get_height(_surface)
	
	var _time = get_timer() / 10000;
	var _cam_y = GlobalReaderEmitter("camera").request("y", 0);
	
	surface_set_target(_surface);
	{
		draw_clear_alpha(c_white, 0);
		
		/* dark clound */
		{
			var _base_texture = x_PixelSky_layer02
			var _base_width = sprite_get_width(_base_texture)
			var _base_height = sprite_get_height(_base_texture)
			var _scale = 5;
			
			var _shift_cam_y_cf = 10;
		
			var _calc_width = _base_width * _scale;
			var _calc_height = _base_height * _scale;
			
			var _start_x = 0;
			var _start_y = _height;
			
			_start_x += _cam_y == 0 ? 0 : (_cam_y / _shift_cam_y_cf);
			_start_x += _time * 0.05;
			
			_start_x = (((_start_x % _calc_width) + _calc_width) % _calc_width) * -1;
			
			for (; _start_x < _width; _start_x += _calc_width) {
				draw_sprite_ext(
					_base_texture,
					0,
					_start_x,
					_start_y,
					_scale,
					_scale,
					0,
					c_white,
					1,
				);
			}
		}
		
		/* white clound */
		{
			var _base_texture = s_PixelSky_layer02
			var _base_width = sprite_get_width(_base_texture)
			var _base_height = sprite_get_height(_base_texture)
			var _scale = 4;
			
			var _shift_cam_y_cf = 5;
		
			var _calc_width = _base_width * _scale;
			var _calc_height = _base_height * _scale;
			
			var _start_x = 0;
			var _start_y = _height;
			
			_start_x += _cam_y == 0 ? 0 : (_cam_y / _shift_cam_y_cf);
			_start_x += _time * 0.1;
			
			_start_x = (((_start_x % _calc_width) + _calc_width) % _calc_width) * -1;
			
			for (; _start_x < _width; _start_x += _calc_width) {
				draw_sprite_ext(
					_base_texture,
					0,
					_start_x,
					_start_y,
					_scale,
					_scale,
					0,
					c_white,
					1,
				);
			}
		}
		
	}
	surface_reset_target();
}
