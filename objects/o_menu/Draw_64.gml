
if (ui.alpha < 0.01) {
	return;
}

if (!is_undefined(ui.button_play)) {
	var _button = ui.button_play;
	
	var _cos = get_time_interval_coef_rotate_cos(
		16,
		20,
	);
	var _angle = _cos * 3;
	
	draw_sprite_ext(
		_button.sprite,
		0,
		_button.x,
		_button.y,
		1,
		1,
		_angle,
		c_white,
		ui.alpha,
	);
	
	draw_set_alpha(ui.alpha);
	draw_set_color(c_white);
	draw_set_font(font_menu);
	draw_set_valign(fa_center);
	draw_set_halign(fa_middle);
	
	draw_text_transformed(
		_button.x, 
		_button.y, 
		_button.text,
		1,
		1,
		_angle
	);
}

if (!is_undefined(ui.button_sound_off)) {
	var _button = ui.button_sound_off;
	
	var _cos = get_time_interval_coef_rotate_cos(
		19,
		90,
	);
	var _angle = _cos * 3;
	
	draw_sprite_ext(
		_button.sprite,
		0,
		_button.x,
		_button.y,
		1,
		1,
		_angle,
		c_white,
		ui.alpha,
	);
	
	draw_set_alpha(ui.alpha);
	draw_set_color(c_white);
	draw_set_font(font_menu);
	draw_set_valign(fa_center);
	draw_set_halign(fa_middle);
	
	draw_text_transformed(
		_button.x, 
		_button.y, 
		_button.text,
		1,
		1,
		_angle
	);
}
