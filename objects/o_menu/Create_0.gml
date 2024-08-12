
/* state */

sound_active = false;

language = "en";

ui = {
	open: true,
	alpha: 1,
	button_play: undefined,
	button_sound_off: undefined,
}

/* methods */

function load_params() {
	ini_open("params")
	{
		sound_active = ini_read_real("settings", "sound_active", 1);
	}
	ini_close()
}

function save_params() {
	ini_open("params")
	{
		ini_write_real("settings", "sound_active", sound_active);
	}
	ini_close()
}

function notify_change_params() {
	GlobalEventEmitter("sound").emit("switch:active", sound_active);
}

function get_language() {
	var _available = ["ru", "en", "tr"];
	var _os_language = string_lower(os_get_language());
	
	var _final_language = "en";
	var _final_provider = "default";
	
	if (array_contains(_available, _os_language)) {
		_final_language = _os_language;
		_final_provider = "os";
	}
	
	if (os_browser != browser_not_a_browser) {
		
		/* applied language from browser */
		var _yandex_game_lang = string_copy(string_lower(YaGames_getBrowserLang()), 1, 2);
		if (array_contains(_available, _yandex_game_lang)) {
			_final_language = _yandex_game_lang;
			_final_provider = "browser";
		}
		
		/* applied language from yandex language */
		try {
			var _yandex_params = json_parse(YaGames_getEnvironment());
			var _yandex_language = string_lower(_yandex_params.data.lang);
			if (array_contains(_available, _yandex_language)) {
				_final_language = _yandex_game_lang;
				_final_provider = "yandex";
			}
		} catch (e) {};
	}
	
	return {
		provider: _final_provider,
		language: _final_language,
	}
}

/* listeners */

GlobalEventEmitter("params").on("sound:switch:active", function(_active) {
	sound_active = _active;
	
	notify_change_params();
})

GlobalEventEmitter("language").on("change", function(_language) {
	language = _language;
});

GlobalEventEmitter("menu").on("click", function(_type) {
	audio_play_sound(
		snd_click_button,
		0,
		false
	);
	
	if (_type == "sound_off") {
		sound_active = !sound_active;
		
		save_params();
		
		notify_change_params();
	}
	
	if (_type == "play") {
		ui.open = false;
		GlobalEventEmitter("game").emit("play");
	}
});

GlobalEventEmitter("game").on("dead", function() {
	ui.open = true;
});

/* timeouts */

timer_set_timeout_sync(function() {
	load_params();
	notify_change_params();
	
	var _language = get_language();
	show_debug_message({ language: _language });
	
	GlobalEventEmitter("language").emit("change", _language.language);
});


