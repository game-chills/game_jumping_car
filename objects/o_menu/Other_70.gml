
if (async_load[? "type"] != YaGames_AsyncEvent) {
	return;
}

if (is_struct(async_get_language) && async_load[? "request_id"] == async_get_language.req_id) {
	
	 switch (async_load[? "event"]) {
		
		case YaGames_CallEnvironment:
			{
				var _data = json_parse(async_load[? "data"]);
				var _yandex_language = string_lower(_data.i18n.lang);
				var _available = ["ru", "en", "tr"];
				
				if (array_contains(_available, _yandex_language)) {
					async_get_language.language = _yandex_language;
					async_get_language.provider = "yandex";
				}
				
				var _param = async_get_language;
				async_get_language = undefined;
				
				_param.callback({
					language: _param.language,
					provider: _param.provider,
				})
				
			}
			break;
			
			case YaGames_CallNotInitSDK:
			{
	              show_debug_message({
					type: "async:get_environment",
					cause: "sdk_not_init",
				});
				
				var _param = async_get_language;
				async_get_language = undefined;
			
				_param.callback({
					language: _param.language,
					provider: _param.provider,
				})
			}
	        break;
			
		default: {
			var errCode = async_load[? "code"];
            var errName = async_load[? "name"];
            var errMessage = async_load[? "message"];
			
			show_debug_message({
				type: "async:get_environment",
				event: async_load[? "event"],
				errCode,
				errName,
				errMessage
			});
			
			var _param = async_get_language;
			async_get_language = undefined;
			
			_param.callback({
				language: _param.language,
				provider: _param.provider,
			})
		}
			
	 }
	 
	 return;
	
}
