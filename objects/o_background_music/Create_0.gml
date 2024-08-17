
/* io randomize */
randomize();

/* constants */
sounds = [
	snd_main,
	snd_main_2,
	snd_main_3,
	snd_main_4,
];

/* state */
sound_music_current = 0;

audio_id_music = -1;
audio_id_wind = -1;

switcher_audio_active = false;

/* methods */
function start_play_music() {
	if (audio_exists(audio_id_music)) {
		return;
	}
	
	sound_music_current = irandom(array_length(sounds) - 1);
	audio_id_music = audio_play_sound(
		sounds[sound_music_current],
		0,
		false
	);
}

function start_play_wind() {
	if (audio_exists(audio_id_wind)) {
		return;
	}
	
	audio_id_wind = audio_play_sound(
		snd_wind,
		0,
		true
	);
}

function stop_audios() {
	if (audio_exists(audio_id_music)) {
		audio_stop_sound(audio_id_music);
	}
	if (audio_exists(audio_id_wind)) {
		audio_stop_sound(audio_id_wind);
	}
}

/* listeners */

GlobalEventEmitter("sound").on("switch:active", function(_active) {
	switcher_audio_active = bool(_active)
});
