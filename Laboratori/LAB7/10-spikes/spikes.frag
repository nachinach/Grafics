#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;

in vec3 gnormal;

void main()
{
    fragColor = gfrontColor;
}
