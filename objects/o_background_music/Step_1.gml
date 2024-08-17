
if (GlobalReaderEmitter("sound").provider("resume", false)) {
	audio_resume_all();	
} else {
	audio_pause_all();
}

if (switcher_audio_active) {
	start_play_music();
	start_play_wind();
} else {
	stop_audios();
}
