<template>

    <TresCanvas
        window-size
        v-bind="gl"
    >
        <TresPerspectiveCamera
            :position="[0, 0, 5.5]"
            :fov="75"
        />

        <OrbitControls/>

        <!-- Commun torus geometry passed to the donuts as a prop -->
        <TresTorusGeometry
            ref="torusGeometry"
            :args="[0.4, 0.3, 16, 100]"
        />

        <!-- Commun material passed to the meshes as a prop -->
        <TresMeshMatcapMaterial
            ref="matcapMaterial"
            :matcap="texture01.matcap"
        />

        <Suspense>
            <Text3D
              text="reactiveText"
              :size="0.3"
              :height="0.01"
              :font="fontPath"
              center
              :need-updates="true"
              :rotation="[0, 0, 0]"
              :material="matcapMaterial"
            />
        </Suspense>
            <TresGroup
                ref="donuts"
            >
                <Donut
                    v-for="el,index in donutCount"
                    :key="index"
                    :geometry="torusGeometry"
                    :material="matcapMaterial"
                />
            </TresGroup>
    </TresCanvas>

</template>
<script setup>
import { useTexture } from "@tresjs/core";
import { OrbitControls } from "@tresjs/cientos";
import { BasicShadowMap, NoToneMapping, SRGBColorSpace} from "three";

const donutCount = Array(300)
const fontPath = "/fonts/OpenSans_Regular.json";

const matcapMaterial = ref(null)
const torusGeometry = ref(null)
const donuts = ref([])

const { onLoop } = useRenderLoop()

onLoop(({delta}) => {
    if(donuts?.value?.children){
        donuts.value.children.forEach((child) => {
            child.rotation.y += delta
        })
    }
})

// onLoop(({delta}) => {
//     if(donuts?.value){
//         // console.log('donuts', donuts.value)
//         donuts.value.forEach(donut => {
//         //    console.log('donut', donut) 
//         });
//     }
// })

//Canvas params
const gl = {
  clearColor: "#ffffff",
  shadows: true,
  alpha: false,
  shadowMapType: BasicShadowMap,
  outputColorSpace: SRGBColorSpace,
  toneMapping: NoToneMapping,
};

//Loading texture
let texture01 = null
try{
    texture01 = await useTexture({
        matcap: '/matcap/matcap_02.png',  
    })
} catch(e){
    console.log(e)
}



</script>
