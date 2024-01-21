#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;
uniform float n = 8;

vec4 GREY = vec4(0.8);
vec4 BLACK = vec4(0,0,0,1);

bool esNegre(float s, float t) {

    int resS = int(mod(s*n, 2));
    int resT = int(mod(t*n, 2));

	if (resS != resT) {
	    return true;
	} else {
	    return false;
    }
}

void main()
{
    if (esNegre(vtexCoord.s, vtexCoord.t)) {
        fragColor = BLACK;
    } else {
        fragColor = GREY;
    }

    //fragColor = frontColor;
}
