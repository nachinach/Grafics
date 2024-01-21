#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

out vec3 N;
out vec3 P;
out vec3 V;

void main()
{
    N = normalize(normalMatrix * normal);
    P = (modelViewMatrix * vec4(vertex.xyz, 1)).xyz;
    V = -P;
	
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
