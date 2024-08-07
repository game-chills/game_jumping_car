
if (is_undefined(car)) {
	return;	
}

var _x = car.x;
var _y = car.y;
var _alpha = car.image_alpha;

with (car) {
	x = other.x;
	y = other.y;
	image_alpha *= 0.5;
	
	draw_self();
	
	x = _x;
	y = _y;
	image_alpha = _alpha;
}