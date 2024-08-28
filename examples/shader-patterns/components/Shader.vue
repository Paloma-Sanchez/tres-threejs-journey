
<template>
    <!-- Square Plane Mesh-->
    <TresMesh
        v-if="shaderGeometry"
        :position="[newPositionX, newPositionY, 0]"
        :geometry="shaderGeometry"
    >
        <TresShaderMaterial 
            :vertex-shader="vertexShader" 
            :fragment-shader="fragment"
        />
    </TresMesh>

    <!-- Text -->
    <Suspense>
        <Text3D 
          font="./fonts/OpenSans_Regular.json"
          :size="0.06"
          :position="[newPositionX - 0.08, newPositionY -0.2, -0.145]"
          :material="numberMaterial"
        >
            {{ index + 1 }}
        </Text3D>
      </Suspense>
</template>

<script setup>
import F02 from '../shaders/F02.glsl'
import vertexShader from '../shaders/vertex.glsl'
import { shaderGeometry, numberMaterial } from '../shaders/commun.js'

const props = defineProps({
    fragment:{
        default: F02
    },
    index:{
        type: Number,
        default:0
    },
});

/**
 * Mesh positioning
 * */
//position X
let newPositionX = 0;

if((props.index)%5 === 0){
   newPositionX = -0.7
} else if ((props.index )%5 === 4){
    newPositionX = 0.7
} else if ((props.index )%5 === 3){
    newPositionX = 0.35
}else if ((props.index )%5 === 2){
    newPositionX = 0
} else if ((props.index )%5 === 1){
    newPositionX = -0.35
};

//position Y
let newPositionY = 0;
let rowFound = false;
let row =1;

while(!rowFound){
    if((props.index + 1) <= (5 * row)){
        if(row === 1){
            newPositionY = 0
        } else {
            newPositionY = 0.65 * -(row-1);
        }
        rowFound = true;
    }
    
    row ++;

};


</script>