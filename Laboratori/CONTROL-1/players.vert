#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

out vec2 P;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main()
{
    vtexCoord = texCoord;
    P = vertex.xy * vec2(5, 10);

    vec3 vert = vertex;
    vert = vert * vec3(1, 2, 1);
    gl_Position = modelViewProjectionMatrix * vec4(vert, 1.0);
}
