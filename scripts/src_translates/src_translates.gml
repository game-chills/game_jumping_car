
function t(_lang, _key) {
	static _translations = {
		ru: {
			play: "Играть",
			sound_off: "Откл. звук",
			okey: "Ок",
			hint_left_pc: "Для движения влево\nиспользуй A",
			hint_left_mobile: "Для движения влево \nжми на левую часть экрана",
			hint_right_pc: "Для движения вправо\nиспользуй D",
			hint_right_mobile: "Для движения вправо жми\nна правую часть экрана",
			hint_teleport: "Если машинка\nвыйдет за экран, то\nтелепортируется \nс другой стороны",
			ads: "Реклама через: ",
			cont: "Продолжить",
		},
		en: {
			play: "Play",
			sound_off: "Mute sound",
			okey: "Ok",
			hint_left_pc: "Use A to move left",
			hint_left_mobile: "Tap the left side of\nthe screen to move left",
			hint_right_pc: "Use D to move right",
			hint_right_mobile: "Tap the right side of\nthe screen to move right",
			hint_teleport: "If the car goes off\nthe screen, it will\nteleport to the other side",
			ads: "Advertising via: ",
			cont: "Continue",
		},
		tr: {
			play: "Oynamak",
			sound_off: "Kapalı ses",
			okey: "Tamam",
			hint_left_pc: "Sola gitmek için A\ntuşunu kullan",
			hint_left_mobile: "Sola gitmek için ekranın\nsol tarafına dokunun",
			hint_right_pc: "Sağa gitmek için D\ntuşunu kullan",
			hint_right_mobile: "Sağa gitmek için ekranın\nsağ tarafına dokunun",
			hint_teleport: "Araba ekranın dışına\nçıktığında diğer tarafa\nteleport olur",
			ads: "Şununla reklam ver: ",
			cont: "Devam etmek",
		},
	};
	
	var _pack = struct_get(_translations, _lang);
	var _word = struct_get(_pack, _key);
	
	return _word;
}
