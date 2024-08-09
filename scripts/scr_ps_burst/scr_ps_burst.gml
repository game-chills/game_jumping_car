
function particle_burst(_ps, _x, _y, _max_time=200) {
	var _psys = part_system_create(_ps);
	part_system_position(_psys, _x, _y);
	
	var _droper = instance_create_depth(
		0, 0, 0, o_ps_droper,
	);
	
	_droper.run({
		ps_id: _psys,
		ps_live_frames: _max_time
	})
}
