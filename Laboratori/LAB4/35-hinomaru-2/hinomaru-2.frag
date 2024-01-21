#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

const vec2 centre = vec2(0.5);
uniform bool classic = false;
float PI = 3.1416;
float FI = PI/16;

void main()
{
    vec2 u = vec2(vtexCoord.x-centre.x, vtexCoord.y-centre.y);

    float d = length(u);
    bool blanc = (bool) step(0.2, d);

    if(blanc && !classic) {
        float angle = atan(u.t, u.s);
        if (mod(angle/FI + 0.5, 2) < 1) blanc = false;
    }


    if (blanc) fragColor=vec4(1.0);
    else fragColor=vec4(1.0, 0.0, 0.0, 1.0);
}
