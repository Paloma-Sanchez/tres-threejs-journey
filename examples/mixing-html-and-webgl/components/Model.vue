<!-- "Earth" (https://skfb.ly/6YERJ) by BamPistache is licensed under Creative Commons Attribution-NonCommercial (http://creativecommons.org/licenses/by-nc/4.0/). -->
<template>
    <TresGroup>
        <TresMesh
            :geometry="nodes.earth4.children[0].geometry"
        >
            <TresMeshStandardMaterial
                :map="earthTextures[0]"
                :metalnessMap="earthTextures[1]"
                :roughnessMap="earthTextures[1]"
            />
        </TresMesh>    
        <TresMesh
            :geometry="nodes.earth4.children[1].geometry"
        >
            <TresMeshStandardMaterial
                :map="earthTextures[2]"
                :metalnessMap="earthTextures[3]"
                :roughnessMap="earthTextures[3]"
            />
        </TresMesh>        

    </TresGroup>

</template>
<script setup>

    const {nodes}= await useGLTF('./models/earth/scene.gltf', { draco: true })

    const earthTextures =  await useTexture([
        './models/earth/textures/blinn1_baseColor.png',
        './models/earth/textures/blinn1_metallicRoughness.png',
        './models/earth/textures/lambert1_baseColor.png',
        './models/earth/textures/lambert1_metallicRoughness.png',
    ])

</script>