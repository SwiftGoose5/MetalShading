//
//
//
// Created by Swift Goose.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//


import MetalKit

// Keys for Vertex and Fragment shaders for caching to improve performance
enum VertexShaderTypes {
    case Basic
}

enum FragmentShaderTypes {
    case Basic
}

class ShaderLibrary {
    public static var DefaultLibrary: MTLLibrary!
    
    private static var vertexShaders: [VertexShaderTypes: Shader] = [:]
    private static var fragmentShaders: [FragmentShaderTypes: Shader] = [:]
    
    public static func initialize() {
        DefaultLibrary = Engine.Device.makeDefaultLibrary()
        createDefaultShaders()
    }
    
    public static func createDefaultShaders() {
        // Vertex Shaders
        vertexShaders.updateValue(Basic_VertexShader(), forKey: .Basic)
        
        // Fragment Shaders
        fragmentShaders.updateValue(Basic_FragmentShader(), forKey: .Basic)
    }
    
    public static func Vertex(_ vertexShaderType: VertexShaderTypes) -> MTLFunction {
        return vertexShaders[vertexShaderType]!.function
    }
    
    public static func Fragment(_ fragmentShaderType: FragmentShaderTypes) -> MTLFunction {
        return fragmentShaders[fragmentShaderType]!.function
    }
}

protocol Shader {
    var name: String { get }
    var functionName: String { get }
    var function: MTLFunction! { get }
}

public struct Basic_VertexShader: Shader {
    var name: String = "Basic Vertex Shader"
    var functionName: String = "basic_vertex_shader"
    var function: MTLFunction!
    
    init() {
        function = ShaderLibrary.DefaultLibrary.makeFunction(name: functionName)!
        function.label = name
    }
}

public struct Basic_FragmentShader: Shader {
    var name: String = "Basic Fragment Shader"
    var functionName: String = "basic_fragment_shader"
    var function: MTLFunction!
    
    init() {
        function = ShaderLibrary.DefaultLibrary.makeFunction(name: functionName)!
        function.label = name
    }
}
