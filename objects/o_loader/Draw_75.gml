
draw_clear(c_black);

draw_set_color(c_white);
draw_set_alpha(1);
draw_set_font(font_menu_hint);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
 
var _perm = get_timer() / 100000;
var _per = min(80, ((_perm * 2.5) div 5) * 5);

var _xcenter = display_get_gui_width() / 2;
var _ycenter = display_get_gui_height() / 2;

draw_text(
	_xcenter,
	_ycenter,
	string("{0}%", floor(_per))
);
