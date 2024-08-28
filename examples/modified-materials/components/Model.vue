<template>
    <TresMesh
        cast-shadow
        :geometry="modelNodes.LeePerrySmith.geometry"
        :customDepthMaterial="depthMaterial"
        :position="position"
        :scale="[0.5, 0.5, 0.5]"
    >
        <TresMeshStandardMaterial
            ref="materialRef"
            :map="LPSTextures.map"
            :normalMap="LPSTextures.normalMap"
        />

    </TresMesh>
</template>

<script setup>
    import {useTexture} from '@tresjs/core'
    import {depthMaterial, twist} from '../utils/utils.js'    

    const materialRef = ref()

    const props = defineProps({
        position:{
            type: Array,
            default: [0,0,0]
        },
    })

    const customUniforms={
        uTime: {value:0}
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
        console.log('nodes', modelNodes)
    } catch (e){
        console.log(e)
    }

    //twist model and shadow
    onMounted(() => {
        const material =  materialRef.value

        if(material){
            twist(material, customUniforms)  
        }
    })

    //animation
    const { onLoop } = useRenderLoop()

    onLoop(({ delta, elapsed, clock }) => {
        customUniforms.uTime.value = elapsed
    })


</script>