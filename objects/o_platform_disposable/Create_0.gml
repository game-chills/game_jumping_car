event_inherited();

events.on("collision:check", function() {
	alarm_set(0, 1);
})
