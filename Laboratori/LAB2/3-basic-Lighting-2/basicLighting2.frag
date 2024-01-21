#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec3 N;

uniform mat4 viewMatrixInverse;

void main()
{    
    vec3 N2 = normalize(N);
    
    fragColor = frontColor * N2.z; //normalFrag.z;
}
