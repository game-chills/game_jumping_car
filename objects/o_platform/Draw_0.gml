
draw_self();

if (!keyboard_check(vk_space)) {
	return;	
}

if (is_string(provided_metastring)) {
	draw_set_font(font_debug);
	draw_set_valign(fa_center);
	draw_set_halign(fa_center);
	draw_text(x, y, provided_metastring);	
}
