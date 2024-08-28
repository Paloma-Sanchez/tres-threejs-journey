<template>
    <TresPoints>
      <TresPointsMaterial
        :size="20"
        color="mediumpurple"
        :alpha-map="particleTexture.alphaMap"
        :opacity="1"
        :depth-write="false"
        :transparent="true"
        :size-attenuation="true"
      />
      <TresBufferGeometry
        :position="[positionArray, 3]"
      />
    </TresPoints>
</template>

<script setup>
//Particles texture
const particleTexture = await useTexture({
    alphaMap: './assets/particles/flame_02.png'
})

//Particles position
const particleCount = 5000
const viewportSize = {
    width: window.innerWidth,
    height: window.innerHeight
}

const positionArray = new Float32Array(particleCount * 3)
for(let i = 0; i < particleCount; i++){
    const i3 = i * 3
    positionArray[i3] = (Math.random() - 0.5) * viewportSize.width*0.03
    positionArray[i3 + 1] =  viewportSize.height * 0.01 + Math.random() ** 0.25 * - viewportSize.height * 0.08
    positionArray[i3 + 2] = ( Math.random() - 0.5) * 25
}


</script>