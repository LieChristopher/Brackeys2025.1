shader_type canvas_item;

uniform float width : hint_range(0.0, 30.0, 0.01) = 0.1;
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

// === Pivot Point Scaler ===
uniform float pivot_scaler_x : hint_range(0.0, 1.0) = 0.5;
uniform float pivot_scaler_y : hint_range(0.0, 1.0) = 0.5;
//uniform float pivot_sample_scale : hint_range(0.0, 1.0) = 0.5;

void fragment() {
	vec2 pivot = vec2(pivot_scaler_x, pivot_scaler_y);
	vec2 offset = UV - pivot;
	offset *= (1.0 + width);
	vec2 outline_width = offset / (1.0 + width);
	vec2 scaled_uv = pivot + offset;
	vec2 scaled_uv_outline = pivot + outline_width;

	vec2 limit_uv = clamp(scaled_uv, vec2(0.0), vec2(1.0));
	vec2 limit_uv_outline = clamp(scaled_uv_outline, vec2(0.0), vec2(1.0));
	
	vec4 color = texture(TEXTURE, limit_uv);
	vec4 sampled_outline = texture(TEXTURE, limit_uv_outline);

	vec4 outline = vec4(outline_color.rgb, sampled_outline.a * outline_color.a);

	float outline_alpha_only = max(outline.a - color.a, 0.0);
	vec4 alpha_colored_outline = outline * outline_alpha_only;
	
	COLOR = outline_alpha_only > 0.0 ? outline_color : color;
}