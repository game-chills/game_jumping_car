
draw_set_color(c_black);
draw_set_alpha(0.7)
draw_rectangle(0, 0, 400, 400,false)
draw_set_alpha(1)
draw_set_halign(fa_left)

draw_set_color(c_yellow);
draw_set_font(font_debug)
draw_text(32, 32, current_score);

draw_text(32, 64, string("camera: {0}, {1}", 
	o_camera_adaptive.current_camera_w,
	o_camera_adaptive.current_camera_h
));
draw_text(32, 128, string("window: {0}, {1}", 
	o_camera_adaptive.current_window_w,
	o_camera_adaptive.current_window_h
));
draw_text(32, 190, string("fps: {0}, {1}",fps,fps_real));
draw_text(32, 220, string("browser: {0}, {1}", 
	browser_width,
	browser_height
));
draw_text(32, 250, string("r-window: {0}, {1}", 
	window_get_width(),
	window_get_height()
));

draw_text(32, 280, "version: 0.34");