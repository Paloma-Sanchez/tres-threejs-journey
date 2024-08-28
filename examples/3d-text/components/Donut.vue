<template>
    <TresMesh
        ref="donut"
        :geometry="geometry"
        :material="material"
        :position="[(Math.random()-0.5)*10, (Math.random()-0.5)*10, (Math.random()-0.5)*10]"
        :rotation="[(Math.random()-0.5)* Math.PI, (Math.random()-0.5)* Math.PI, (Math.random()-0.5)* Math.PI]"
        :scale="[scale, scale, scale]"
    />
</template>
<script setup>

const props = defineProps({
    geometry:{
        required:true
    },
    material:{
        required: true
    }
})

const scale = 0.1 + Math.random() * 0.2
</script>