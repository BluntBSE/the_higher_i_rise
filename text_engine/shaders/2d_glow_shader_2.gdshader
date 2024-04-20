shader_type canvas_item;


uniform vec4 glow_color: source_color =  vec4(0.2, 0.6, 0.2, 0.7);
uniform float glow_power: hint_range(0.0, 8.0, 0.1) = 2.0;
uniform float glow_shift: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float glow_radius: hint_range(1.0, 10.0, 1.0) = 1.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
vec4 glow = vec4(0.0);
float glow_amp = -cos(TIME*3.0)
;
float count = 0.0;
for (float x = -glow_radius; x <= glow_radius; x+=1.0){
	for (float y = -glow_radius; y<= glow_radius; y+=1.0){
		vec2 offset = vec2(x,y) * glow_shift * SCREEN_PIXEL_SIZE; //SCREEN_PIXEL_SIZE
		glow += texture(TEXTURE, UV + offset) * glow_color; //SCREEN_TEXTURE, SCREEN_UV
		count += 1.0;
	}
}
vec4 pixel = texture(SCREEN_TEXTURE, SCREEN_UV); //When this was screen_texture, but regular UV, was kind of interesting picture-in-picture

glow *= glow_power/count * glow_amp; //count
COLOR = mix(pixel, glow, glow.a);
}