#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

vec2 centre = vec2(0.5, 0.355);

vec4 CIAN = vec4(0,0.7,1,1);
vec4 VERMELL = vec4(1,0,0,1);
vec4 GROC = vec4(1,1,0,1);
vec4 BLANC = vec4(1);

void main()
{
    //EXERCICI PEL 10

    vec2 vtexOrig = vtexCoord;
    vtexOrig.y = vtexOrig.y * (3.0/4.0);

    float dRB = length(vec2(vtexOrig.x - 0.35, vtexOrig.y - centre.y));
    float dRV = length(vec2(vtexOrig.x - 0.5, vtexOrig.y - centre.y));

    bool foraRodonaB = bool (step(0.3, dRB));
    bool foraRodonaV = bool (step(0.3, dRV));

    if (!foraRodonaB && foraRodonaV) {
        fragColor = BLANC;
    } else {
        if (vtexOrig.x > (centre.x + 0.0) && vtexOrig.x < (centre.x + 0.25) &&
            vtexOrig.y < (centre.y + 0.125) && vtexOrig.y > (centre.y - 0.125)) {
                fragColor = BLANC;
        } else {
            fragColor = VERMELL;
        }
    }

    //EXERCICI PEL 9

    /*bool foraRodona = bool (step(0.15, d));


    if (!foraRodona) {
        fragColor = BLANC;
    } else {
        if(vtexOrig.x <= centre.x) {
            fragColor = CIAN;
        } else if (vtexOrig.y >= centre.y) {
            fragColor = VERMELL;
        } else if (vtexOrig.y < centre.y) {
            fragColor = GROC;
        }
    }*/
}
