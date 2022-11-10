//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float pixelH;
uniform float pixelW;
uniform float timer;

void main()
{
	vec2 offsety = vec2(0., 3.*pixelH*sin(timer + v_vTexcoord.x * 100.));
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord + offsety );
}
