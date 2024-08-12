
function t(_lang, _key) {
	static _translations = {
		ru: {
			play: "Играть",
			sound_off: "Откл. звук"
		},
		en: {
			play: "Play",
			sound_off: "Mute sound"
		},
		tr: {
			play: "Oynamak",
			sound_off: "Kapalı ses",
		},
	};
	
	var _pack = struct_get(_translations, _lang);
	var _word = struct_get(_pack, _key);
	
	return _word;
}
