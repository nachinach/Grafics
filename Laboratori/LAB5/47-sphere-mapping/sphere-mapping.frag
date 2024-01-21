#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform sampler2D glossy;

in vec3 P;
in vec3 N;

vec4 sampleSphereMap(sampler2D sampler, vec3 R)
{
	float z = sqrt((R.z+1.0)/2.0);
	vec2 st = vec2((R.x/(2.0*z)+1.0)/2.0, (R.y/(2.0*z)+1.0)/2.0);
    st.y = -st.y;
	return  texture(sampler, st);
}

void main()
{
	vec3 obs = vec3(0.0);
	vec3 I = normalize(P-obs);
	vec3 R = reflect(I, N);

	fragColor = sampleSphereMap(glossy, R);
}
