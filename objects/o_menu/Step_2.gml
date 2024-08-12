
var _cf = 0.4;

if (ui.open) {
	ui.alpha = lerp(ui.alpha, 1, _cf);
} else {
	ui.alpha = lerp(ui.alpha, 0, _cf);
}
