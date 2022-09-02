//
//
//
// Created by Swift Goose on 6/23/22.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//


import MetalKit

class GameView: MTKView {
    
    var renderer: Renderer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        // Device is abstract representation of the GPU
        // Object created once and never reinitialized
        self.device = MTLCreateSystemDefaultDevice()
        
        Engine.Ignite(device: device!)
        
        // Set the clear color that is covering the last image that was showing
        self.clearColor = Preferences.ClearColor
        
        // Set pixel format to match the output of our fragment shader
        self.colorPixelFormat = Preferences.MainPixelFormat
        
        self.renderer = Renderer(self)
        
        // Delegate all of the draw functionality into the Renderer class
        self.delegate = renderer
    }

}

// MARK: - Keyboard Input

extension GameView {
    // Allows view to accept key input
    override var acceptsFirstResponder: Bool { return true }
    
    override func keyDown(with event: NSEvent) {
        Keyboard.SetKeyPressed(event.keyCode, isOn: true)
    }
    
    override func keyUp(with event: NSEvent) {
        Keyboard.SetKeyPressed(event.keyCode, isOn: false)
    }
}


// MARK: - Mouse Input

extension GameView {
    override func mouseDown(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    override func mouseUp(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    override func rightMouseDown(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    override func rightMouseUp(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    override func otherMouseDown(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    override func otherMouseUp(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
}


// MARK: - Mouse Moved

extension GameView {
    override func mouseMoved(with event: NSEvent) {
         setMousePositionChanged(event: event)
    }
    
    override func scrollWheel(with event: NSEvent) {
         Mouse.ScrollMouse(deltaY: Float(event.deltaY))
    }
    
    override func mouseDragged(with event: NSEvent) {
         setMousePositionChanged(event: event)
    }
    
    override func rightMouseDragged(with event: NSEvent) {
         setMousePositionChanged(event: event)
    }
    
    override func otherMouseDragged(with event: NSEvent) {
         setMousePositionChanged(event: event)
    }
    
    private func setMousePositionChanged(event: NSEvent){
         let overallLocation = SIMD2<Float>(Float(event.locationInWindow.x), Float(event.locationInWindow.y))
         let deltaChange = SIMD2<Float>(Float(event.deltaX), Float(event.deltaY))
        
         Mouse.SetMousePositionChange(overallPosition: overallLocation,
                                      deltaPosition: deltaChange)
    }
    
    // Called every time the screen is initialized or resized
    override func updateTrackingAreas() {
         let area = NSTrackingArea(rect: self.bounds,
                                   options: [NSTrackingArea.Options.activeAlways,
                                             NSTrackingArea.Options.mouseMoved,
                                             NSTrackingArea.Options.enabledDuringMouseDrag],
                                   owner: self,
                                   userInfo: nil)
         self.addTrackingArea(area)
    }
    
}
