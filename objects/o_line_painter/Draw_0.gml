
if (is_undefined(creator)) {
	return
}

draw_set_color(image_blend);
draw_set_alpha(image_alpha);

draw_line_dashed(
	line_x1,
	line_y1,
	line_x2,
	line_y2,
	line_length,
	line_gap,
	get_timer() / 10000 * 0.5 * sign(line_dir),
	line_width
);
