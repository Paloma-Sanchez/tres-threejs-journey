
varying vec2 vUv;

void main()
{
  vec2 newVUv= vec2(
    vUv.x * 0.2 + 0.4,
    vUv.y
  );

  float strength = 0.015/ distance(newVUv, vec2(0.5));

  gl_FragColor = vec4(vec3(strength), 1.0);
}
