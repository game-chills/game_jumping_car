
var _random_car = choose(
	o_car_4,
)

var _car = instance_create_depth(x, y, 0, _random_car);

GlobalEventEmitter("score").emit("start", _car);

instance_destroy();
