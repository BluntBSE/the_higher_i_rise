shader_type canvas_item;

uniform vec4 original_0: source_color;
uniform vec4 original_1: source_color;
uniform vec4 original_2: source_color;
uniform vec4 original_3: source_color;
uniform vec4 original_4: source_color;
uniform vec4 replace_0: source_color;
uniform vec4 replace_1: source_color;
uniform vec4 replace_2: source_color;
uniform vec4 replace_3: source_color;
uniform vec4 replace_4: source_color;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

const float precision = 0.1;


vec4 swap_color(vec4 color){
	vec4 original_colors[5] = vec4[5] (original_0, original_1, original_2, original_3, original_4);
	vec4 replace_colors[5] = vec4[5] (replace_0, replace_1, replace_2, replace_3, replace_4);
	for (int i = 0; i < 5; i ++) {
		if (distance(color, original_colors[i]) <= precision){
			return replace_colors[i];
		}
	}
	return color;
}

void fragment(){
	vec4 orig_color = texture(TEXTURE, UV);
	vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR.rgb = swap_color(screen_color).rgb;
	COLOR.a = orig_color.a;
}