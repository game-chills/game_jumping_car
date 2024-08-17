
GlobalEventEmitter("start").on("yes", function() {
	
	alarm_set(0, 10);
	
	room_goto_next();
	
});
