
var _score = GlobalReaderEmitter("score").request("amount", 0);
var _max_incline = min(1.25, _score / 350 * 1);

var _max_time = floor(room_speed * 20);
var _time_rad = (get_timer() / 10000 % _max_time) / _max_time * (pi * 2);
var _incline = cos(pi + _time_rad) * _max_incline;

camera_set_view_angle(view_camera[0], _incline);
