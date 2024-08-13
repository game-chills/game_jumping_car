
function draw_line_dashed(_x1, _y1, _x2, _y2, _length, _gap, _offset, _width) {
	var _size = _length + _gap;
	var _offset_clamp = ((_offset % _size) + _size) % _size;
	var _distance_full = point_distance(_x1, _y1, _x2, _y2);
	var _direction = point_direction(_x1, _y1, _x2, _y2);
	
	var _s_bx = _x1 + lengthdir_x(_offset_clamp, _direction);
	var _s_by = _y1 + lengthdir_y(_offset_clamp, _direction);
	var _s_x1;
	var _s_y1;
	var _s_x2;
	var _s_y2;
	var _size_lost;
	var _size_last = 0;
	
	if (_offset_clamp > 0) {
		var _offset_size = max(0, _offset_clamp - _gap);
		_s_x1 = _x1
		_s_y1 = _y1
		_s_x2 = _s_x1 + lengthdir_x(_offset_size, _direction);
		_s_y2 = _s_y1 + lengthdir_y(_offset_size, _direction);
		
		draw_line_width(_s_x1, _s_y1, _s_x2, _s_y2, _width);
	}
	
	var _distance_anchor =_offset_clamp;
	while (_distance_anchor < _distance_full) {
		_distance_anchor += _size
		_size_lost = max(0, _distance_anchor - _distance_full);
		_size_last = max(0, _length - _size_lost);
		
		_s_x1 = _s_bx;
		_s_y1 = _s_by;
		_s_x2 = _s_x1 + lengthdir_x(_size_last, _direction);
		_s_y2 = _s_y1 + lengthdir_y(_size_last, _direction);
		_s_bx = _s_x2 + lengthdir_x(_gap, _direction);
		_s_by = _s_y2 + lengthdir_y(_gap, _direction);
		
		draw_line_width(_s_x1, _s_y1, _s_x2, _s_y2, _width);
	}
}
