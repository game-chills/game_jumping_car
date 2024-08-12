
var _score = GlobalReaderEmitter("score").request("amount", 0);
var _max_incline = min(5, _score / 100 * 1);

var _max_time = floor(room_speed * incline_time);
var _time_rad = (get_timer() / 10000 % _max_time) / _max_time * (pi * 2);
var _incline = cos(incline_offset + _time_rad) * _max_incline;

image_angle = _incline;

draw_self();

image_angle = 0;

if (os_browser == browser_not_a_browser) {
	if (!keyboard_check(vk_space)) {
		return;	
	}
	
	if (is_string(provided_metastring)) {
		draw_set_font(font_debug);
		draw_set_valign(fa_center);
		draw_set_halign(fa_center);
		draw_text(x, y, provided_metastring);	
	}
}
