extern number strength;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
	vec2 uv = texture_coords.xy;
	vec2 center = vec2(0.5, 0.5);
	vec2 toCenter = center - uv;
	float dist = length(toCenter);
	float maxDist = length(center);
	float percent = dist / maxDist;
	float newDist = percent * strength;
	vec2 newUV = uv + toCenter * newDist;
	vec4 pixel = Texel(texture, newUV);
	return pixel;
}