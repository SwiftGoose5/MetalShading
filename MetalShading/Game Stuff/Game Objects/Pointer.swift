//
//
//
// Created by Swift Goose.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//


import MetalKit

class Pointer: GameObject {
    init() {
        super.init(meshType: .Triangle_Custom)
    }
    
    // Player to follow mouse position
    override func update(deltaTime: Float) {
        
        self.rotation.z = -atan2f(Mouse.GetMouseViewportPosition().x - position.x,
                                  Mouse.GetMouseViewportPosition().y - position.y)
        
        super.update(deltaTime: deltaTime)
    }
}
