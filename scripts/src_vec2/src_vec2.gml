
 function __Vec2(_x, _y) constructor {
	#region __constructor
	{
		self.__x = _x;
		self.__y = _y;
	}
	#endregion
	
	function add(_component) {
		if (typeof(_component) == "number") {
			return new __Vec2(
				self.__x + _component,
				self.__y + _component
			);
		}
		return new __Vec2(
			self.__x + _component.__x,
			self.__y + _component.__y
		);
	}
	
	function subtract(_component) {
	  if (typeof(_component) == "number") {
	    return new __Vec2(
	      self.__x - _component,
	      self.__y - _component
	    );
	  }
	  return new __Vec2(
	    self.__x - _component.__x,
	    self.__y - _component.__y
	  );
	}

	function multiply(_component) {
	  if (typeof(_component) == "number") {
	    return new __Vec2(
	      self.__x * _component,
	      self.__y * _component
	    );
	  }
	  return new __Vec2(
	    self.__x * _component.__x,
	    self.__y * _component.__y
	  );
	}

	function divide(_component) {
	  if (typeof(_component) == "number") {
	    return new __Vec2(
	      self.__x / _component,
	      self.__y / _component
	    );
	  }
	  return new __Vec2(
	    self.__x / _component.__x,
	    self.__y / _component.__y
	  );
	}
	
	function x() {
		return self.__x;
	}
	
	function y() {
		return self.__y;	
	}
	
	function angle() {
		return point_direction(
			0,
			0,
			self.__x,
			self.__y
		)
	}
	
	function length() {
		return point_distance(
			0,
			0,
			self.__x,
			self.__y
		)
	}
	
	function rotate(_angle) {
		return vec2_speed(self.length(), _angle + self.angle());
	}
	
	function distance_to(_vec2) {
		var _from_x;
		var _from_y;
		
		if (typeof(_vec2) == "struct" && instanceof(_vec2) == "__Vec2") {
			_from_x = _vec2.__x;
			_from_y = _vec2.__y;
		} else {
			_from_x = _vec2.x;
			_from_y = _vec2.y;
		}
		
		return point_distance(
			self.__x,
			self.__y,
			_from_x,
			_from_y
		)
	}
	
	function angle_to(_vec2) {
		var _from_x;
		var _from_y;
		
		if (typeof(_vec2) == "struct" && instanceof(_vec2) == "__Vec2") {
			_from_x = _vec2.__x;
			_from_y = _vec2.__y;
		} else {
			_from_x = _vec2.x;
			_from_y = _vec2.y;
		}
		
		return point_direction(
			self.__x,
			self.__y,
			_from_x,
			_from_y
		)
	}
	
	function normalize() {
		var _length = self.length();
		var _eps = math_get_epsilon();
		if (_length > _eps) {
	      return new __Vec2(self.__x / _length, self.__y / _length);
	    } else {
	      return new __Vec2(0, 0);
	    }
	}
	
	function dot(_vec2) {
		var _from_x;
		var _from_y;
		
		if (typeof(_vec2) == "struct" && instanceof(_vec2) == "__Vec2") {
			_from_x = _vec2.__x;
			_from_y = _vec2.__y;
		} else {
			_from_x = _vec2.x;
			_from_y = _vec2.y;
		}
		
		return self.__x * _from_x + self.__y * _from_y;
	}
	
	function toString() {
		return string("Vec2({0}, {1})", self.__x, self.__y)
	}
	
}

function vec2(_x=0, _y=_x) {
	return new __Vec2(_x, _y);
}

function vec2_speed(_dir, _len=1) {
	return new __Vec2(
		lengthdir_x(_len, _dir),
		lengthdir_y(_len, _dir)
	);
}
