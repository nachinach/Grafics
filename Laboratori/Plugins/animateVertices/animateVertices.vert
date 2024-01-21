#version 330 core
const float pi = 3.141592;
const float amplitude = 0.1;
const float freq = 1.0;

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform float time;

vec3 animation() {
    return vertex + normal * amplitude * sin(2.0 * pi * freq * time);
}

void main() {
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(N.z);
    gl_Position = modelViewProjectionMatrix * vec4(animation(), 1.0);
}
