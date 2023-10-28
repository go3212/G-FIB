#version 330 core

in vec3 fNormal;
in vec3 fColor;
out vec4 fragColor;

uniform mat3 normalMatrix;

void main()
{
    vec3 N = normalize(normalMatrix * fNormal);
    fragColor = vec4(fColor,1.0)*N.z;
}
