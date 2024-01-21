#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;
uniform bool eyespace;
uniform float time;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

const float pi = 3.141592;

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;
    
    float r = distance(boundingBoxMax,boundingBoxMin)/2;
    float y = vertex.y;
    if(eyespace) y = (modelViewMatrix * vec4(vertex,1.0)).y;
    
    float d=(r/10)*y;
    
    gl_Position = modelViewProjectionMatrix * vec4(normal*(d*sin(time)) + vertex, 1.0);
	
}
