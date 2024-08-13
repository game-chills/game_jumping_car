event_inherited();

events.on("collision:check", function() {
	alarm_set(0, 1);
	
	var _is_active_sound = GlobalReaderEmitter("sound").request("active", false);
	if (_is_active_sound) {
		audio_play_sound(snd_box, 0, false);
	}
})
