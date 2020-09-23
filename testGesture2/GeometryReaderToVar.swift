//
//  GeometryReaderToVar.swift
//  testGesture2
//
//  Created by aigle nuage on 2020/9/23.
//  Copyright © 2020 aigle nuage. All rights reserved.
//

import SwiftUI

private var mmmSize = CGSize(width: 50, height: 0)

struct GeometryReaderToVar: View {
    var body: some View {
        GeometryToVar()
    }
}

struct GeometryToVar: View {
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
                }
            }
        
    }
}

struct GeometryReaderToVar_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderToVar()
    }
}
