shader_type canvas_item;
uniform float dissipate;

void fragment() {
	float range = 1.0;
	vec4 cc = vec4(
		0.80 + sin(UV.x * 22.33 + 8.3980 + TIME * 0.15) * 0.1,
		0.80 + cos((UV.x + UV.y) * 34.23 + 1.9123 + TIME * 0.12) * 0.1,
		0.80 + cos(UV.y * 11.33 + 3.6666 + TIME * 0.17) * 0.1,
		1.0);
	vec4 c;
	for (float x = -range; x <= range; x += 1.0) 
	for (float y = -range; y <= range; y += 1.0) {
		vec2 uv = UV + TEXTURE_PIXEL_SIZE * vec2(x, y);
		c += texture(TEXTURE, uv) / (distance(vec2(x, y), vec2(0, 0)) + 1.0);
	}
	float sl = range * 2.0 + 1.0;
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV) * cc + (c / (sl * sl)) * vec4(
		0.9 + cos(UV.x * 4.33 + 2.3980 + TIME * 0.14) * 0.1,
		0.9 + sin(UV.y * 1.23 + 8.9123 + TIME * 0.11) * 0.1,
		0.9 + cos(UV.x * 3.33 + 6.6666 + TIME * 0.18) * 0.1,
		1.0) * dissipate;
}