//
//
//
// Created by Swift Goose.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//


import MetalKit

class Renderer: NSObject {
    public static var ScreenSize: SIMD2<Float> = SIMD2<Float>(repeating: 0)
    
    init(_ mtkView: MTKView) {
        super.init()
        updateScreenSize(view: mtkView)
    }
}

extension Renderer: MTKViewDelegate {
    
    public func updateScreenSize(view: MTKView) {
        Renderer.ScreenSize = SIMD2<Float>(Float(view.bounds.width), Float(view.bounds.height))
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // Called when the window is resized
        updateScreenSize(view: view)
    }
    
    // Called 60 times per second
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        // Command Buffers are objects we push into the Command Queue for execution
//        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        
        // Command Encoder tells our buffer what to do when it is committed, depending on type:
        // 1. Render Command Encoder - render graphics
        // 2. Compute Command Encoder - computational tasks, no graphics, things you want to multithread
        // 3. Blit Command Encoder - memory management tasks
        // 4. Parallel Command Encoder - multiple graphics rendering tasks
        
        // Example:
        // Command Buffer 1 - Compute - computes texture information to be used on a model
        // Command Buffer 2 - Render  - uses the info from CB1 to render a texture
        
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        // Tick and update the scene 60 times per second
        SceneManager.TickScene(renderCommandEncoder: renderCommandEncoder!, deltaTime: 1 / Float(view.preferredFramesPerSecond))
        
        // Now set the Render Pipeline State
        // Render Pipeline State containts a Render Pipeline Descriptor
        // Inside Render Pipeline Descriptor there is:
        //      1. Color Attachments - pixel formats
        //          1a. ColorAttachment format at pixel [0] needs to match the NSView's format - .bgra8Unorm
        //      2. Vertex Function - made by MTL Library, exist in a MTL file
        //      3. Fragment Function - made by MTL Library, exist in a MTL file
        //
        // See createRenderPipelineState()
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
    
}
