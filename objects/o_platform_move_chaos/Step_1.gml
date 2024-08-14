
if (!line_painter_active) {
	return;
}

if (move_y1 > move_y2) {
	line_painter.line_x1 = move_x2;
	line_painter.line_y1 = move_y2;
	line_painter.line_x2 = move_x1;
	line_painter.line_y2 = move_y1;
} else {
	line_painter.line_x1 = move_x1;
	line_painter.line_y1 = move_y1;
	line_painter.line_x2 = move_x2;
	line_painter.line_y2 = move_y2;
}
