
var _coef = 0.1;
if (active) {
	shift = lerp(shift, 1, _coef);
} else {
	shift = lerp(shift, 0, _coef);
}
