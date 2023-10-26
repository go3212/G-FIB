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
uniform float amp = 0.5f;
uniform float freq = 0.25f;

float x_0 = amp*sin(vertex.y);
float pi = 3.141592;

void main()
{
    float x_rad = -amp*sin(2*pi*freq*time + vertex.y);
    
    mat3 x_rot = mat3(
        1, 0, 0,
        0, cos(x_rad), -sin(x_rad),
        0, sin(x_rad), cos(x_rad)
    );

    vec3 V = x_rot*vertex;

    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0) * N.z;
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(V, 1.0);
}
