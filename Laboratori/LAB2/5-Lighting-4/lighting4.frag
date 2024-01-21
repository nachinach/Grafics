#version 330 core

in vec4 frontColor;
out vec4 fragColor;

//llums
uniform vec4 lightAmbient;  // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse;  // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; // similar a gl_LightSource[0].position; en eye space

uniform vec4 matAmbient;    // similar a gl_FrontMaterial.ambient 
uniform vec4 matDiffuse;    // similar a gl_FrontMaterial.diffuse 
uniform vec4 matSpecular;   // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess

in vec3 N;
in vec3 P;
in vec3 V;

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
	vec3 L = lightPosition.xyz - P;
	
    fragColor = llumPhong(N, V, L);
}
