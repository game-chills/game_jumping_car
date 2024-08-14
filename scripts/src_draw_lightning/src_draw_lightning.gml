/// @param {number} x1  source X
/// @param {number} y1  source Y
/// @param {number} x2  destination X
/// @param {number} y2  destination Y
/// @param {number} xmin  minimum distance step (>0)
/// @param {number} xmax  maximum distance step (>xmin)
/// @param {number} ymin  minimum "side" step (lightning "spread")
/// @param {number} ymax  maximum "side" step (lightning "spread")
/// @returns {int} number of segments drawn.

function draw_lightning(x1, y1, x2, y2, xmin, xmax, ymin, ymax) {
    var _dist = point_distance(x1, y1, x2, y2);
    if (_dist <= 0) return 0;
    
    var _fwd_x = (x2 - x1) / _dist;
    var _fwd_y = (y2 - y1) / _dist;
    var _side_x = -_fwd_y, _side_y = _fwd_x;
    
    var _alpha = draw_get_alpha();
    var _last_x = x1;
    var _last_y = y1;
    var _pos = 0;
    var _drawn = 0;
    repeat (5000) { // line segment limit
        _pos += random_range(xmin, xmax);
        var _next_x, _next_y;
        if (_pos < _dist) {
            var _side_offset = choose(-1, 1) * lerp(ymin, ymax,
                // this instead of just random(1) makes the lightning
                // spread out more close to the middle of it
                random(sin(-pi * _pos / _dist))
            );
            
            _next_x = x1 + _fwd_x * _pos + _side_x * _side_offset;
            _next_y = y1 + _fwd_y * _pos + _side_y * _side_offset;
        } else { // (last point)
            _next_x = x2;
            _next_y = y2;
        }
        
        // you can replace this with custom line drawing - these magic numbers just look alright
        draw_set_alpha(_alpha * 0.3);
        draw_line_width(_last_x, _last_y, _next_x, _next_y, 3.7);
        draw_set_alpha(_alpha * 0.7);
        draw_line_width(_last_x, _last_y, _next_x, _next_y, 1.3);
        
        if (_pos >= _dist) break;
        _last_x = _next_x;
        _last_y = _next_y;
        _drawn += 1;
    }
    draw_set_alpha(_alpha);
    return _drawn;
}
