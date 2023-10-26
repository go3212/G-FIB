#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float time;

void main()
{
    float scale = 0.5f + abs(sin(time));

    vec4 clipSpace = modelViewProjectionMatrix * vec4(vertex, 1.0);

    vec3 ndc = clipSpace.xyz / clipSpace.w;
    clipSpace.x = ndc.x * clipSpace.w * scale;
    clipSpace.y = ndc.y * clipSpace.w * scale;

    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0) * N.z;
    vtexCoord = texCoord;
    gl_Position = clipSpace;
}
