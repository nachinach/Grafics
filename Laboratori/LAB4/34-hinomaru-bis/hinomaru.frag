#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;
const vec2 centre = vec2(0.5);
const float radi = 0.2;

void main()
{
    float d = length(vec2(vtexCoord.x-centre.x, vtexCoord.y-centre.y));
	float w = length(vec2(dFdx(d), dFdy(d)));	//anti aliasing
	
    //fragColor=vec4(1.0, vec2(step(0.2, d)), 1.0);
    fragColor = vec4(1.0, vec2(smoothstep(radi-w, radi+w, d)), 1.0);
}

