//
//
//
// Created by Swift Goose.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//


import MetalKit

enum SceneTypes {
    case Sandbox
}

class SceneManager {
    private static var _currentScene: Scene!
    
    public static func initialize(_ sceneType: SceneTypes) {
        SetScene(sceneType)
    }
    
    public static func SetScene(_ sceneType: SceneTypes) {
        switch sceneType {
        case .Sandbox:
            _currentScene = SandboxScene()
        }
    }
    
    public static func TickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        
        _currentScene.updateCameras(deltaTime: deltaTime)
        
        _currentScene.update(deltaTime: deltaTime)
        
        _currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
}
