shader_type canvas_item;
render_mode unshaded;

uniform bool inmune;
uniform float VEL = 5.0;

void fragment(){
	if(inmune){
		COLOR = texture(TEXTURE, UV);
		COLOR += vec4(0.0,0.2,-0.2,0.0)*vec4(float(int(TIME*VEL)%2));
		//COLOR += vec4(0.7,-0.2,-0.2,0.0)*vec4(abs(sin(TIME*VEL)));
	}
	else{
		COLOR = texture(TEXTURE, UV);
	}
}