
var _cf = 0.4;

if (!ui.open) {
	ui.alpha = lerp(ui.alpha, 0, _cf);
	return;
}

if (!is_undefined(ui.transition)) {
	var _moment = ui.transition.moment;
	
	if (_moment == "out") {
		ui.alpha = lerp(ui.alpha, 0, _cf);
		
		if (ui.alpha < 0.01) {
			ui.transition.moment = "in";
			ui.menu_type = ui.transition.menu_type;
		}
		return;
	}
	
	if (_moment == "in") {
		ui.alpha = lerp(ui.alpha, 1, _cf);
		
		if (ui.alpha > 0.99) {
			ui.transition = undefined;
			ui.active = true;
		}
		return;
	}
}

if (ui.open) {
	ui.alpha = lerp(ui.alpha, 1, _cf);
	return;
}
