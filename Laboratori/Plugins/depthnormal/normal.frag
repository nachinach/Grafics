#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec3 snormal;

void main()
{
    vec3 color = (snormal / 2) + 0.5;
    fragColor = vec4( color, 1.0);
}
