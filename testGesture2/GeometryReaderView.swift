//
//  GeometryReaderView.swift
//  testGesture2
//
//  Created by aigle nuage on 2020/9/21.
//  Copyright © 2020 aigle nuage. All rights reserved.
//

import SwiftUI

struct GeometryReaderView: View {
    var body: some View {
        VStack {
            GeoInfoView()
            
            Divider()
            
            ExampleView()
            
            Divider()
            
            Image(systemName: "command")
                .resizable()
                .scaledToFit()
                .foregroundColor(.pink)
                .frame(width: 200)
                .overlay(
                    GeometryReader {  geometry in
                        Text(geometry.frame(in: .global).debugDescription)
                            .background(Color.yellow)
                        
                    }
                    , alignment: .bottomTrailing
                )
        }
    }
}

struct GeoInfoView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.green)
                        .frame(width: 50, height: 50)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.red)
                        .frame(width: 50, height: 50)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.purple)
                        .frame(width: 50, height: 50)
                    
                }
                
                GeometryReader { geometry in
                    VStack {
                        // 尺寸
                        Text("Geometry width: \(geometry.size.width)")
                        Text("Geometry height: \(geometry.size.height)")
                        
                        // 坐标
                        Text("Geometry X: \(geometry.frame(in: .global).origin.x)")
                        Text("Geometry Y: \(geometry.frame(in: .global).origin.y)")
                        Text("Geometry minX: \(geometry.frame(in: .global).minX)")
                        Text("Geometry maxX: \(geometry.frame(in: .global).maxX)")
                        
                        // 安全区域
                        Text("Geometry safeAreaInsets.bottom: \(geometry.safeAreaInsets.bottom)")
                        Text("Geometry safeAreaInsets.top: \(geometry.safeAreaInsets.top)")
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ExampleView: View {
    @State private var width: CGFloat = 50
    
    var body: some View {
        VStack {
            SubView()
                .frame(width: self.width, height: 120)
                .border(Color.blue, width: 2)
            
            Text("Offered Width \(Int(width))")
            Slider(value: $width, in: 0...200, step: 1)
        }
    }
}

struct SubView: View {
    var body: some View {
        GeometryReader { proxy in
            //Rectangle()
            Text("la reine des neiges")
                //.fill(Color.yellow.opacity(0.7))
                .frame(width: max(proxy.size.width, 120), height: max(proxy.size.height, 120))
        }
    }
}

struct GeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
    }
}
