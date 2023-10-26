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

vec3 transl_vect = vec3(0,-1,0);

void main()
{
    float A = vertex.y >= 0.5 ? -(vertex.y - 0.5)*sin(time) : 0.0f;

    mat3 x_rot = mat3(
        1, 0, 0,
        0, cos(A), -sin(A),
        0, sin(A), cos(A)
    );

    vec3 V = vertex + transl_vect;
    V = x_rot*V;
    V = V - transl_vect;

    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(V, 1.0);
}
