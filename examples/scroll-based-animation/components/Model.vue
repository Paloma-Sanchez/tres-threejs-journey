<template>
    <TresGroup>

        <Superformula
            ref="superFormulaRef"
            :num-arms-b="24"
            :exp-b="[40, 30, 20]"
            :position="[2, 1, 0]"
            :scale="[1.5, 1.5, 1.5]"
        >
            <TresMeshNormalMaterial />
        </Superformula>

        <TorusKnot 
            ref="torusKnotRef"
            :args="[1, 0.5, 128, 128]"
            :position="[-4, -12, 0]"
        >
            <TresMeshNormalMaterial/>
        </TorusKnot>

        <RoundedBox
            ref="roundedBoxRef"
            :args="[3, 3, 3]"
            :position="[1, -25, 0]"
        >
            <TresMeshNormalMaterial />
        </RoundedBox>

        <TresPoints
        />
    </TresGroup>
</template>
<script setup>
import {gsap} from 'gsap'

//Permanent animation
const superFormulaRef = ref(null)
const torusKnotRef = ref(null)
const roundedBoxRef = ref(null)

const randomRotation = {
    x:(Math.random() - 0.5) * 0.6,
    y:(Math.random() - 0.5) * 0.6,
    z:(Math.random() - 0.5) * 0.6,
}

const { onLoop } = useRenderLoop()

onLoop(({delta}) => {
    if(superFormulaRef.value){
        superFormulaRef.value.instance.rotation.x += delta * randomRotation.x
        superFormulaRef.value.instance.rotation.y += delta * randomRotation.y
        superFormulaRef.value.instance.rotation.z += delta * randomRotation.z
    }
    if(torusKnotRef.value){
        torusKnotRef.value.instance.rotation.x += delta * randomRotation.x
        torusKnotRef.value.instance.rotation.y += delta * randomRotation.y
        torusKnotRef.value.instance.rotation.z += delta * randomRotation.z
    }
    if(roundedBoxRef.value){
        roundedBoxRef.value.instance.rotation.x += delta * randomRotation.x
        roundedBoxRef.value.instance.rotation.y += delta * randomRotation.y
        roundedBoxRef.value.instance.rotation.z += delta * randomRotation.z
    }
})

//Scroll animation
const{sizes} = useTresContext()

let scrollY = window.scrollY;

let currentSection = 0;

window.addEventListener('scroll', (scrollValue) => {
    scrollY = window.scrollY;

    const newSection = Math.round(scrollY/(sizes.height.value ))
    if(newSection !== currentSection) {
        currentSection =newSection;

        if(newSection === 0){
    
            gsap.to(superFormulaRef.value.instance.rotation, {
                duration:1.5,
                ease: 'power2.inOut',
                x: '+=6',
                y: '+=3',
                z: '+=1.5'
            })
        } else if(newSection === 1){
            gsap.to(torusKnotRef.value.instance.rotation, {
                duration:1.5,
                ease: 'power2.inOut',
                x: '+=3',
                y: '+=6',
                z: '+=1.5'
            })
        } else if(newSection === 2){
            gsap.to(roundedBoxRef.value.instance.rotation, {
                duration:1.5,
                ease: 'power2.inOut',
                x: '+=1.5',
                y: '+=3',
                z: '+=6'
            })
        }
    }

});

</script>