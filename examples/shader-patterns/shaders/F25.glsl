
varying vec2 vUv;

#include './includes/random.glsl'

void main()
{
  vec2 gridUv = vec2(
    floor(vUv.x  * 10.0) /10.0,
    floor((vUv.y + vUv.x )* 10.0 ) /10.0
  );

  float strength = random(gridUv);

  gl_FragColor = vec4(vec3(strength), 1.0);
}
