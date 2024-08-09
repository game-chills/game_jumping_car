
ps_id = -1;
ps_live_frames = 0;

function run(_props) {
	if (is_struct(_props)) {
		ps_id = _props.ps_id;
		ps_live_frames = _props.ps_live_frames;
	}
	
	if (part_system_exists(ps_id) && ps_live_frames > 0) {
		alarm_set(0, ps_live_frames);
	} else {
		instance_destroy()
	}
}
