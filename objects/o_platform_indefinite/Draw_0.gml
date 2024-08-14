
var _xbegin = x;

x += get_time_interval_coef_rotate_cos(1.3, y) * 4;

event_inherited();

draw_set_color(0xfff0ee);
draw_set_alpha(1)

var _shift = 8;
var _offset = -8;

repeat (choose(2, 3, 4)) {
	draw_lightning(
		x - sprite_width / 2 + random_range(-_shift, _shift),
		y + random_range(-_shift, _shift) + _offset,
		x + sprite_width / 2 + random_range(-_shift, _shift),
		y + random_range(-_shift, _shift) + _offset,
		5, 
		15, 
		3, 
		20
	)
}

x = _xbegin;
