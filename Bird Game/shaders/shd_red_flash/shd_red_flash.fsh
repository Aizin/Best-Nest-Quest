//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 col = texture2D( gm_BaseTexture, v_vTexcoord );
	
	if (col.a == 1. && (col.r != 0. || col.g != 0. || col.b != 0.)) {
		col = vec4(1.,0.,0.,1.0);
	}
	
    gl_FragColor = v_vColour * col;
}
