#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform mat4 modelViewMatrixInverse;
uniform mat4 modelViewMatrix;

uniform vec4 lightPosition;

out vec3 eyeN, eyeV, eyeL;
out vec3 worldN, worldV, worldL;

void main()
{
    eyeN = normalize(normalMatrix * normal);
    vec3 P = (modelViewMatrix * vec4(vertex.xyz,1)).xyz;
    eyeV = -P;
    eyeL = lightPosition.xyz - P;
    
    worldN = normal;
    worldV = (modelViewMatrixInverse*vec4(0,0,0,1)).xyz - vertex.xyz;
    worldL = (modelViewMatrixInverse*lightPosition).xyz - vertex.xyz;
    
    
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
