
//if (!GlobalReaderEmitter("sound").request("resume", false)) {
//	return;
//}

var _move_speed_y_limit = 40;
var _move_speed_x_limit = 11;

var _is_pressed_x =
	flow_x_right.is_active() - flow_x_left.is_active();

if (_is_pressed_x != 0) {
	move_speed_x = lerp(move_speed_x, _move_speed_x_limit * _is_pressed_x, 0.3);
} else {
	move_speed_x = lerp(move_speed_x, 0, 0.08);
}

move_speed_y += 0.95;

if (abs(move_speed_x) > _move_speed_x_limit) {
	move_speed_x = _move_speed_x_limit * sign(move_speed_x)
}
if (move_speed_y > _move_speed_y_limit) {
	move_speed_y = _move_speed_y_limit;
}

x += move_speed_x;
y += move_speed_y;

if (move_speed_y > 0) {
	var _has_collision = check_collision_block(x, y, bbox_bottom);
	var _is_active_sound = GlobalReaderEmitter("sound").request("active", false);
	
	if (_has_collision.has_collision) {
		move_speed_y = -28;
		
		if (_has_collision.first.object_index == o_platform_move_chaos) {
			GlobalEventEmitter("ev:move_chaos")
				.emit("collision", {
					selector: _has_collision.first.selector,
					direct_collision_id: _has_collision.first.id
				});
			
			if (_is_active_sound) {
				audio_play_sound(snd_shift, 0, false);
			}
		}
		
		if (_has_collision.first.object_index == o_platform_indefinite) {
			GlobalEventEmitter("ev:indefinite")
				.emit("collision", _has_collision.first.id);
			
			if (_is_active_sound) {
				audio_play_sound(snd_shift, 0, false);
			}	
		}
		
		var _cf = 2;
		var _has_collision_wheel_1 = sprite_check_collision(
			wheel_1_sprite,
			0,
			wheel_1_real_x,
			_has_collision.first.bbox_top,
			_cf,
			_cf,
			_has_collision.first
		);
		var _has_collision_wheel_2 = sprite_check_collision(
			wheel_2_sprite,
			0,
			wheel_2_real_x,
			_has_collision.first.bbox_top,
			_cf,
			_cf,
			_has_collision.first
		);
		
		if (_has_collision_wheel_1) {
			particle_burst(
				ps_wheel_dust,
				wheel_1_real_x,
				_has_collision.first.bbox_top,
				20
			);
		}
		
		if (_has_collision_wheel_2) {
			particle_burst(
				ps_wheel_dust,
				wheel_2_real_x,
				_has_collision.first.bbox_top,
				20
			);
		}
		
		if (_is_active_sound) {
			audio_play_sound(snd_jump, 0, false);
		}
	}
}

if (x != xprevious) {
	image_xscale = sign(x - xprevious);	
}

wheel_y_offset = clamp(yprevious - y, 0, wheel_y_offset_max);
