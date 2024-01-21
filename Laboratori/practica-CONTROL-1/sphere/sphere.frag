#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

uniform int mode = 2;

uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

uniform vec4 matAmbient, matDiffuse, matSpecular;
uniform float matShininess;
uniform vec4 lightAmbient, lightDiffuse, lightSpecular, lightPosition;

vec3 centre = vec3(0);

vec4 BLACK = vec4(vec3(0), 1);

vec4 llumPhong (vec3 N, vec3 V, vec3 L) {
	N = normalize(N);
	V = normalize(V);
	L = normalize(L);

	//ambient
	vec4 iluminacio = matAmbient * lightAmbient; //Ke + matAmbient*(Ma + lightAmbient)

	//difós
    float NdotL = max(0.0, dot(N,L));
    iluminacio += matDiffuse * lightDiffuse * NdotL; //matDiffuse*lightDiffuse*max(0, N*L)

    //especular
	vec3 R = normalize(2.0 * dot(N,L) * N-L);
	float RdotV = max(0.0, dot(R,V));
	float Ispec = 0;
    if (NdotL > 0) Ispec = pow(RdotV, matShininess);
    iluminacio += matSpecular * lightSpecular * Ispec; //matSpecular*lightSpecular*max(0, R*V)^s

    return iluminacio;
}

void main()
{
    float dist = length(vec2(vtexCoord.x,vtexCoord.y));
    if (!(bool (step(1.0, dist)))) {
        fragColor = BLACK;
    } else {
        discard;
    }
    if (mode >= 1) {
        vec3 P = vec3(vtexCoord.s,vtexCoord.t,sqrt(1-pow(vtexCoord.s,2)-pow(vtexCoord.t,2)));

        fragColor = vec4(vec3(P.z),1);

        if (mode == 2) {

            vec3 V = (modelViewMatrix * vec4(P, 0)).xyz;
            vec3 Vaux = (modelViewMatrix * vec4(P, 1)).xyz;
            vec3 L = vec3(lightPosition.x - Vaux.x, lightPosition.y - Vaux.y, lightPosition.z - Vaux.z);

            fragColor = llumPhong(normalMatrix*P, V, L);
        }
    }
}
