
var _move_speed_y_limit = 40;
var _move_speed_x_limit = 11;

var _is_pressed_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));

if (_is_pressed_x != 0) {
	move_speed_x = lerp(move_speed_x, _move_speed_x_limit * _is_pressed_x, 0.3);
} else {
	move_speed_x = lerp(move_speed_x, 0, 0.08);
}

move_speed_y += 0.95;

if (abs(move_speed_x) > _move_speed_x_limit) {
	move_speed_x = _move_speed_x_limit * sign(move_speed_x)
}
if (move_speed_y > _move_speed_y_limit) {
	move_speed_y = _move_speed_y_limit;
}

x += move_speed_x;
y += move_speed_y;

if (move_speed_y > 0) {
	var _has_collision = check_collision_block(x, y, bbox_bottom);
	
	if (_has_collision.has_collision) {
		move_speed_y = -28;	
	}
}

if (x != xprevious) {
	image_xscale = sign(x - xprevious);	
}
