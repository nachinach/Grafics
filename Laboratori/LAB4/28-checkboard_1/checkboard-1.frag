#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;
int x = 8;
int y = 8;

bool esNegre(float s, float t) {
    float cuadricula = x/y;

    int resS = int(mod(s*8, 2));
    int resT = int(mod(t*8, 2));

	if (resS != resT) {
	    return true;
	} else {
	    return false;
    }
}

void main()
{
    if (esNegre(vtexCoord.s, vtexCoord.t)) {
        fragColor = vec4(0,0,0,1);
    } else {
        fragColor = vec4(0.8);
    }

    //fragColor = frontColor;
}
