<template>
    <TresMesh
        cast-shadow
        :geometry="modelNodes.LeePerrySmith.geometry"
        :customDepthMaterial="depthMaterial"
        :position="position"
        :scale="[0.5, 0.5, 0.5]"
        :rotation-y="Math.PI "
    >
        <MeshWobbleMaterial
            ref="wobbleMaterialRef"
            :map="LPSTextures.map"
            :normalMap="LPSTextures.normalMap"
            :speed="1"
            :factor="2"
        />
    </TresMesh>
</template>

<script setup>
    import {useTexture} from '@tresjs/core'
    import {depthMaterial, wobble} from '../utils/utils.js'    

    const wobbleMaterialRef = ref() 

    const props = defineProps({
        position:{
            type:Array,
            default: [-10,0,0]
        },

    })

    const customUniforms={
        uTime: {value:0},
        uFactor: {value:2}
    }

    /**
     * Lee Perry Smithtextures
     **/
    let LPSTextures = {}
    try{
        LPSTextures = await useTexture({
            map: './models/LeePerrySmith/color.jpg',
            normalMap: './models/LeePerrySmith/normal.jpg',
        })
    } catch(e){
        console.log(e)
    }

    /**
     * Lee Perry Smith model
     **/
    let modelNodes= null
    try{
        const gltf = await useGLTF('./models/LeePerrySmith/LeePerrySmith.glb', {draco:true})
        modelNodes = gltf.nodes
    } catch (e){
        console.log(e)
    }

    //twist model and shadow
    onMounted(() => {
        const material = wobbleMaterialRef.value

        if(material){
            wobble(material, customUniforms) 
        }
    })

    //animation
    const { onLoop } = useRenderLoop()

    onLoop(({ delta, elapsed}) => {
        customUniforms.uTime.value = elapsed
    })


</script>