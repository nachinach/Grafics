#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float time;

void main()
{
    vec4 vrot = vec4(vertex, 1.0);
    float angle = (vrot.y - 0.5)*sin(time);
    mat4 rot = mat4(vec4(1,0,0,0),
                    vec4(0,cos(angle),sin(angle),0),
                    vec4(0,-sin(angle),cos(angle),0),
                    vec4(0,0,0,1));
    mat4 trans = mat4(vec4(1,0,0,0),
                      vec4(0,1,0,0),
                      vec4(0,0,1,0),
                      vec4(0,-1,0,1));
    mat4 transInv = mat4(vec4(1,0,0,0),
                         vec4(0,1,0,0),
                         vec4(0,0,1,0),
                         vec4(0,1,0,1));
    if (vrot.y >= 0.5) {
        vrot = transInv * rot * trans * vrot;
    }
    //vrot = trans * vrot;

    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vrot;
}
