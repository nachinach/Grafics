#version 330 core
in vec4 frontColor;
out vec4 fragColor;

uniform sampler2D colorMap;
in vec2 vtexCoord;

vec4 GROC = vec4(0.9,0.9,0.4,1.0);
vec4 BLUE = vec4(0, 0, 1, 1);
vec4 WHITE = vec4(1.0);

void main()
{
    int desiredDigits[6] = int[6](4, 2, 2, 1, 2, 2);
    //vec4 scaledTex = texture(colorMap, vec2(0.1,1) * vtexCoord + vec2(0.1*(1-2),1));
    vec4 auxColor = vec4(0);
    for (int i = 0; i < desiredDigits.length(); i++) {
        if (floor(vtexCoord.x) == i) {
            auxColor += texture(colorMap, vec2(0.1,1) * vtexCoord + vec2(0.1*(desiredDigits[i]-i),1));
        }
    }

    fragColor = mix(GROC, BLUE, auxColor);

    //fragColor = auxColor;
    //fragColor = texture(colorMap, vtexCoord);
}
