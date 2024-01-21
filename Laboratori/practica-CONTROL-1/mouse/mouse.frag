#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

vec2 centre = vec2(0.5);

vec4 BLANC = vec4(1);
vec4 NEGRE = vec4(vec3(0),1.0);
vec4 GRIS = vec4(vec3(0.8),1.0);
vec4 PELL = vec4(1.0,0.8,0.6,1.0);

vec4 auxColor;

uniform int mode = 2;

void main()
{
    float dC = length(vec2(vtexCoord.x - centre.x, vtexCoord.y - centre.y + 0.1));
    float dO1 = length(vec2(vtexCoord.x - 0.2, vtexCoord.y - 0.8));
    float dO2 = length(vec2(vtexCoord.x - 0.8, vtexCoord.y - 0.8));

    bool foraRodona = bool (step(0.35, dC));
    bool foraOrella1 = bool (step(0.20, dO1));
    bool foraOrella2 = bool (step(0.20, dO2));

    if (!foraRodona || !foraOrella1 || !foraOrella2) {
        auxColor = NEGRE;
    } else {
        auxColor = GRIS;
    }

    if(mode >= 1) {

        float dU1 = length(vec2((vtexCoord.x - 0.45)*(1.9), vtexCoord.y - centre.y));
        float dU2 = length(vec2((vtexCoord.x - 0.55)*(1.9), vtexCoord.y - centre.y));
        float dBoca = length(vec2(vtexCoord.x - centre.x, (vtexCoord.y - 0.30)*(2/1)));

        bool foraPellUll1 = bool (step(0.20, dU1));
        bool foraPellUll2 = bool (step(0.20, dU2));
        bool foraBoca = bool (step(0.30, dBoca));

        if (!foraPellUll1 || !foraPellUll2 || !foraBoca) {
            auxColor = PELL;
        }
    }

    if (mode == 2) {
        float dUll1 = length(vec2((vtexCoord.x - 0.455)*(2/1), vtexCoord.y - centre.y));
        float dUll2 = length(vec2((vtexCoord.x - 0.545)*(2/1), vtexCoord.y - centre.y));

        bool foraUll1 = bool (step(0.15, dUll1));
        bool foraUll2 = bool (step(0.15, dUll2));

        if (!foraUll1 || !foraUll2) {
            auxColor = BLANC;
        }

        float dNineta1 = length(vec2((vtexCoord.x - 0.455)*(2/1), vtexCoord.y - centre.y + 0.05));
        float dNineta2 = length(vec2((vtexCoord.x - 0.545)*(2/1), vtexCoord.y - centre.y + 0.05));

        bool foraNineta1 = bool (step(0.07, dNineta1));
        bool foraNineta2 = bool (step(0.07, dNineta2));

        if (!foraNineta1 || !foraNineta2) {
            auxColor = NEGRE;
        }
    }

    fragColor = auxColor;
}
