#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec3 Vfrag;

void main()
{
    vec3 normal = normalize(cross(dFdx(Vfrag), dFdy(Vfrag)));

    fragColor = frontColor * normal.z;
}
