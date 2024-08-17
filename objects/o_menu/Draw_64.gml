
if (ads_mode.active) {
	
	{
		draw_set_alpha(1);
		draw_set_font(font_menu_hint);
		draw_set_valign(fa_center);
		draw_set_halign(fa_middle);
		
		var _cam_w = GlobalReaderEmitter("camera").request("w", 0);
		var _cam_h = GlobalReaderEmitter("camera").request("h", 0);
		var _lost_sec = ceil(ads_mode.time_curr / room_speed);
		
		draw_set_color(c_black);
		draw_text(
			_cam_w / 2 - 4,
			_cam_h / 2 - 4,
			t(language, "ads") + string(_lost_sec),
		);
		
		draw_set_color(c_yellow);
		draw_text(
			_cam_w / 2,
			_cam_h / 2,
			t(language, "ads") + string(_lost_sec),
		);
	}
	
	return;	
} 

if (ui.alpha < 0.01) {
	return;
}

if (ui.menu_type == "main") {
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
	
	return;
} 

if (ui.menu_type == "hint") {
	
	if (!is_undefined(ui.button_hint_okey)) {
		var _button = ui.button_hint_okey;
	
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
		
		draw_set_font(font_menu_hint);
		draw_set_color(c_black);
		
		draw_text(
			ui.button_hint_okey.text_regions.hint_left.x - 4,
			ui.button_hint_okey.text_regions.hint_left.y - 4,
			ui.button_hint_okey.text_regions.hint_left.text,
		);
		draw_text(
			ui.button_hint_okey.text_regions.hint_right.x - 4,
			ui.button_hint_okey.text_regions.hint_right.y - 4,
			ui.button_hint_okey.text_regions.hint_right.text,
		);
		draw_text(
			ui.button_hint_okey.text_regions.hint_teleport.x - 4,
			ui.button_hint_okey.text_regions.hint_teleport.y - 4,
			ui.button_hint_okey.text_regions.hint_teleport.text,
		);
		
		draw_set_color(c_yellow);
		
		draw_text(
			ui.button_hint_okey.text_regions.hint_left.x,
			ui.button_hint_okey.text_regions.hint_left.y,
			ui.button_hint_okey.text_regions.hint_left.text,
		);
		draw_text(
			ui.button_hint_okey.text_regions.hint_right.x,
			ui.button_hint_okey.text_regions.hint_right.y,
			ui.button_hint_okey.text_regions.hint_right.text,
		);
		draw_text(
			ui.button_hint_okey.text_regions.hint_teleport.x,
			ui.button_hint_okey.text_regions.hint_teleport.y,
			ui.button_hint_okey.text_regions.hint_teleport.text,
		);
		
		var _shift = 16;
		var _scale = 1.8;
		
		draw_sprite_ext(
			s_hints,
			is_mobile() ? 2: 0,
			ui.button_hint_okey.text_regions.hint_left.x,
			ui.button_hint_okey.text_regions.hint_left.y + string_height(
				ui.button_hint_okey.text_regions.hint_left.text
			) / 2 + _shift,
			_scale,
			_scale,
			0,
			c_white,
			ui.alpha
		);
		
		draw_sprite_ext(
			s_hints,
			is_mobile() ? 3: 1,
			ui.button_hint_okey.text_regions.hint_right.x,
			ui.button_hint_okey.text_regions.hint_right.y + string_height(
				ui.button_hint_okey.text_regions.hint_right.text
			) / 2 + _shift,
			_scale,
			_scale,
			0,
			c_white,
			ui.alpha
		);
	}
	
	return;
}
