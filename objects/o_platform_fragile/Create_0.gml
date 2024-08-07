event_inherited();

events.on("collision:check", function() {
	instance_destroy();
})
