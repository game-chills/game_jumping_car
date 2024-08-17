
if (!sound_ads_active) {
	return;
}
if (sound_ads_active_block) {
	return;	
}

if (os_browser == browser_not_a_browser) {
	if (window_has_focus()) {
		sound_ads_active = false;
	}
} else {
	if (is_mobile()) {
		var _page_state = e_html_touches_get();
		var _page_state_json = json_parse(_page_state)

		var _ctouches = _page_state_json.ctouches;

		if (array_length(_ctouches) > 0) {
			sound_ads_active = false;
		}	
	} else {
		if (mouse_check_button(mb_left) || keyboard_check(vk_anykey)) {
			sound_ads_active = false;
		}
	}
}
