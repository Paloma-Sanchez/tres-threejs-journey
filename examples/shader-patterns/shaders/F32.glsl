
#define PI 3.1415926535897932384626433832795

varying vec2 vUv;

#include './includes/rotate.glsl'

void main()
{
  vec2 rotatedUv = rotate(vUv, PI * 0.25, vec2(0.5));

  vec2 newVUvX= vec2(
    rotatedUv.x * 0.1 + 0.45,
    rotatedUv.y * 0.5 + 0.25
  );
    
  vec2 newVUvY= vec2(
    rotatedUv.x * 0.5 + 0.25,
    rotatedUv.y * 0.1 + 0.45
  );
  
  float strength = 0.015/ distance(newVUvX, vec2(0.5)) * 0.015/ distance(newVUvY, vec2(0.5));

  gl_FragColor = vec4(vec3(strength), 1.0);
}
