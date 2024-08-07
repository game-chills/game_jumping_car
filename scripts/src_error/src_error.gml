
function Error(_message) constructor {
	#region __constructor
	{
		self.message = _message;
		self.stack = debug_get_callstack();
	}
	#endregion
	
	function toString() {
		var _message = string(
			"ERROR: {0}\n{1}",
			self.message,
			string_join_ext("\n", self.stack)
		);
		return 	_message;
	}
}
