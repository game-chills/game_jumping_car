
/* state */
current_score = 0;

tracking_car = noone;
tracking_car_start_y = 0;

shift = 0;

/* state flags */
active = false;

/* listeners */ 

GlobalReaderEmitter("score").provider("amount", function() {
	return current_score
});

GlobalEventEmitter("score").on("start", function(_car) {
	active = true;
	current_score = 0;
	 
	tracking_car = _car;
	tracking_car_start_y = _car.y - 250
});

GlobalEventEmitter("game").on("dead", function() {
	active = false;
	
	tracking_car = noone;
});