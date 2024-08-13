
if (!active) {
	return;
}
if (!instance_exists(tracking_car)) {
	return;
}

var _car_y = tracking_car.y;
var _passed = tracking_car_start_y - _car_y
var _passed_score = max(0, floor(_passed / 128));

current_score = max(current_score, _passed_score);
