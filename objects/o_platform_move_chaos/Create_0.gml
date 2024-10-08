event_inherited();

selector = 0;
move_x = x;
move_y = y;
move_p = 0;
move_x1 = x;
move_y1 = y;
move_x2 = x;
move_y2 = y;
move_sign = 0

GlobalEventEmitter("ev:move_chaos").on("collision", function(_props) {
	var _selector = _props.selector
	var _is_direct_collision = _props.direct_collision_id == id;
	
	if (_selector != selector) {
		return;
	}
	if (move_sign == 0) {
		move_sign = move_p == 1 ? -1 : 1;
	}
	
	move_p += 0.25 * move_sign;
	move_p = clamp(move_p, 0, 1);
	
	if (move_sign == -1 && _is_direct_collision) {
		move_p = 0;
	}
	
	if (move_p == 0 || move_p == 1) {
		move_sign = 0
	}
	
	var _vector = vec2_line(
		move_x1,
		move_y1,
		move_x2,
		move_y2
	).multiply(move_p).pos()
	
	move_x = move_x1 + _vector.x;
	move_y = move_y1 + _vector.y;
})

var _score = GlobalReaderEmitter("score").request("amount");

if (_score > 640) {
	line_painter_active = false;
} else {

	line_painter_active = true;
	line_painter = instance_create_depth(
		0, 
		0, 
		depth + 1,
		o_line_painter
	);
	line_painter.creator = id;

	line_painter.image_alpha = 0.8;
	line_painter.image_blend = #ffa3cd;
	line_painter.line_dir = -1;

}