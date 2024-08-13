event_inherited();

events.on("collision:check", function() {
	instance_destroy();
	
	var _is_active_sound = GlobalReaderEmitter("sound").request("active", false);
	if (_is_active_sound) {
		audio_play_sound(snd_fragile, 0, false);
	}
})
