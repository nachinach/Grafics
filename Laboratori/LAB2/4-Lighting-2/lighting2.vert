#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform mat4 modelViewMatrix;
uniform vec4 matAmbient;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;
uniform vec4 lightAmbient;
uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;
uniform vec4 lightPosition;

vec4 Phong(vec3 N, vec3 V, vec3 L) {
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

void main() {
    vec3 N = normalize(normalMatrix * normal);
    vec3 P = (modelViewMatrix * vec4(vertex.xyz, 1.0)).xyz;
    vec3 V = -P;
    vec3 L = (lightPosition.xyz - P);
    
    frontColor = Phong(N, V, L);
    gl_Position = modelViewProjectionMatrix * vec4(vertex.xyz, 1.0);
}
