
function sprite_check_collision(_sprite, _index, _x, _y, _image_xscale, _image_yscale, _object_index) {
	var _instance = instance_find(o_sprite_phantom, 0);
	if (!_instance) {
		_instance = instance_create_depth(0, 0, 0, o_sprite_phantom);
	}
	
	_instance.sprite_index = _sprite;
	_instance.image_index = _index;
	_instance.x = _x;
	_instance.y = _y;
	_instance.image_xscale = _image_xscale;
	_instance.image_yscale = _image_yscale;
	
	var _collision
	with (_instance) {
		_collision = place_meeting(x, y, _object_index);
	}
	
	_collision.sprite_index = noone;
	
	return _collision;
}
