
if (current_window_w == 0) {
	var _sizes = get_window_sizes();

	current_window_w = _sizes.w;
	current_window_h = _sizes.h;
}

GlobalEventEmitter("window").emit("resize", {
	w: current_window_w,
	h: current_window_h,
})
