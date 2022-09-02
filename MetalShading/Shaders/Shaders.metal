//
//
//
// Created by Swift Goose on 6/23/22.
// Copyright (c) 2022 Swift Goose. All rights reserved.
//
// YouTube: https://www.youtube.com/channel/UCeHYBwcVqOoyyNHiAf3ZrLg
//


#include <metal_stdlib>
using namespace metal;


struct VertexIn {
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
};

// Data object gets sent off to the rasterizer
struct RasterizerData {
    float4 position [[ position ]];
    float4 color;
};

struct SceneConstants {
    float4x4 viewMatrix;
};

struct ModelConstants {
    float4x4 modelMatrix;
};

// MARK: - Main goal is to process Vertex data and map them to a position on the screen

// device: we can read/write
// const: only read
// buffer(0): the index we set
// vertex_id: the id of the vertex

vertex float4 older_basic_vertex_shader(device VertexIn *vertices [[ buffer(0) ]], uint vertexID [[ vertex_id ]]) {
    return float4(vertices[vertexID].position, 1);
}

vertex RasterizerData old_basic_vertex_shader(device VertexIn *vertices [[ buffer(0) ]], uint vertexID [[ vertex_id ]]) {
    RasterizerData rd;
    
    rd.position = float4(vertices[vertexID].position, 1);
    rd.color = vertices[vertexID].color;
    
    return rd;
}

vertex RasterizerData basic_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    
    // the order of multiplication matters: matrix * position
//    rd.position = modelConstants.modelMatrix * float4(vIn.position, 1);
    rd.position = sceneConstants.viewMatrix * modelConstants.modelMatrix * float4(vIn.position, 1);
    rd.color = vIn.color;
    
    return rd;
}

// Data comes out of the rasterizer, goes into the fragment shader
// [[ stage_in ]] attribute qualiflier specifies per pixel
fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]]) {
    float4 color = rd.color;
    
    return half4(color.r, color.g, color.b, color.a);
}
