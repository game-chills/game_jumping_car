calculate_wheel_positions();

var _cam_y = GlobalReaderEmitter("camera").request("y");
var _cam_h = GlobalReaderEmitter("camera").request("h");
var _dead_point = _cam_y + _cam_h + 256;

if (y > _dead_point) {
	instance_destroy();
	GlobalEventEmitter("game").emit("dead");
}
