
if (GlobalReaderEmitter("pause").request("pause", false)) {
	audio_pause_all();
} else {
	audio_resume_all();
}

if (switcher_audio_active) {
	start_play_music();
	start_play_wind();
} else {
	stop_audios();
}
