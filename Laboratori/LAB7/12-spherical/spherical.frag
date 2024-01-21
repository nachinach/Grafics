#version 330 core

out vec4 fragColor;
in vec2 gPos;

uniform sampler2D colorMap;

void main()
{
    vec4 color = texture(colorMap, gPos);
    if (color.a < 1) discard;
    else fragColor = color;
}
