
var _score = GlobalReaderEmitter("score").request("amount", 0);
var _max_incline = min(1.25, _score / 350 * 1);

var _max_time = floor(room_speed * 20);
var _time_rad = (get_timer() / 10000 % _max_time) / _max_time * (pi * 2);
var _incline = cos(pi + _time_rad) * _max_incline;

camera_set_view_angle(view_camera[0], _incline);

var _camera = view_camera[0];
var _camera_x = camera_get_view_x(_camera);
var _camera_y = camera_get_view_y(_camera);
	
var _camera_y_update = lerp(_camera_y, current_camera_yup, 0.05);
camera_set_view_pos(_camera, _camera_x, _camera_y_update);
