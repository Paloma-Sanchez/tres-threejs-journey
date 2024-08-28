<template>
    <TresCanvas
        window-size
        clear-color="#0000ff"
        shadows
    >
        <TresPerspectiveCamera
            :position="[-0, 3, -15]"
            :near="0.01"
        />

        <OrbitControls/>

        <TresDirectionalLight
            cast-shadow
            :position="[-0.5, 2, - 4.25]"
            :intensity="3"
            :shadow-camera-near="0.01"
            :shadow-camera-far="100"
        />

        <Suspense>
            <Environment
                ref="environmentTexture" 
                :files="[
                    './textures/environmentMaps/0/px.jpg',
                    './textures/environmentMaps/0/nx.jpg',
                    './textures/environmentMaps/0/py.jpg',
                    './textures/environmentMaps/0/ny.jpg',
                    './textures/environmentMaps/0/pz.jpg',
                    './textures/environmentMaps/0/nz.jpg'
                ]"
                :background="true"
            />
        </Suspense>

        <Suspense>
            <Model
                :position="[-2.5, 0, 0]"

            />
        </Suspense>

        <Suspense>
            <WobbleModel
                :position="[2.5, 0, 0]"

            />
        </Suspense>

        <TresMesh
            receive-shadow
            :rotation="[-Math.PI, 0, 0]"
            :position="[0, -3.5, 6.5]"
        >
            <TresPlaneGeometry 
                :args="[14, 10]" 
            />
            <TresMeshStandardMaterial color="#f7f7f7" />
        </TresMesh>

    </TresCanvas>

        
</template>
<script setup lang="ts">
import { TresCanvas } from '@tresjs/core'


</script>
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

</style>