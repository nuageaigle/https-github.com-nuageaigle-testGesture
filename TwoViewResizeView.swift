//
//  TwoViewResizeView.swift
//  testGesture2
//
//  Created by aigle nuage on 2020/9/10.
//  Copyright © 2020 aigle nuage. All rights reserved.
//

import SwiftUI

struct TwoViewResizeView: View {
    
    let bandY : CGFloat = 500
    let bandH : CGFloat = 30

    
    @State private var dragOffset: CGSize = .zero
    @State private var doneOffset: CGSize = .zero
    var totalOffsetHeight : CGFloat
    {
        return dragOffset.height + doneOffset.height
    }

    var body: some View {
        GeometryReader { geo in
            
        ZStack {
            VStack (spacing: 0) {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(height: self.bandY + self.totalOffsetHeight)
                    
                Rectangle()
                    
                //.foregroundColor(.green)
                    .frame(height: geo.size.height - (self.bandY + self.totalOffsetHeight))
            }
            
            keyboardView()
            .frame(width: geo.size.width, height: 400)
            .position(x: ( geo.size.width / 2 ), y: self.bandY + 200)
            .offset(x: self.dragOffset.width, y: self.totalOffsetHeight)
            
            Text("Hello, World!")
                .frame(width: geo.size.width, height: self.bandH)
                .border(Color.red)
                .position(x: ( geo.size.width / 2 ), y: self.bandY)
                
                .offset(x: self.dragOffset.width, y: self.totalOffsetHeight)
                .gesture(
                    DragGesture()
                        .onChanged {
                            self.dragOffset.height = $0.translation.height
                            //self.dragOffset.width = 0
                    }
                        .onEnded {
                            if $0.translation.height + self.doneOffset.height < -200 {
                                self.doneOffset = .init(width: 0, height: -200)
                            } else if $0.translation.height + self.doneOffset.height > 200 {
                                self.doneOffset = .init(width: 0, height: 200)
                            } else {
                                self.doneOffset.height += $0.translation.height
                            }
                            
                            self.dragOffset = .zero
                        }
                    )
            
           }

        }
    }
}

struct keyboardView : View {
    
    var body: some View {
        VStack (spacing: 10) {
            HStack (spacing: 10) {
                Circle()
                    .fill(Color.gray)
                    .overlay(Text("7").font(.largeTitle).foregroundColor(Color.white))
                
                Circle()
                    .fill(Color.gray)
                    .overlay(Text("8").foregroundColor(Color.white))
                Circle()
                .fill(Color.gray)
                .overlay(Text("9").foregroundColor(Color.white))
                Circle()
                .fill(Color.orange)
                .overlay(Text("X").foregroundColor(Color.white))
                
            }
            .frame(maxHeight: .infinity)
            
            HStack (spacing: 10) {
                Circle()
                    .fill(Color.gray)
                    .overlay(Text("4").foregroundColor(Color.white))
                
                Circle()
                    .fill(Color.gray)
                    .overlay(Text("5").foregroundColor(Color.white))
                Circle()
                .fill(Color.gray)
                .overlay(Text("6").foregroundColor(Color.white))
                Circle()
                .fill(Color.orange)
                .overlay(Text("-").foregroundColor(Color.white))
                
            }
            .frame(maxHeight: .infinity)
            
            
            HStack (spacing: 10) {
                Circle()
                    .fill(Color.gray)
                    .overlay(Text("1").foregroundColor(Color.white))
                
                Circle()
                    .fill(Color.gray)
                    .overlay(Text("2").foregroundColor(Color.white))
                Circle()
                .fill(Color.gray)
                .overlay(Text("3").foregroundColor(Color.white))
                Circle()
                .fill(Color.orange)
                .overlay(Text("+").foregroundColor(Color.white))
                
            }
            .frame(maxHeight: .infinity)
            
            
            HStack (spacing: 10) {
                Capsule()
                //Circle()
                    .fill(Color.gray)
                    .overlay(Text("0").foregroundColor(Color.white))
                
                
                HStack (spacing: 10) {
                Circle()
                .fill(Color.gray)
                .overlay(Text(".").foregroundColor(Color.white))
                Circle()
                .fill(Color.orange)
                .overlay(Text("=").foregroundColor(Color.white))
                }
                
            }
            .frame(maxHeight: .infinity)
        }
    }
    
}

struct TwoViewResizeView_Previews: PreviewProvider {
    static var previews: some View {
        TwoViewResizeView()
    }
}
