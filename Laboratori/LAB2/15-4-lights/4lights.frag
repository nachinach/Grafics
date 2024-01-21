#version 330 core

uniform mat4 modelViewMatrixInverse;

out vec4 fragColor;

in vec3 N;  // normal (en object space)
in vec3 P;  // posicio del vertex (en object space)

uniform float time;
uniform bool rotate;

uniform vec3 verd	 = vec3(0.0, 1.0, 0.0);
uniform vec3 groc	 = vec3(1.0, 1.0, 0.0);
uniform vec3 blau	 = vec3(0.0, 0.0, 1.0);
uniform vec3 vermell = vec3(1.0, 0.0, 0.0);

uniform vec3 posVerd 	= vec3(0, 10, 0); // en eye space
uniform vec3 posGroc 	= vec3(0,-10,0);
uniform vec3 posBlau 	= vec3(10, 0,0);
uniform vec3 posVermell = vec3(-10,0,0);

// V, N, P, lightPos han d'estar al mateix espai de coordenades
// V és el vector unitari cap a l'observador
// N és la normal
// P és la posició 
// lightPos és la posició de la llum
// lightColor és el color de la llum
vec4 light(vec3 V, vec3 N, vec3 P, vec3 lightPos, vec3 lightColor)
{
	const float shininess = 100.0;
	const float Kd = 0.5;
	N = normalize(N);
	vec3 L = normalize(lightPos - P);
	vec3 R = reflect(-L, N);
	float NdotL = max(0.0, dot(N,L));
	float RdotV = max(0.0, dot(R,V));
	float spec =  pow( RdotV, shininess);
	return vec4(Kd*lightColor*NdotL + vec3(spec),0);
}

void main()
{
	float angle = 0;
	if (rotate) angle = time;
	float cs = cos(angle);
	float sn = sin(angle);
	mat3 R = mat3(vec3(cs, sn, 0), vec3(-sn, cs,0), vec3(0,0,1));

	//Calcul posicions de les llums
	vec3 p1 = vec3(modelViewMatrixInverse * vec4(R * posVerd,1.0)).xyz;
	vec3 p2 = vec3(modelViewMatrixInverse * vec4(R * posGroc,1.0)).xyz;
	vec3 p3 = vec3(modelViewMatrixInverse * vec4(R * posBlau,1.0)).xyz;
	vec3 p4 = vec3(modelViewMatrixInverse * vec4(R * posVermell,1.0)).xyz;

	vec3 V = normalize(modelViewMatrixInverse[3].xyz - P);
	vec4 c = vec4(0);
	
	c = light(V,N,P,p1,verd) + light(V,N,P,p2,groc) + light(V,N,P,p3,blau) + light(V,N,P,p4,vermell);
	fragColor = c;
}

