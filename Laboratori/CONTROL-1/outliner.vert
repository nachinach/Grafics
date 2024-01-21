#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;

out vec3 nrotEye;
out vec3 P;
//out vec3 N;

float angle = radians(90.0);

void main()
{
    mat4 rot = mat4(vec4(1,0,0,0),
                    vec4(0,cos(angle),sin(angle),0),
                    vec4(0,-sin(angle),cos(angle),0),
                    vec4(0,0,0,1));

    vec4 vrot = rot * vec4(vertex, 1);
    P = (modelViewMatrix * vrot).xyz;
    vec3 nrotEye = normalize(normalMatrix*(rot * vec4(normal, 0)).xyz);

    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vrot;


}
