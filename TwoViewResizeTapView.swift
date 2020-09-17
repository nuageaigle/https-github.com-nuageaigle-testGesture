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
                Text("y a quelque chose dans son regard")
                Text("non jamais je ne serais faits")
            }
            
            Group {
                Text("mimim ")
                Text("il usion")
            }
            
            
            Group {
                Text("d'un peu fragile et de legere")
            Text("1")
            Text("2")
            Text("3")
                Text("toi mon ami aux yeux de soire")
                Text("tu as souri mais hier je ne savais pas")
                Text("elle me regard, je le sens bien")
                Text("")
                Text("comme un oisor")
                Text("")
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
