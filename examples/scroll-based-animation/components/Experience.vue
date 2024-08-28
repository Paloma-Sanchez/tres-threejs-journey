<template>

    <TresCanvas
        window-size
        clear-color="#ffffff"
        :alphe="true"

    >
        <TresPerspectiveCamera
            :position="[0, 0, 7.5]"
            :fov="75"
        />

        <MouseParallax
            :factor="1"
            :ease="5"
        />

        <ScrollControls
            :distance="20"
            :smooth-scroll="0.2"
            html-scroll
        />

        <Model/>

        <Suspense>
            <ModelParticles/>
        </Suspense>

    </TresCanvas>

    <HtmlPage/>
</template>
<script setup>

</script>
<style>
body{
    height: 300vh;
}
</style>