<template>
    <Transition
    name="fade-overlay"
    enter-active-class="opacity-1 transition-opacity duration-200"
    leave-active-class="opacity-0 transition-opacity duration-200"
  >
    <div
      v-show="!finished"
      class="absolute bg-slate-900  t-0 l-0 w-full h-full z-20 flex justify-center items-center text-black font-mono"
    >
      <div class="w-200px text-slate-200 text-2xl mb-2 ">
        Loading... {{ progress }} %
        <i class="i-ic-twotone-catching-pokemon animate-rotate-in"></i>
      </div>
      <div 
        ref="loadingBar"
        class="absolute top-[55%] h-1 bg-slate-200 w-full origin-left"
        :class="[
            {
                'scale-x-0':progress === 0
            }
        ]"
      > 
      </div>
    </div>
  </Transition>
</template>
<script setup>
import {gsap} from 'gsap'

const { hasFinishLoading, progress, items } = await useProgress()

const loadingBar = ref(null)
let initialProgress=0
const finished = ref(false)

watchEffect(() =>{
    console.log('progress',progress.value)
    if(loadingBar.value && progress.value !== 0){
        const progressTo = progress.value/100

        gsap.fromTo(loadingBar.value, 
            {
                scaleX: initialProgress
            },
            {
                scaleX: progressTo,
                duration: 0.5
            }
        );

        initialProgress = progressTo
    }

})

watchEffect(() => {
    console.log('finished', hasFinishLoading.value)
    if(hasFinishLoading.value){
        setTimeout(() => {
            finished.value = true
        }, 500);
    }
})

</script>
<style scoped>
.loading-bar{
    position: absolute;
    top: 50%;
    width: 100%;
    height: 2px;
    background-color: white;
    transform:scaleX(0);
    transform-origin: top left;
    transition: transform 0.5s;
    will-change: transform;
}

.loading-bar.ended{
    transform-origin: top right;
    transition: transform 1.5s ease-in-out;
}
</style>