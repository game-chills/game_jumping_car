if (audio_last_play == -1) {
	return;
}

if (!audio_exists(audio_last_play)) {
	return;
}

audio_stop_sound(audio_last_play);
