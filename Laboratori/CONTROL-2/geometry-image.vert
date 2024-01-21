#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
// Uniforms Phong
uniform mat4 modelViewMatrix;
uniform vec4 matAmbient;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;
uniform vec4 lightAmbient;
uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;
uniform vec4 lightPosition;

uniform sampler2D positionMap;
uniform sampler2D normalMap1;

uniform int mode = 0;

vec2 lim =  vec2(0.004, 0.996);

vec4 ilumPhong(vec3 N, vec3 V, vec3 L, vec4 P) {
    V = normalize(V);
    L = normalize(L);

    // component ambient
	vec4 iluminacio = matAmbient * lightAmbient;

	// component difosa
    float NdotL = max(0.0, dot(N,L));
    if (mode == 2) iluminacio += matDiffuse * lightDiffuse * NdotL;
    else if (mode == 3) iluminacio += P * lightDiffuse * NdotL;

    // component especular
	vec3 R = normalize(2.0 * dot(N,L) * N-L);
	float RdotV = max(0.0, dot(R,V));
	float Ispec = 0;
    if (NdotL > 0) Ispec = pow(RdotV, matShininess);
    iluminacio += matSpecular * lightSpecular * Ispec;

    return iluminacio;
}

void main()
{
    vtexCoord = vertex.xy * vec2((lim[1] - lim[0])/2) + 0.5; // escalem al rang [0.004, 0.996]

    vec4 positions = texture(positionMap, vtexCoord);
    vec4 normals = texture(normalMap1, vtexCoord);
    vec4 esc_normals = (normals - 0.5) * 2; // escalem les normals a [-1, 1]


    vec3 N = normalize(normalMatrix * esc_normals.xyz);

    if (mode <= 0 || mode > 3) { // MODE 0 (Qualsevol valor fora de [1, 3] entra com a mode 0)
        frontColor = positions; // El color es directament el del punt P (positions)
    }
    else if (mode == 1) { // MODE 1
        frontColor = positions * N.z;
    } else if (mode >= 2 && mode <= 3) { // MODE 2 i 3
        vec3 P = (modelViewMatrix * vec4(vertex.xyz, 1.0)).xyz;
        vec3 V = -P;
        vec3 L = (lightPosition.xyz - P);

        frontColor = ilumPhong(N, V, L, positions);
    }

    gl_Position = modelViewProjectionMatrix * positions;
}
