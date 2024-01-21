#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec3 nrotEye;
in vec3 P;
//in vec3 N;

uniform int mode = 0;
vec4 BLANC = vec4(1);
vec4 NEGRE = vec4(vec3(0), 1);

void main()
{
    if (mode == 0) {
        fragColor = vec4(vec3(nrotEye.z), 1); //la normal la tinc en clip space i per això no funciona
                                             // no tinc ara en ment per quina matriu haig de multiplicar
                                              //la normal per tenir-la en eye space :/
    }

    if (mode == 1) {
        mix(BLANC, NEGRE, step(0.4, nrotEye.z));

    } else if (mode == 2) {

    }

}
