<template>
    <TresMesh>
        <TresBoxGeometry />
        <TresMeshNormalMaterial />
        <Html
            v-for="point in points"
            transform
            occlude
            :distance-factor="20"
            :position="point.position"
            :rotation="point.rotation"
        >
        <div
            class="group flex flex-col items-center"
        >
            <p 
                class="dark:bg-dark text-3xl p-2 rounded-full w-fit"
            >
                {{ point.emoji }}
            </p>
            <p
                class="text-xs w-fit text-center bg-slate-300/70 p-2 rounded-md hidden transition-all ease-in-out duration-200 group-hover:block "
            >
                {{ point.name }} <br/> {{ point.location }}
            </p>
        </div>
        </Html>
    </TresMesh>
</template>
<script setup>

const points = [
    {
        position: [3, 6.5, 6.5],
        rotation: [0, 0,0],
        emoji: '🏛️',
        name: 'Parthenon',
        location: 'Athens, Greece'
    },
    {
        position: [4.5, 6, -5.5],
        rotation:[0, Math.PI * 0.7, 0],
        emoji:'🗼',
        name: 'Tokyo Tower',
        location:'Tokyo, Japan'
    },
    {
        position: [-7.3, 6, 2],
        rotation: [Math.PI * 0.1, -Math.PI * 0.4, 0],
        emoji: '🗽',
        name: 'Statue of Liberty',
        location:'NY, USA'
    }
]
</script>
