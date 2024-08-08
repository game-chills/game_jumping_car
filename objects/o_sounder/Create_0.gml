
sounds = [
	snd_main,
	snd_main_2,
	snd_main_3,
	snd_main_4,
];
sound_current = irandom(array_length(sounds) - 1);

audio_last_play = -1

alarm_set(0, 3);
