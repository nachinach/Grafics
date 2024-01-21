#version 330 core

out vec4 fragColor;

uniform vec4 lightAmbient;  // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse;  // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; // similar a gl_LightSource[0].position; en eye space

uniform vec4 matAmbient;    // similar a gl_FrontMaterial.ambient 
uniform vec4 matDiffuse;    // similar a gl_FrontMaterial.diffuse 
uniform vec4 matSpecular;   // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess

uniform bool world = true;

in vec3 eyeN, eyeV, eyeL;
in vec3 worldN, worldV, worldL;

vec4 light(vec3 N, vec3 V, vec3 L) {
    N=normalize(N); V=normalize(V); L=normalize(L);
    vec3 R = normalize( 2.0*dot(N,L)*N-L );
    float NdotL = max( 0.0, dot( N,L ) );
    float RdotV = max( 0.0, dot( R,V ) );
    float Idiff = NdotL;
    float Ispec = 0;
    if (NdotL>0) Ispec=pow( RdotV, matShininess );
    return  matAmbient  * lightAmbient +
            matDiffuse  * lightDiffuse * Idiff+
            matSpecular * lightSpecular * Ispec;
}

void main()
{
    if (world) fragColor = light(worldN, worldV, worldL);
    else fragColor = light(eyeN, eyeV, eyeL);
}
