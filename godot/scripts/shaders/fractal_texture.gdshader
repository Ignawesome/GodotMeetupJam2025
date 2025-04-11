shader_type spatial;

uniform float uv_scale = 10.0;
uniform sampler2D ground_texture;
uniform sampler2D normal_texture;
uniform float albedo_intensity = 1.0;

vec4 fractal_texture(sampler2D tex, vec2 uv, float depth) {
	// Find the pixel level of detail
	float lod = log(depth);

	// Round LOD down
	float lod_floor = floor(lod);

	// Compute the fract part for interpolating
	float lod_fract = lod - lod_floor;

	// Compute scaled uvs
	vec2 uv1 =  uv / exp(lod_floor - 1.0);
	vec2 uv2 =  uv / exp(lod_floor + 0.0);
	vec2 uv3 =  uv / exp(lod_floor + 1.0);

	// Sample at 3 scales
	vec4 tex0 = texture(tex, uv1);
	vec4 tex1 = texture(tex, uv2);
	vec4 tex2 = texture(tex, uv3);

	// Blend samples together
	return (tex1 + mix(tex0, tex2, lod_fract)) * 0.5;
}

void fragment() {
	float depth = (1.0 - FRAGCOORD.z) / FRAGCOORD.w;
	vec2 scaled_uv = UV * uv_scale;

	ALBEDO = fractal_texture(ground_texture, scaled_uv, depth).xyz * albedo_intensity;
	NORMAL_MAP = fractal_texture(normal_texture, scaled_uv, depth).xyz;
}