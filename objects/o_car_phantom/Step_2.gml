
var _is_sync = sync();
if (!_is_sync) {
	return;
}

var _is_need_swap = false;

if (car.x < 540) {
	if (x < 1080) {
		var _dis_original = car.x;
		var _dis_phantom = 1080 - x;
		
		_is_need_swap = _dis_phantom > _dis_original;
	}
} else {
	if (car.x > 0) {
		var _dis_original = 1080 - x;
		var _dis_phantom = car.x;
		
		_is_need_swap = _dis_phantom > _dis_original;
	}
}

if (_is_need_swap) {
	car.x = x;
	sync();
}
