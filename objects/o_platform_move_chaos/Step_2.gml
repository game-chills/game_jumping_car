event_inherited();

var _vector = vec2_line(x, y, move_x, move_y)
	.multiply(0.08)
	.pos()
	
x = x + _vector.x;
y = y + _vector.y;
