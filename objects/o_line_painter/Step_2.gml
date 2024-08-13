
if (is_undefined(creator)) {
	return;	
}

if (instance_exists(creator)) {
	return;
}

image_alpha = lerp(image_alpha, 0, 0.1);

if (image_alpha < math_get_epsilon()) {
	instance_destroy();
}
