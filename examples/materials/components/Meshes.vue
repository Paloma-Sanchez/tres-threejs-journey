<template>
    <TresGroup
        v-if="material"
        :position="position"
    >
        <Html
            v-if="labels"
            :position="[-5.5, 0.2, 0]"
        >
            <h1
                class="bg-white p-2 px-4 rounded-full"
            >
                {{props.material.value.type}}
            </h1>
        </Html>
        <TresMesh
            :geometry="sphereGeometry"
            :material="material.value"
            :position="[-1.5, 0, 0]"
        >

        </TresMesh>

        <TresMesh
            :geometry="torusGeometry"
            :material="material.value"
            :position="[1.5, 0, 0]"
        />

        <TresMesh
            :geometry="planeGeometry"
            :material="material.value"
        />
    </TresGroup>
</template>
<script setup>
import { Html } from '@tresjs/cientos'

const props = defineProps({
    sphereGeometry:{
        required:true
    },
    torusGeometry:{
        required:true
    },
    planeGeometry:{
        required:true
    },
    material:{
        required:true
    },
    position:{
        default:[0, 0, 0]
    },
    labels: {
        type: Boolean,
        default: true
    }
})



</script>