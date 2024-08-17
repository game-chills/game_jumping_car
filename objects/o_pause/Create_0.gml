
pause = false;

GlobalReaderEmitter("pause").provider("pause", function() {
	return pause
})

GlobalEventEmitter("pause").on("set", function(_pause) {
	pause = _pause;
});
