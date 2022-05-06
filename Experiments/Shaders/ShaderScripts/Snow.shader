shader_type spatial;

uniform sampler2D snow_albedo : hint_albedo;
uniform sampler2D snow_normal;
uniform sampler2D snow_roughness;
uniform sampler2D dirt_albedo : hint_albedo;
uniform sampler2D dirt_normal;
uniform sampler2D dirt_roughness;
uniform sampler2D dynamic_snow_mask;
uniform float snow_uv_scale : hint_range(0.5, 10.0);
uniform float dirt_uv_scale : hint_range(0.5, 10.0);
uniform float snow_height = .5;

void fragment() {
	vec2 uv = UV * snow_uv_scale;
	vec3 snow_a = texture(snow_albedo, uv).rgb;
	vec3 snow_n = texture(snow_normal, uv).rgb;
	float snow_r = texture(snow_roughness, uv).r;
	uv = UV * dirt_uv_scale;
	vec3 dirt_a = texture(dirt_albedo, uv).rgb;
	vec3 dirt_n = texture(dirt_normal, uv).rgb;
	float dirt_r = texture(dirt_roughness, uv).r;
	
	float snow_mask = COLOR.r;
	snow_mask *= texture(dynamic_snow_mask, UV).r;
	
	ALBEDO = mix(dirt_a, snow_a, snow_mask);
	NORMALMAP = mix(dirt_n, snow_n, snow_mask);
	ROUGHNESS = mix(dirt_r, snow_r, snow_mask);
}

void vertex() {
	float snow_mask = COLOR.r;
	snow_mask *= texture(dynamic_snow_mask, UV).r;
	VERTEX.y += snow_mask * snow_height;
}