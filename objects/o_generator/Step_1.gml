
if (!object_ready) {
	return;
}
if (!active_generator) {
	return;
}

if (generator_current.zona.y.lost < 0) {
	var _is_born = active_generations;
	active_generations = false;
	
	events.emit("generation_ended", _is_born);
	return;
}

if (!active_generations) {
	return;
}

event_user(0);
