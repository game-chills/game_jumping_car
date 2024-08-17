
/* state */

sound_active = false;
hint_already_visible = false;

sound_ads_active = false;
sound_ads_active_block = true;

language = "en";

ui = {
	open: true,
	active: false,
	menu_type: "main",
	alpha: 1,
	transition: undefined,
	button_play: undefined,
	button_sound_off: undefined,
	button_hint_okey: undefined,
}

ads_mode = {
	available: false,
	active: false,
	time_max: room_speed * 3,
	time_curr: 0,
}

async_get_language = undefined;

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

function danger_request_get_language(_callback) {
	if (!is_undefined(async_get_language)) {
		return;
	}
	
	var _available = ["ru", "en", "tr"];
	var _os_language = string_lower(os_get_language());
	
	var _final_language = "en";
	var _final_provider = "default";
	
	if (array_contains(_available, _os_language)) {
		_final_language = _os_language;
		_final_provider = "os";
	}
	
	async_get_language = {
		language: _final_language,
		provider: _final_provider,
		callback: _callback,
	}
	
	if (os_browser != browser_not_a_browser) {
		
		/* applied language from browser */
		var _yandex_game_lang = string_copy(string_lower(YaGames_getBrowserLang()), 1, 2);
		if (array_contains(_available, _yandex_game_lang)) {
			_final_language = _yandex_game_lang;
			_final_provider = "browser";
		}
		
		async_get_language = {
			language: _final_language,
			provider: _final_provider,
			callback: _callback,
		}
		
		/* applied language from yandex language */
		var _yandex_request_id = YaGames_getEnvironment();
		async_get_language.req_id = _yandex_request_id;
		
		return;
	}
	
	_callback({
		language: _final_language,
		provider: _final_provider,
	})
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
		
		if (ads_mode.available) {
			ads_mode.active = true;
			ads_mode.time_curr = ads_mode.time_max;
		} else {
			GlobalEventEmitter("menu").emit("click:play");
		}
		
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

GlobalEventEmitter("ads").on("show:available", function() {
	ads_mode.available = true;
});

GlobalEventEmitter("menu").on("click:play", function() {
	ui.open = false;
		
	GlobalEventEmitter("game").emit("play");
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
	return sound_active && !sound_ads_active;
});

GlobalReaderEmitter("sound").provider("resume", function() {
	return sound_ads_active;
});

GlobalEventEmitter("ads").on("show", function() {
	sound_ads_active = true;
	sound_ads_active_block = true;
	
	alarm_set(0, 5);
});

GlobalEventEmitter("start").on("yes", function() {
	ui.active = true;
});

/* timeouts */

timer_set_timeout_async(function() {
	load_params();
	
	notify_change_params();
	
	danger_request_get_language(function(_language) {
		show_debug_message({ language: _language });
		
		GlobalEventEmitter("language").emit("change", _language.language);
		GlobalEventEmitter("start").emit("yes");
	});
	
}, 2000);


