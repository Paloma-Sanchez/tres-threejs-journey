
varying vec2 vUv;

#include './includes/cnoise.glsl';

void main()
{
  float strength = step(0.9, sin(cnoise(vUv * 10.0) * 20.0));

  gl_FragColor = vec4(vec3(strength), 1.0);
}
