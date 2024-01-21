#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];

out vec4 gfrontColor;
out vec3 gnormal;

vec3 auxNormal;

uniform mat4 projectionMatrix;
uniform float disp = 0.05;

void makeTface(vec3 a, vec3 b, vec3 c) { // Make triangle face
	gnormal = cross(b-a,c-a); //calculem la normal

	gfrontColor = vfrontColor[0];
    gl_Position = projectionMatrix * vec4(a,1); EmitVertex();
	gfrontColor = vfrontColor[0];
	gl_Position = projectionMatrix * vec4(b,1); EmitVertex();
	gfrontColor = vec4(1.0);
	gl_Position = projectionMatrix * vec4(c,1); EmitVertex();

    EndPrimitive();
}

void main( void ) {
	// calcul de les normals dels vertexs
	auxNormal = normalize(cross(gl_in[1].gl_Position.xyz - gl_in[0].gl_Position.xyz, gl_in[2].gl_Position.xyz - gl_in[0].gl_Position.xyz));

	//coords base triangle
	mat3 vBase = mat3(gl_in[0].gl_Position.xyz, gl_in[1].gl_Position.xyz, gl_in[2].gl_Position.xyz);
	// baricentre
	vec3 vCentre = ((gl_in[0].gl_Position + gl_in[1].gl_Position + gl_in[2].gl_Position) / 3.0).xyz;

	makeTface(vBase[0], vBase[1],vCentre + disp * auxNormal);
	makeTface(vBase[1], vBase[2],vCentre + disp * auxNormal);
	makeTface(vBase[0], vBase[2],vCentre + disp * auxNormal);
}
