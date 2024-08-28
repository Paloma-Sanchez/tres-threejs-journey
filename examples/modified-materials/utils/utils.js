import * as THREE from 'three'

export const depthMaterial = new THREE.MeshDepthMaterial({
    depthPacking: THREE.RGBADepthPacking
})



export const updateAllMaterials = (scene) =>{
        scene.value.traverse((child) =>
        {
            console.log('isMesh', child instanceof THREE.Mesh)
            console.log('isStandardMaterial', child.material instanceof THREE.MeshStandardMaterial)
            console.log(child.material)

            if(child instanceof THREE.Mesh && child.material instanceof THREE.MeshStandardMaterial)
            {
                child.material.envMapIntensity = 1
                child.material.needsUpdate = true
                child.castShadow = true
                child.receiveShadow = true
            }
        })
}

export const twist = (material , customUniforms ) =>{

    material.onBeforeCompile = (shader) => {
        shader.uniforms.uTime = customUniforms.uTime
        
        //global
        shader.vertexShader = shader.vertexShader.replace(
            '#include <common>',
            `
                #include <common>
    
                uniform float uTime;
    
                mat2 get2dRotateMatrix(float _angle){
                    return mat2(cos(_angle), - sin(_angle), sin(_angle), cos(_angle));
                }
            `
        )
        //core shade
        
        shader.vertexShader = shader.vertexShader.replace(
            '#include <beginnormal_vertex>', 
            `
                #include <beginnormal_vertex>
        
                float angle = (position.y + uTime)* 0.9;
        
                mat2 rotateMatrix = get2dRotateMatrix(angle);
 
                objectNormal.xz = rotateMatrix * objectNormal.xz;
            `
        )

        //material
        shader.vertexShader = shader.vertexShader.replace(
            '#include <begin_vertex>', 
            `
                #include <begin_vertex>
    
                // float angle = (position.y + uTime)* 0.9;
    
                //  mat2 rotateMatrix = get2dRotateMatrix(angle);
    
                transformed.xz = rotateMatrix * transformed.xz;
            `
        )
    }

    depthMaterial.onBeforeCompile = (shader) =>{
        shader.uniforms.uTime = customUniforms.uTime

        shader.vertexShader = shader.vertexShader.replace(
            '#include <common>',
            `
                #include <common>

                uniform float uTime;

                mat2 get2dRotateMatrix(float _angle){
                    return mat2(cos(_angle), - sin(_angle), sin(_angle), cos(_angle));
                }
            `
        )
        shader.vertexShader = shader.vertexShader.replace(
            '#include <begin_vertex>', 
            `
                #include <begin_vertex>

                float angle = (position.y + uTime)* 0.9;

                mat2 rotateMatrix = get2dRotateMatrix(angle);

                transformed.xz = rotateMatrix * transformed.xz;
            `
        )
    }
}

export const wobble = (material , customUniforms ) =>{

    material.onBeforeCompile = (shader) => {
        shader.uniforms.uTime = customUniforms.uTime
        
        //global
        shader.vertexShader = shader.vertexShader.replace(
            '#include <common>',
            `
                #include <common>
    
                uniform float uTime;
    
                mat2 get2dRotateMatrix(float _angle){
                    return mat2(cos(_angle), - sin(_angle), sin(_angle), cos(_angle));
                }
            `
        )
        //core shade
        
        shader.vertexShader = shader.vertexShader.replace(
            '#include <beginnormal_vertex>', 
            `
                #include <beginnormal_vertex>
        
                float angle = (position.y + uTime)* 0.9;
        
                mat2 rotateMatrix = get2dRotateMatrix(angle);
 
                objectNormal.xz = rotateMatrix * objectNormal.xz;
            `
        )

        //material
        shader.vertexShader = shader.vertexShader.replace(
            '#include <begin_vertex>', 
            `
                #include <begin_vertex>
    
                // float angle = (position.y + uTime)* 0.9;
    
                //  mat2 rotateMatrix = get2dRotateMatrix(angle);
    
                transformed.xz = rotateMatrix * transformed.xz;
            `
        )
    }

    depthMaterial.onBeforeCompile = (shader) =>{
        shader.uniforms.uTime = customUniforms.uTime
        shader.uniforms.uFactor= customUniforms.uFactor
    
        shader.vertexShader = `
            uniform float uTime;
            uniform float uFactor;
            ${shader.vertexShader}
        `
        shader.vertexShader = shader.vertexShader.replace(
            '#include <begin_vertex>',
            `
                float theta = sin( uTime + position.y ) / 2.0 * uFactor;
                float c = cos( theta );
                float s = sin( theta );
                mat3 m = mat3( c, 0, s, 0, 1, 0, -s, 0, c );
                vec3 transformed = vec3( position ) * m;
                // vNormal = vNormal * m;
            `
        )  
    }
}

