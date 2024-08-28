<script setup lang="ts">
import { ref } from 'vue'
import { TresCanvas } from '@tresjs/core'
import { BasicShadowMap, NoToneMapping, SRGBColorSpace } from 'three'
import { Html, OrbitControls } from '@tresjs/cientos'

const gl = {
  clearColor: '#000000',
  shadows: true,
  alpha: false,
  shadowMapType: BasicShadowMap,
  outputColorSpace: SRGBColorSpace,
  toneMapping: NoToneMapping,
}

const modelRef = ref()
const groupRef= ref()

//animation
const { onLoop } = useRenderLoop()

onLoop(({ delta, elapsed }) => {
    if(groupRef.value){
        groupRef.value.rotation.y = elapsed * 0.2
    }
})

const points = [
    {
        position: [3, 6.5, 6.5],
        rotation: [0, 0,0],
        emoji: '🏛️',
        name: 'Parthenon',
        location: 'Athens, Greece'

    },
    {
        position: [4.5, 6, -5.5],
        rotation:[0, Math.PI * 0.7, 0],
        emoji:'🗼',
        name: 'Tokyo Tower',
        location:'Tokyo, Japan'
    },
    {
        position: [-7.3, 6, 2],
        rotation: [Math.PI * 0.1, -Math.PI * 0.4, 0],
        emoji: '🗽',
        name: 'Statue of Liberty',
        location:'NY, USA'
    }
]
</script>

<template>
  <TresCanvas 
    v-bind="gl" 
    window-size
  >
    <TresPerspectiveCamera 
        :position="[0, 3, -35]" 
    />

    <TresAmbientLight/>

    <TresDirectionalLight
        :intensity="2"
        :position="[-7, 3, -3]"
    />

    <OrbitControls />
    <Stars
        :radius="50"
        :depth="50"
        :count="5000"
        :size="0.3"
        :size-attenuation="true"
    />
    <TresGroup
        ref="groupRef"
    >
        <Suspense>
            <model
                ref="modelRef"
            />
        </Suspense>

        <Html
        v-for="point in points"
        transform
        occlude
        :distance-factor="20"
        :position="point.position"
        :rotation="point.rotation"
    >
        <div
            class="group flex flex-col items-center"
        >
            <p 
                class="dark:bg-dark text-3xl p-2 rounded-full w-fit"
            >
                {{ point.emoji }}
            </p>
            <p
                class="text-xs w-fit text-center bg-slate-300/70 p-2 rounded-md hidden transition-all ease-in-out duration-200 group-hover:block "
            >
                {{ point.name }} <br/> {{ point.location }}
            </p>
        </div>
        </Html>
    </TresGroup>

  </TresCanvas>
</template>