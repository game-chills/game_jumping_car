event_inherited();

var _distance = vec2(x, y).distance_to(vec2(move_x, move_y));

var _vector = vec2_line(x, y, move_x, move_y)
	.normalize()
	.multiply(min(move_max_speed, _distance > 0 ? _distance / move_lim_speed : 0));

if (_distance < 8) {
	if (vec2(x, y).distance_to(vec2(move_x1, move_y1)) < 8) {
		move_x = move_x2;
		move_y = move_y2;
	} else {
		move_x = move_x1;
		move_y = move_y1;
	}
	return;
}

var _pos = _vector.pos();

x = x + _pos.x;
y = y + _pos.y;
