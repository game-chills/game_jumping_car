
ads_ready_timeout = false;
ads_ready_dead = 2;

ads_minutes = 1.5;

alarm_set(0, room_speed * 60 * ads_minutes);

GlobalEventEmitter("game").on("dead", function() {
	--ads_ready_dead;
	
	if (ads_ready_dead < 0 && ads_ready_timeout) {
		ads_ready_timeout = false;
		alarm_set(0, room_speed * 60 * ads_minutes);
		
		if (os_browser == browser_not_a_browser) {
			show_message("Реклама");
		} else {
			YaGames_showFullscreenAdv();
		}
	}
});