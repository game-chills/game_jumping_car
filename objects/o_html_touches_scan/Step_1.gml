
if (os_browser == browser_not_a_browser) {
	return;
}

var _page_state = e_html_touches_get();
var _page_state_json = json_parse(_page_state)

crect = _page_state_json.crect;
ctouches = _page_state_json.ctouches;