extern number time;
extern number strength;
extern vec2 resolution;
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec2 pixel_count = max(floor(resolution.xy * vec2((cos(strength) + 1.0) / 2.0)), 1.0);
    vec2 pixel_size = vec2(love_ScreenSize.x, love_ScreenSize.y) / pixel_count;
    vec2 pixel = (pixel_size * floor(vec2(screen_coords.x, screen_coords.y) / pixel_size)) + (pixel_size / 1.0);
    vec2 uv = pixel.xy / vec2(love_ScreenSize.x, love_ScreenSize.y);
    vec4 pixel_color = Texel(texture, uv);
    return pixel_color;
}