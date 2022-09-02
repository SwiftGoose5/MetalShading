//
//
//
// Created by Swift Goose.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//


import MetalKit

class Engine {
    public static var Device: MTLDevice!
    public static var CommandQueue: MTLCommandQueue!
    
    public static func Ignite(device: MTLDevice) {
        self.Device = device
        self.CommandQueue = device.makeCommandQueue()
        
        ShaderLibrary.initialize()
        
        VertexDescriptorLibrary.initialize()
        
        RenderPipelineDescriptorLibrary.initialize()
        
        RenderPipelineStateLibrary.initialize()
        
        MeshLibrary.initialize()
        
        SceneManager.initialize(Preferences.StartingSceneType)
    }
}
