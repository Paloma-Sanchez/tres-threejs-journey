<template>

        <!-- Materials -->
        <TresMeshBasicMaterial
            ref="basicMaterialRef"
            :map="doorTexture.map"
            :side="DoubleSide"
        />

        <TresMeshNormalMaterial
            ref="normalMaterialRef"
            :side="DoubleSide"
        />

        <TresMeshMatcapMaterial
            ref="matcapMaterialRef"
            :matcap="matcapTexture.matcap"
            :side="DoubleSide"
        />  

        <TresMeshDepthMaterial
            ref="depthMaterialRef"
            :side="DoubleSide"
        />

        <TresMeshLambertMaterial
            ref="lambertMaterialRef"
            :side="DoubleSide"
        />

        <TresMeshPhongMaterial
            ref="phongMaterialRef"
            :shininess="500"
            specular="red"
            :side="DoubleSide"
        />

        <TresMeshStandardMaterial
            ref="standardMaterialRef"
            :metalness="1"
            :roughness="1"
            :map="doorTexture.map"
            :aoMap="doorTexture.aoMap"
            :aoMapIntensity="1"
            :displacementMap="doorTexture.displacementMap"
            :displacementScale="0.2"
            :normalMap="doorTexture.normalMap"
            :normalScale="[1.5, 1.5]"
            :alphaMap="doorTexture.alphaMap"
            :metalnessMap="doorTexture.metalnessMap"
            :roughnessMap="doorTexture.roughnessMap"
            :transparent="true"
            :side="DoubleSide"
        />

        <TresMeshPhysicalMaterial
            ref="physicalMaterialRef"
            :metalness="0"
            :roughness="0"
            :transmission="1"
            :ior="1.5"
            :thickness="0.5"
            :side="DoubleSide"
        />
        
        <!-- Geometries-->
         <TresSphereGeometry
            :args="[0.5, 64, 64]"
            ref="sphereGeometryRef"
        />
        
        <TresTorusGeometry
            :args="[0.3, 0.2, 16, 32]"
            ref="torusGeometryRef"
        />
            
        <TresPlaneGeometry
            :args="[1, 1, 100,100]"
            ref="planeGeometryRef"
        />

        <!-- Meshes -->
        <TresGroup
            ref="meshGroup"
        >
            <Meshes
                v-if="basicMaterialRef !== null"
                v-for="option, index in options"
                :material="option"
                :sphere-geometry="sphereGeometryRef"
                :plane-geometry="planeGeometryRef"
                :torus-geometry="torusGeometryRef"
                :position="[0, -index*1.5 + 5, 0]"
                :labels="labels"
            />
        </TresGroup>

</template>
<script setup>
import { DoubleSide} from "three";

// Geometries
const sphereGeometryRef = ref(null)
const torusGeometryRef = ref(null)
const planeGeometryRef = ref(null)

/**
 * Materials
 */
const basicMaterialRef = ref(null)
const normalMaterialRef = ref(null)
const matcapMaterialRef = ref(null)
const depthMaterialRef = ref(null)
const lambertMaterialRef = ref(null)
const phongMaterialRef = ref(null)
// const toonMaterialRef = ref(null)
const standardMaterialRef = ref(null)
const physicalMaterialRef = ref(null)

const options= [
    basicMaterialRef,
    normalMaterialRef,
    matcapMaterialRef,
    standardMaterialRef,
    physicalMaterialRef,
    depthMaterialRef,
    lambertMaterialRef,
    phongMaterialRef,
    // toonMaterialRef,
]

/**
 * Load textures
 */

//Door Textures
let doorTexture = {}
try {
    doorTexture = await useTexture({
        map: './assets/door/color.jpg',
        roughnessMap: './assets/door/roughness.jpg',
        normalMap: './assets/door/normal.jpg',
        aoMap: './assets/door/ambientOcclusion.jpg',
        metalnessMap: './assets/door/metalness.jpg',
        alphaMap: './assets/door/alpha.jpg',
        displacementMap: './assets/door/height.jpg'
    })
} catch (error) {
    console.log(console.error())
}

//Other Textures
let matcapTexture = {}
try {
    matcapTexture = await useTexture({
        matcap: './assets/matcaps/1.png',
    })
} catch (error) {
    console.log(console.error())
}

/**
 * Animation
 */
const meshGroup = ref(null)
const { onLoop } = useRenderLoop()

onLoop(({ elapsed}) => {
    meshGroup.value.children.forEach(meshGroup => {
        meshGroup.children.forEach((mesh) => {
            mesh.rotation.x  = 0.1 *elapsed
            mesh.rotation.y  = 0.1 *elapsed
        })
    });
})

const {labels} = useControls({
  labels: true,
})

</script>
