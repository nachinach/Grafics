#version 330 core

layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

in vec3 objectNormal[];
out vec3 gnormal;
out vec3 gPos;

vec3 auxNormal;

uniform mat4 modelViewProjectionMatrix;
uniform float d = 0.1;

void makeTface(vec3 a, vec3 b, vec3 c) { // Make triangle face
	gnormal = cross(b-a,c-a); //calculem la normal

	//gnormal = objectNormal[0];
	gPos = a;
    gl_Position = modelViewProjectionMatrix * vec4(a,1); EmitVertex();
	//gnormal = objectNormal[1];
	gPos = b;
	gl_Position = modelViewProjectionMatrix * vec4(b,1); EmitVertex();
	//gnormal = objectNormal[2];
	gPos = c;
	gl_Position = modelViewProjectionMatrix * vec4(c,1); EmitVertex();

    EndPrimitive();
}

void makeSface(vec3 a, vec3 b, vec3 c, vec3 d) { // Make square face
	gnormal = cross(b-a,c-a); //calculem la normal

	gPos = a;
    gl_Position = modelViewProjectionMatrix * vec4(a,1); EmitVertex();
	gPos = b;
	gl_Position = modelViewProjectionMatrix * vec4(b,1); EmitVertex();
	gPos = c;
	gl_Position = modelViewProjectionMatrix * vec4(c,1); EmitVertex();
	gPos = d;
	gl_Position = modelViewProjectionMatrix * vec4(d,1); EmitVertex();

    EndPrimitive();
}

void main( void )
{
	for (int i = 0; i < 3; ++i) {
		auxNormal[i] = (objectNormal[0][i]+objectNormal[1][i]+objectNormal[2][i])/3;
	}

	mat3 vbase = mat3(gl_in[0].gl_Position.xyz, gl_in[1].gl_Position.xyz, gl_in[2].gl_Position.xyz);
	mat3 vtop = mat3(vbase[0] + d * auxNormal,
					 vbase[1] + d * auxNormal,
					 vbase[2] + d * auxNormal);

	makeTface(vbase[0], vbase[1], vbase[2]);
	//makeTface(vtop[0], vtop[1], vtop[2]);

	makeSface(vbase[0], vbase[1], vtop[0], vtop[1]);
	//makeSface(vbase[0], vbase[2], vtop[0], vtop[2]);
	makeSface(vbase[2], vbase[1], vtop[2], vtop[1]);
}
