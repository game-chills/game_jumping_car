event_inherited();

move_x = x;
move_y = y;
move_x1 = x;
move_y1 = y;
move_x2 = x;
move_y2 = y;
move_max_speed = random_range(4, 7)
move_lim_speed = random_range(32, 96)

line_painter = instance_create_depth(
	0, 
	0, 
	depth + 1,
	o_line_painter
);
line_painter.creator = id;

line_painter.image_alpha = 0.8;
line_painter.image_blend = #fffda4;
line_painter.line_dir = -1;