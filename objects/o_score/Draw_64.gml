
var _gui_width = display_get_gui_width();

var _height = 100;

draw_set_halign(fa_center)
draw_set_valign(fa_center)
draw_set_font(font_score)

draw_set_color(c_black)
draw_set_alpha(0.6)

draw_text(
	_gui_width / 2 - 6,
	shift * _height - _height / 2 - 4,
	current_score,
)

draw_set_color(c_white)
draw_set_alpha(1)
draw_text(
	_gui_width / 2,
	shift * _height - _height / 2,
	current_score,
)
