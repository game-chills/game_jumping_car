
draw_clear_ext(#86defc, 1);

#region clouds
draw_clouds_to_surface();

var _surface = get_surface_for_clouds();
var _cam_y = GlobalReaderEmitter("camera").request("y", 0);
var _alpha = 0.6;

draw_surface_ext(
	_surface,
	surface_get_height(_surface),
	_cam_y,
	1,
	1,
	-90,
	c_white,
	_alpha
);

draw_surface_ext(
	_surface,
	room_width - surface_get_height(_surface),
	_cam_y - 350,
	1,
	-1,
	-90,
	c_white,
	_alpha
);

#endregion
