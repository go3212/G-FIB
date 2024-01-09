#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;
out vec3 N;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;
uniform float lambda;

void main()
{
	N = normalize(normalMatrix * normal);
	vec3 red = vec3(1.0, 0.0, 0.0);
    vec3 green = vec3(0.0, 1.0, 0.0);
	vec3 newColor = mix(red, green, lambda);
	frontColor = vec4(newColor, 1.0)*N.z;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
