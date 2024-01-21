#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec3 boundingBoxMin; // cantonada minima de la capsa englobant
uniform vec3 boundingBoxMax; // cantonada maxima de la capsa englobant

vec3 RED = vec3(1,0,0);
vec3 GREEN = vec3(0,1,0);
vec3 BLUE = vec3(0,0,1);

void main()
{
    //frontColor = vec4(color,1.0);
    vec3 recolor;
    float punt = (vertex.y-boundingBoxMin.y)/(boundingBoxMax.y-boundingBoxMin.y);
    /*if ( vertex.y >= midY) {
        recolor = mix(BLUE, GREEN, vertex.y);
    } else {
        recolor = mix(GREEN, RED, vertex.y);
    }*/

	frontColor = vec4(mix(vec3(float(punt<0.5),float(punt>0.25),float(punt>0.75)),
                          vec3(float(punt<0.25),float(punt<0.75),float(punt>0.5)),
                          fract(4*punt)), 1);

    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
