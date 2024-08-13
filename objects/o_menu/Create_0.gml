
/* state */

sound_active = false;
hint_already_visible = false;

language = "en";

ui = {
	open: true,
	active: true,
	menu_type: "main",
	alpha: 1,
	transition: undefined,
	button_play: undefined,
	button_sound_off: undefined,
	button_hint_okey: undefined,
}

/* methods */

function load_params() {
	ini_open("params")
	{
		sound_active = ini_read_real("settings", "sound_active", 1);
		hint_already_visible = ini_read_real("state", "hint_already_visible", 1);
	}
	ini_close()
}

function save_params() {
	ini_open("params")
	{
		ini_write_real("settings", "sound_active", sound_active);
		ini_write_real("state", "hint_already_visible", hint_already_visible);
	}
	ini_close()
}

function notify_change_params() {
	GlobalEventEmitter("sound").emit("switch:active", sound_active);
	GlobalEventEmitter("menu").emit("goto:apply:hint", hint_already_visible);
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
		
		return;
	}
	
	if (_type == "play") {
		ui.open = false;
		
		GlobalEventEmitter("game").emit("play");
		
		return;
	}
	
	if (_type == "hint_okey") {
		
		ui.transition = {
			menu_type: "main",
			moment: "out",
		}
		
		var _disable_first_hint = false;
		if (_disable_first_hint) {
			hint_already_visible = false;
			save_params();
		}
		
		return;
	}
});

GlobalEventEmitter("game").on("dead", function() {
	ui.open = true;
});

GlobalEventEmitter("menu").on("goto:apply:hint", function(_is_need_hint) {
	if (_is_need_hint) {
		ui.menu_type = "hint";
	}
});

GlobalReaderEmitter("sound").provider("active", function() {
	return sound_active
});

/* timeouts */

timer_set_timeout_sync(function() {
	load_params();
	
	notify_change_params();
	
	var _language = get_language();
	show_debug_message({ language: _language });
	
	GlobalEventEmitter("language").emit("change", _language.language);
});


