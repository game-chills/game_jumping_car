
if (os_browser == browser_not_a_browser) {
	if (keyboard_check_pressed(ord("R"))) {
	
		GlobalEventEmitterClear();
		GlobalReaderEmitterClear();
	
		audio_stop_all();
		room_restart();
	}
	
	if (!instance_exists(o_car)) {
		return;
	}

	if (mouse_check_button_pressed(mb_right)) {
		o_car.x = mouse_x;
		o_car.y = mouse_y;
		o_car.move_speed_y = 0;
	}
}