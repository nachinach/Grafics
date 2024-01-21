#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;

in vec3 gnormal;
in vec3 gPos;

uniform mat3 normalMatrix;
uniform sampler2D grass_top0;
uniform sampler2D grass_side1;

uniform float d = 0.1;

void main()
{
    if (gnormal.z == 0) {
        vec4 aux = texture(grass_side1, -vec2(4*(gPos.x - gPos.y), 1.0 - gPos.z/d));
        if (aux.a < 0.1) discard;
        else fragColor = aux;
    } else {
        fragColor = texture(grass_top0, 4*gPos.xy);
    }
}
