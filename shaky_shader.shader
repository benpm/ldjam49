shader_type canvas_item;
uniform float amount;

void fragment() {
    vec2 A = amount * vec2(
        sin(SCREEN_UV.x * 3.0 + UV.x * 7.123) * cos( + TIME * 6.0 + sin(TIME * 20.0) * 3.0 + 77.0),
        cos(SCREEN_UV.y * 3.0 + UV.y * 3.1983) * sin( + TIME * 3.0 + cos(TIME * 17.0) * 7.0 + 33.0));
    vec2 uv = UV + TEXTURE_PIXEL_SIZE * A;

	COLOR = texture(TEXTURE, uv);
}