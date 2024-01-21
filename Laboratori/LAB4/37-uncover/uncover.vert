#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

out float pos;

void main()
{
    //frontColor = vec4(0.0, 0.0, 1.0, 1.0);
    //vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
    pos = (gl_Position.x/gl_Position.w)+1; //NDC (normalize device coordinate) i +1 perque està entre -1 i 1 i la vull entre 0 i 2
}
