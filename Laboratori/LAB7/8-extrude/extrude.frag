#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;

in vec3 gnormal;

uniform mat3 normalMatrix;

void main()
{
    fragColor = vec4(1.0) * normalize(normalMatrix * gnormal).z;
}
