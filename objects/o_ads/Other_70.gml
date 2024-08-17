

if ((async_load[? "type"]== YaGames_AsyncEvent) and (async_load[? "request_id"] == game_ready_req_id)) {
	
	switch (async_load[? "event"]) {	
		
		case YaGames_CallGameReady:
		{
			GlobalEventEmitter("ads").emit("show");
		}
		break;
	}
}