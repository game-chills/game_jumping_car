
if (GlobalReaderEmitter("sound").request("resume", false)) {
	audio_resume_all();	
	
	show_debug_message("sound resume")
} else {
	audio_pause_all();
	
	show_debug_message("sound pause")
}

if (switcher_audio_active) {
	start_play_music();
	start_play_wind();
} else {
	stop_audios();
}
