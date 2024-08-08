if (audio_last_play == -1) {
	return;
}

if (!audio_exists(audio_last_play)) {
	audio_last_play = -1;
	
	sound_current = irandom(array_length(sounds) - 1);
	alarm_set(0, room_speed * 2.5);
	return;
}
