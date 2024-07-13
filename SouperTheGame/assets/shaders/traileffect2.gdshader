shader_type canvas_item;

uniform float difference_point =1.0;//pixel brightness coefficient
uniform vec4 default_color  : source_color = vec4(1,1,1,1) ; 
uniform vec4 first_color  : source_color = vec4(1,1,1,1) ; 
uniform vec4 second_color  : source_color = vec4(0,0,0,1); 
void fragment() {

    vec4 color = texture(TEXTURE, UV);
    
    if (dot(color, vec4(0.5, 0.5, 0.5, 0)) < difference_point) {
        COLOR = vec4(second_color.rgb,default_color.a*color.a);
    } else {
        COLOR = vec4(first_color.rgb,default_color.a*color.a);
    }
}