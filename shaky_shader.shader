shader_type canvas_item;
uniform float amount;

void fragment() {
    vec2 uv = UV + TEXTURE_PIXEL_SIZE * amount * vec2(
        cos(TIME * 6.0 + sin(TIME * 20.0) * 3.0 + 77.0),
        sin(TIME * 3.0 + cos(TIME * 17.0) * 7.0 + 33.0));

	COLOR = texture(TEXTURE, uv) * vec4(0.1, 1.0, 0.0, 1.0);
}