
var _cam_y = GlobalReaderEmitter("camera").request("y");
var _cam_h = GlobalReaderEmitter("camera").request("h");

if (is_undefined(_cam_y) || is_undefined(_cam_h)) {
	return;	
}

var _cam_bottom = _cam_y + _cam_h;
if (bbox_top > _cam_bottom) {
	instance_destroy();
}
