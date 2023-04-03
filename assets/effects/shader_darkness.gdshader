shader_type canvas_item;

// screen
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap_anisotropic;
// wobble
uniform float wobble_speed: hint_range(0, 10) = 1.0;
uniform float wobble_strength: hint_range(0, 100) = 1.0;
uniform float wobble_frequency: hint_range(0, 100) = 1.0;
// blur
uniform float blur : hint_range(0,5) = 0.5;

void fragment() {
	float time_speed = TIME * wobble_speed;
	float wave_count = wobble_frequency * PI;
	float mask = sin(UV.y * PI) * sin(UV.x * PI);
	float displace_x = sin(time_speed + UV.y * wave_count) * mask;
	float displace_y = sin(time_speed + UV.x * wave_count) * mask;
	vec2 offset = vec2(displace_x, displace_y);
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV + (offset  * SCREEN_PIXEL_SIZE * wobble_strength), blur);
	COLOR = color;
}
