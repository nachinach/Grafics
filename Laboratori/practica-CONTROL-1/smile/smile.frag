#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform sampler2D colormap;
in vec2 vtexCoord;
in vec3 N;

void main()
{
    /*

    fragColor = texture(colormap, vtexCoord);

    vec2 C1 = vec2(0.34, 0.65) - 0.1 * N.xy;
    vec2 C2 = vec2(0.66, 0.65) - 0.1 * N.xy;

    //vec2 offSet = - 0.1 * N.xy;

    float distC1 = length(vec2(vtexCoord.x - C1.x, vtexCoord.y - C1.y));
    float distC2 = length(vec2(vtexCoord.x - C2.x, vtexCoord.y - C2.y));

    bool foraC1 = bool(step(0.05, distC1));
    bool foraC2 = bool(step(0.05, distC2));

    if (!foraC1 || !foraC2) {
        fragColor = vec4(vec3(0), 1);
    }

    */

    float radi = 0.05;
	vec2 C1 = vec2(0.34,0.65) - 0.1 * N.xy;
	vec2 C2 = vec2(0.66,0.65) - 0.1 * N.xy;

	if(distance(vtexCoord,C1) < radi || distance(vtexCoord,C2) < radi) {
		fragColor = vec4(vec3(0), 1);
	}
    else fragColor = texture(colormap,vtexCoord);
}
