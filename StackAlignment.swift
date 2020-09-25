//
//  StackAlignment.swift
//  testGesture2
//
//  Created by aigle nuage on 2020/9/25.
//  Copyright © 2020 aigle nuage. All rights reserved.
//

import SwiftUI
private var mmmSize = CGSize(width: 50, height: 0)

struct StackAlignment: View {
    var body: some View {
        GeometryToVarStackSlign()
    }
}

struct GeometryToVarStackSlign: View {
    var gW : CGFloat {
        mmmSize.width / 2
    }
    
    private func getSize(metrics: GeometryProxy) -> some View {
        mmmSize = metrics.size
        return EmptyView()
    }
    
    var body: some View {

            GeometryReader { geo in
                ZStack(alignment: .center) {
                    getSize(metrics: geo)
                    Rectangle()
                        .fill(Color.clear)
                    
                    Text(" \(mmmSize.width) x \(mmmSize.height) \n \(gW)")
                    Text("top leading").frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 200, alignment: .topLeading)
                    // Text alignt to it self fram
                    // and frame alignt on .center
                    
                    Text("bottom traling").frame(width: geo.size.width, height: geo.size.height, alignment: .bottomTrailing)
                    // Text alignt to it self fram
                    
                }
            }
        
    }
}

struct StackAlignment_Previews: PreviewProvider {
    static var previews: some View {
        StackAlignment()
    }
}
