
car = undefined;

function sync() {
	if (is_undefined(car)) {
		return false;	
	}
	
	y = car.y;
	mask_index = car.mask_index;
	
	if (car.x < 540) {
		x = car.x + 1080;
	} else {
		x = car.x - 1080;
	}
	
	return true;
}

function init() {
	sync();
}
