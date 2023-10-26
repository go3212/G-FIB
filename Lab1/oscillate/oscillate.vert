#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform vec3 boundingBoxMax;
uniform vec3 boundingBoxMin;

float diagonal = length(boundingBoxMax - boundingBoxMin);
float pi = acos(-1);
float freq = (1/(2*pi));

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

uniform bool eyespace;
uniform float time;

void main()
{
    float y_coord = eyespace ? (modelViewMatrix*vec4(vertex, 1)).y : vertex.y;
    float amplitude = ((diagonal/2.0f)/10.0f)*y_coord;
    float distance = amplitude*sin(2*pi*freq*time);

    vec3 V = vertex + normal*distance;

    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(V, 1.0);
}
