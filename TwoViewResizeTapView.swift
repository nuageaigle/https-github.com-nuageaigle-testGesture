//
//  TwoViewResizeTapView.swift
//  testGesture2
//
//  Created by aigle nuage on 2020/9/14.
//  Copyright © 2020 aigle nuage. All rights reserved.
//

import SwiftUI

//let bandKeyboard : CGFloat = 500
let KeyboardHPercent : CGFloat = 0.4


struct TwoViewResizeTapView: View {
    
    @State var keyboardFull : Bool = true
    
    var ListHeight : CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack (alignment: .top) {
            Rectangle() // background
                .foregroundColor(Color.white)
                
            ListView()
                .frame(height: self.keyboardFull ? geo.size.height * ( 1 -  KeyboardHPercent) - 50 : geo.size.height - 80 )
                //.border(Color.green, width: 6)
                //.position(x: 0, y: 0)
                .offset(x: 0, y: 30)
                
                /*
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 200)
                    .border(Color.green, width: 6)*/
                
                
            keyboardView() //  keyboard
                .frame(height: geo.size.height * KeyboardHPercent)
                //.frame(height: geo.size.height * KeyboardHPercent)
                .position(x: geo.size.width / 2, y: self.keyboardFull ? geo.size.height * ( 1 - KeyboardHPercent) : geo.size.height - 30 )
                .offset(x: 0, y: geo.size.height * KeyboardHPercent / 2)
                
                
                
            Rectangle() // tap bar
                .frame(height: 20)
                .position(x: geo.size.width / 2, y: self.keyboardFull ? geo.size.height * ( 1 - KeyboardHPercent) : geo.size.height - 30 )
                //.offset(x: 0, y: self.keyboardFull ? 0 : 100)
                .foregroundColor(Color.gray)
                .offset(x: 0, y: -10)
                .onTapGesture {
                    self.keyboardFull.toggle()
                }
                
            Text("la reine des neiges")
            }
            
            
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct ListView: View {

    var body: some View {
        ScrollView {
        VStack (alignment: .leading) {
            Group {
                Text("+     35")
                Text("+     22")
            }
            
            Group {
                Text("+     57")
                Text("+    218")
            }
            
            
            Group {
                Text("+     11")
                Text("+    188")
                Text("+     77")
                Text("+     2x5")
                Text("+     17 x 2")
                Text("+     65")
                Text("+     90")
                Text("+     71")
                Text("+     65")
                Text("+     88")
            }
            
        }
        //.border(Color.black)
        .font(.largeTitle)
        }
        
    }
}

struct TwoViewResizeTapView_Previews: PreviewProvider {
    static var previews: some View {
        TwoViewResizeTapView()
    }
}
