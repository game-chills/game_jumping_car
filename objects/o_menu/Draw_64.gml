
if (!ui.open) {
	return;
}

if (!is_undefined(ui.button_play)) {
	var _button = ui.button_play;
	
	draw_sprite(
		_button.sprite,
		0,
		_button.x,
		_button.y,
	);
	
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(font_menu);
	draw_set_valign(fa_center);
	draw_set_halign(fa_center);
	
	draw_text(_button.x, _button.y, _button.text);
}

if (!is_undefined(ui.button_sound_off)) {
	var _button = ui.button_sound_off;
	
	draw_sprite(
		_button.sprite,
		0,
		_button.x,
		_button.y,
	);
	
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(font_menu);
	draw_set_valign(fa_center);
	draw_set_halign(fa_center);
	
	draw_text(_button.x, _button.y, _button.text);
}
