//
//  ColorISystemView.swift
//  testGesture2
//
//  Created by aigle nuage on 2020/9/21.
//  Copyright © 2020 aigle nuage. All rights reserved.
//

import SwiftUI

struct ColorISystemView: View {
    @State var isToggleOn = false
    
    var body: some View {
        ZStack (alignment: .top) {
            //Rectangle() // background
            //.foregroundColor(Color.white)
            
            VStack {
                Text("la rein des neiges")
                    .font(Font.system(size: 32))
                    .foregroundColor(.primary)
                Text("la rein des neiges")
                    .font(Font.system(size: 32))
                    .foregroundColor(.secondary)
                
                
                ContentViewCC()
                
            }
        }
    }
}

struct ContentViewCC: View {
    @State var preferredColorScheme: ColorScheme? = nil

    var body: some View {
        List {
                Button(action: {
                preferredColorScheme = .light
            }) {
                HStack {
                    Text("Light")
                    Spacer()
                    if preferredColorScheme == .light {
                        selectedImage
                    }
                }
            }

            Button(action: {
                preferredColorScheme = .dark
            }) {
                HStack {
                    Text("Dark")
                    Spacer()
                    if preferredColorScheme == .dark {
                        selectedImage
                    }
                }
            }
        }
        //.listStyle(ListStyle)
        .preferredColorScheme(preferredColorScheme)
        .navigationBarTitle("ColorScheme Test")
    }

    var selectedImage: some View {
        Image(systemName: "checkmark")
            .foregroundColor(.blue)
    }
}

struct ColorISystemView_Previews: PreviewProvider {
    static var previews: some View {
        ColorISystemView()
    }
}
