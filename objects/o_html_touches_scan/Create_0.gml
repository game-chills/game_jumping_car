
crect = undefined;
ctouches = [];

if (os_browser == browser_not_a_browser) {
	return;
}

GlobalReaderEmitter("@html:touches").provider("all", function() {
	if (is_undefined(crect)) {
		return undefined;
	}
	
	return {
		rect: crect,
		touches: ctouches,
	}
})