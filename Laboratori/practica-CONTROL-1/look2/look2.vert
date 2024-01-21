#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float angle = 0.5;

float ymin = 1.45;
float ymax = 1.55;

void main()
{
	mat4 rot= mat4(vec4(cos(angle) ,0,-sin(angle),0),
				   vec4(0          ,1,0         ,0),
				   vec4(sin(angle),0,cos(angle),0),
				   vec4(0          ,0,0         ,1));


    float t = smoothstep(ymin, ymax, vertex.y);

    vec4 vertRot = rot * vec4(vertex,1);
    vec3 interp = mix(vertex, vertRot.xyz, t);


    vec4 nprim = rot * vec4(normal,0);
    vec3 ninterp = mix(normal, nprim.xyz, t);

    vec3 N = normalize(normalMatrix * ninterp);
    frontColor = vec4(vec3(N.z),1.0);

    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(interp, 1.0);
}
