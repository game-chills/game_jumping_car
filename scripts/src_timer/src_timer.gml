
function get_time_interval_coef(_seconds) {
	var _max_time = floor(room_speed * _seconds);
	var _coef = (get_timer() / 10000 % _max_time) / _max_time;
	return _coef;
}

function get_time_interval_coef_rotate_cos(_seconds, _angle_offset=0) {
	var _coef = get_time_interval_coef(_seconds);
	var _coef_rad = _coef * (pi * 2);
	var _coef_cos = cos( degtorad(_angle_offset) + _coef_rad );
	return _coef_cos
}