#version 330 core

layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;
out vec2 gtexCoord;
out float isTop;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float step=0.50;


float light(vec3 a, vec3 b, vec3 c) {
    vec3 normal = cross(b-a,c-a);
    return normalize(normalMatrix * normal).z;
}

void makeface(vec3 a, vec3 b, vec3 c, vec3 d, float top) {
	isTop = top;

	gfrontColor = vfrontColor[0] * light(a,b,c);

	gtexCoord = vec2(0,0);
    gl_Position = modelViewProjectionMatrix * vec4(a,1); EmitVertex();

	gtexCoord = vec2(1,0);
	gl_Position = modelViewProjectionMatrix * vec4(b,1); EmitVertex();

	gtexCoord = vec2(0,1);
	gl_Position = modelViewProjectionMatrix * vec4(c,1); EmitVertex();

	gtexCoord = vec2(1,1);
	gl_Position = modelViewProjectionMatrix * vec4(d,1); EmitVertex();
    EndPrimitive();
}

vec3 traslate(float a, float b, float c) {
    /*vec4 C = (gl_in[0].gl_Position+gl_in[1].gl_Position+gl_in[2].gl_Position) / 3.0;
    C = round(C/step)*step ;
    return vec3(C) + vec3(a,b,c);*/

	vec3 BT = (gl_in[0].gl_Position.xyz + gl_in[1].gl_Position.xyz + gl_in[2].gl_Position.xyz)/3;
	BT /= step;
	BT.x = int(BT.x);
	BT.y = int(BT.y);
	BT.z = int(BT.z);
	BT *= step;
	return BT + vec3(a,b,c);
}

void main( void )
{
        float R = step/2;
        makeface(traslate(R,R,R), traslate(-R,R,R), traslate(R,-R,R), traslate(-R,-R,R), 0); // front face
        makeface(traslate(R,R,-R), traslate(R,-R,-R), traslate(-R,R,-R), traslate(-R,-R,-R), 0); // back face
        makeface(traslate(-R,R,R), traslate(-R,R,-R), traslate(-R,-R,R), traslate(-R,-R,-R), 0); // left face
        makeface(traslate(R,R,R), traslate(R,-R,R), traslate(R,R,-R), traslate(R,-R,-R), 0); // right face
        makeface(traslate(-R,-R,R), traslate(-R,-R,-R), traslate(R,-R,R), traslate(R,-R,-R), 0); // bottom face
        makeface(traslate(-R,R,R), traslate(R,R,R), traslate(-R,R,-R), traslate(R,R,-R), 1); // top face

}
