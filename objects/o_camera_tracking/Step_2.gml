
if (!active) {
	return
}

var _car = instance_find(o_car, 0);
if (!_car) {
	return;	
}

var _camera_h = GlobalReaderEmitter("camera").request("h");
var _camera_y = GlobalReaderEmitter("camera").request("y");
if (is_undefined(_camera_h) || is_undefined(_camera_y)) {
	return;
}

var _camera_y_move_point = _camera_y + _camera_h * 0.7;
var _camera_y_diff_car = (
	(-_car.y) - (-_camera_y_move_point)
);

if (_camera_y_diff_car > 0) {
	var _new_cam_y = _camera_y - _camera_y_diff_car;
	GlobalEventEmitter("camera").emit("move_up_y", _new_cam_y);
}

