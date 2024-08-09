
camera_track_y_begin = 0;

current_score = 0;

GlobalReaderEmitter("score").provider("amount", function() {
	return current_score
});

