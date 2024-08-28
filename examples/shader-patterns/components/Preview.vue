<script lang="ts" setup>
import { TresCanvas } from '@tresjs/core'
import fragmentShaders from '../shaders/index.js'

const progress = ref(0)
const shaderCollection = ref()
const scRef = ref()

const { onLoop } = useRenderLoop()
onLoop(() => {
  if (shaderCollection.value) {
    shaderCollection.value.position.y = progress.value * 5.5
    
  }
})

</script>
<template>
    <TresCanvas
        window-size
        clear-color="#000000"
    >
      <TresPerspectiveCamera
        :position="[0, -0.5, 2]"
      />         
      
      <Stars :radius="0.5"/>

      <ScrollControls 
        ref="scRef"
        v-model="progress"
        :distance="10"
        html-scroll
      >

      <TresGroup
        ref="shaderCollection"
      >
        <Shader v-for="fragment, fKey, index in fragmentShaders"
          :fragment="fragment"
          :index="index"
        />

      </TresGroup>

      </ScrollControls>
            
    </TresCanvas>

</template>

<style>
html,
body {
  margin: 0;
  padding: 0;
  height: 230vh;
  width: 100%;
}
#app {
  height: 100vh;
  width: 100%;
  overflow: hidden;
}

.number{
  height: 200vh;
}
</style>