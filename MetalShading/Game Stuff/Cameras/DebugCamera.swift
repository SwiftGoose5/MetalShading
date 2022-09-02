//
//
//
// Created by Swift Goose.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//


import simd

class DebugCamera: Camera {
    var cameraType: CameraTypes = .Debug
    
    var position: SIMD3<Float> = SIMD3<Float>(repeating: 0)
    
    func update(deltaTime: Float) {
        if (Keyboard.IsKeyPressed(.leftArrow)) {
            self.position.x -= deltaTime
        }
        
        if (Keyboard.IsKeyPressed(.rightArrow)) {
            self.position.x += deltaTime
        }
        
        if (Keyboard.IsKeyPressed(.upArrow)) {
            self.position.y += deltaTime
        }
        
        if (Keyboard.IsKeyPressed(.downArrow)) {
            self.position.y -= deltaTime
        }
    }
}
