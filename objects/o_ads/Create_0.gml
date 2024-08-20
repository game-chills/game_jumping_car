
game_ready_req_id = YaGames_GameReadyOn()

ads_ready_timeout = false;
ads_ready_dead = 2;

ads_minutes = 3;

alarm_set(0, room_speed * 60 * ads_minutes);

GlobalEventEmitter("game").on("dead", function() {
	--ads_ready_dead;
	
	if (ads_ready_dead < 0 && ads_ready_timeout) {
		ads_ready_timeout = false;
		ads_ready_dead = 2;
		alarm_set(0, room_speed * 60 * ads_minutes);
		
		GlobalEventEmitter("ads").emit("show:available");
	}
});

GlobalEventEmitter("ads").on("show", function() {
	if (os_browser == browser_not_a_browser) {
		show_message_async("Реклама");
	} else {
		YaGames_showFullscreenAdv();
	}
});
