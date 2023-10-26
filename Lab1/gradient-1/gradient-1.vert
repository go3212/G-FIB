#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

float minY = boundingBoxMin.y;
float maxY = boundingBoxMax.y;

vec3 red = vec3(1.0, 0.0, 0.0);
vec3 yellow = vec3(1.0, 1.0, 0.0);
vec3 green = vec3(0.0, 1.0, 0.0);
vec3 cyan = vec3(0.0, 1.0, 1.0);
vec3 blue = vec3(0.0, 0.0, 1.0);

void main()
{
    float t = (vertex.y - minY) / (maxY - minY);

    vec3 color = vec3(0,0,0);

    if (t < 0.25f) color = mix(red, yellow, t/0.25f);
    else if (t < 0.5f) color = mix(yellow, green, (t - 0.25f)/0.25f); 
    else if (t < 0.75f) color = mix(green, cyan, (t - 0.5f)/0.25f); 
    else color = mix(cyan, blue, (t - 0.75f)/0.25f); 

    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
