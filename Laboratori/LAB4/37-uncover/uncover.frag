#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform float time;
in float pos;

void main()
{
    if (pos <= time) fragColor = vec4(0.0, 0.0, 1.0, 1.0);
    else discard;
}
