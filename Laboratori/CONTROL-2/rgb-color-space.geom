#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

out vec3 tCentre;
out vec2 gtexCoord;
float mida_cara = 0.16;
float mc = mida_cara/2;

uniform mat4 modelViewProjectionMatrix;

void makeFace(vec3 a, vec3 b, vec3 c, vec3 d) {
	gtexCoord = vec2(0,0);
	gl_Position = modelViewProjectionMatrix * vec4(a, 1); EmitVertex();
	gtexCoord = vec2(1,0);
	gl_Position = modelViewProjectionMatrix * vec4(b, 1); EmitVertex();
	gtexCoord = vec2(0,1);
	gl_Position = modelViewProjectionMatrix * vec4(c, 1); EmitVertex();
	gtexCoord = vec2(1,1);
	gl_Position = modelViewProjectionMatrix * vec4(d, 1); EmitVertex();
	EndPrimitive();
}

void main( void )
{
	// CALCULEM CENTRE DEL TRIANGLE
	tCentre = ((gl_in[0].gl_Position + gl_in[1].gl_Position + gl_in[2].gl_Position) / 3.0).xyz; // baricentre

	// ASSIGNEM COLOR
	gfrontColor = vec4((tCentre * vec3(0.5) + 0.5), 1.0); // passem el color de [-1, 1] a [0, 1]

	// DIBUIXEM UN CUB
	makeFace(vec3(tCentre.x + mc,tCentre.y + mc, tCentre.z + mc),
			 vec3(tCentre.x + mc,tCentre.y + mc, tCentre.z - mc),
			 vec3(tCentre.x + mc,tCentre.y - mc, tCentre.z + mc),
			 vec3(tCentre.x + mc,tCentre.y - mc, tCentre.z - mc)); // x positives

	makeFace(vec3(tCentre.x - mc,tCentre.y + mc, tCentre.z + mc),
			 vec3(tCentre.x - mc,tCentre.y + mc, tCentre.z - mc),
			 vec3(tCentre.x - mc,tCentre.y - mc, tCentre.z + mc),
			 vec3(tCentre.x - mc,tCentre.y - mc, tCentre.z - mc)); // x negatives

	makeFace(vec3(tCentre.x + mc,tCentre.y + mc, tCentre.z + mc),
			 vec3(tCentre.x + mc,tCentre.y + mc, tCentre.z - mc),
			 vec3(tCentre.x - mc,tCentre.y + mc, tCentre.z + mc),
			 vec3(tCentre.x - mc,tCentre.y + mc, tCentre.z - mc)); // y positives

	makeFace(vec3(tCentre.x + mc,tCentre.y - mc, tCentre.z + mc),
			 vec3(tCentre.x + mc,tCentre.y - mc, tCentre.z - mc),
			 vec3(tCentre.x - mc,tCentre.y - mc, tCentre.z + mc),
			 vec3(tCentre.x - mc,tCentre.y - mc, tCentre.z - mc)); // y negatives

	makeFace(vec3(tCentre.x + mc,tCentre.y + mc, tCentre.z + mc),
			 vec3(tCentre.x + mc,tCentre.y - mc, tCentre.z + mc),
			 vec3(tCentre.x - mc,tCentre.y + mc, tCentre.z + mc),
			 vec3(tCentre.x - mc,tCentre.y - mc, tCentre.z + mc)); // z positives

	makeFace(vec3(tCentre.x + mc,tCentre.y + mc, tCentre.z - mc),
			 vec3(tCentre.x + mc,tCentre.y - mc, tCentre.z - mc),
			 vec3(tCentre.x - mc,tCentre.y + mc, tCentre.z - mc),
			 vec3(tCentre.x - mc,tCentre.y - mc, tCentre.z - mc)); // z negatives
}
