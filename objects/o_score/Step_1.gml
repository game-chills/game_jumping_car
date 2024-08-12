
var _cam_y = GlobalReaderEmitter("camera").request("y", 0);
var _passed = -_cam_y - camera_track_y_begin
var _passed_score = max(0, floor(_passed / 128));

current_score = _passed_score;
