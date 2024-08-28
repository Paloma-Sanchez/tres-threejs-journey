<template>
    <TresLeches
    />
    <TresCanvas
        window-size
        v-bind="gl"
    >
        <TresPerspectiveCamera
            :position="[0, 0, 15]"
        />
        <OrbitControls/>

        <TresAmbientLight
            v-if="ambientLight"
            :intensity="1"
        />
        <TresPointLight
            v-if="pointLight"
            :position="[0, -5, 1]"
            :intensity="4"
            color="red"
        />

        <Suspense>
            <Environment
              files="/assets/environmentMap/2k.hdr"
              :background="true"
              :environment="true"
            >

            </Environment>
        </Suspense> 
        <Suspense>
            <Materials/>
        </Suspense> 

    </TresCanvas> 

</template>
<script setup>
import { BasicShadowMap, NoToneMapping, SRGBColorSpace} from "three";
import '@tresjs/leches/styles'


const gl = {
  clearColor: "#ffffff",
  shadows: true,
  alpha: false,
//   shadowMapType: BasicShadowMap,
  outputColorSpace: SRGBColorSpace,
//   toneMapping: NoToneMapping,
};

const {ambientLight} = useControls({
  ambientLight: false,
})

const {pointLight} = useControls({
  pointLight: false,
})

watchEffect(() =>{
    console.log(ambientLight)
})
</script>
