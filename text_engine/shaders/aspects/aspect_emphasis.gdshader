shader_type canvas_item;
uniform vert_mask;
uniform h_mask;

void fragment(){
	COLOR=vec4(UV,0,1.0);
}