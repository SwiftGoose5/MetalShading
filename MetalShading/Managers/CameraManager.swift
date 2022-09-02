//
//
//
// Created by Swift Goose.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//

// Strategy Pattern - updates at runtime instead of compile time
class CameraManager {
    
    private var _cameras: [CameraTypes : Camera] = [:]
    
    public var currentCamera: Camera!
    
    public func registerCamera(camera: Camera){
        self._cameras.updateValue(camera, forKey: camera.cameraType)
    }
    
    public func setCamera(_ cameraType: CameraTypes){
        self.currentCamera = _cameras[cameraType]
    }
    
    internal func update(deltaTime: Float){
        for camera in _cameras.values {
            camera.update(deltaTime: deltaTime)
        }
    }
    
}
