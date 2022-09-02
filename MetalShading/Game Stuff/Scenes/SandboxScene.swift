//
//
//
// Created by Swift Goose.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//


import MetalKit

class SandboxScene: Scene {
    var debugCamera = DebugCamera()
    
    override func buildScene() {
        
        addCamera(debugCamera)
        
        let count = 5
        
        for y in -count ..< count {
            for x in -count ..< count {
                let pointer = Pointer()
                pointer.position.y = Float(Float(y) + 0.5) / Float(count)
                pointer.position.x = Float(Float(x) + 0.5) / Float(count)
                pointer.scale = SIMD3<Float>(repeating: 0.1)
                addChild(pointer)
            }
        }
    }
    
//    override func update(deltaTime: Float) {
//        
////        print(Mouse.GetMouseWindowPosition())
////        print(Mouse.GetMouseViewportPosition())
//        
//        super.update(deltaTime: deltaTime)
//    }
}
