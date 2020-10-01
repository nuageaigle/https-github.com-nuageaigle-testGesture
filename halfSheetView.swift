//
//  halfSheetView.swift
//  testGesture2
//
//  Created by aigle nuage on 2020/10/1.
//  Copyright © 2020 aigle nuage. All rights reserved.
//

import SwiftUI

struct halfSheetView: View {
    @State var isPickerPresented = false
    
    var body: some View {
        
            Button(action: {
                self.isPickerPresented.toggle()
            }) {
                Image(systemName: "plus")
            }
            .customBottomSheet(isPresented: $isPickerPresented) {
                halfSheet()
                    }
    }
    
}

struct halfSheet: View {
    
    var Label3 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @State private var selected3 = 2
    @State private var selected2 = 3
    @State private var selected1 = 4
    
    var body: some View {
        
        HStack {
        Picker(selection: $selected3, label: Text("H")) {
            ForEach(0 ..< Label3.count) {
                Text(self.Label3[$0])

            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 50)
        .clipped()
        
        Picker(selection: $selected2, label: Text("T")) {
            ForEach(0 ..< Label3.count) {
                Text(self.Label3[$0])

            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 50)
        .clipped()
        
        Picker(selection: $selected1, label: Text("O")) {
            ForEach(0 ..< Label3.count) {
                Text(self.Label3[$0])

            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 50)
        .clipped()
        }
        
    }
}

struct BottomSheet<SheetContent: View>: ViewModifier {
@Binding var isPresented: Bool
let sheetContent: () -> SheetContent

func body(content: Content) -> some View {
    ZStack {
        content

        if isPresented {
            VStack {
                Spacer()

                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.easeInOut) {
                                self.isPresented = false
                            }
                        }) {
                            Text("done")
                                .padding(.top, 5)
                        }
                    }

                    sheetContent()
                }
                .padding()
            }
            .zIndex(.infinity)
            .transition(.move(edge: .bottom))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
}

    
extension View {
    func customBottomSheet<SheetContent: View>(
        isPresented: Binding<Bool>,
        sheetContent: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(BottomSheet(isPresented: isPresented, sheetContent: sheetContent))
    }
}


struct halfSheetView_Previews: PreviewProvider {
    static var previews: some View {
        halfSheetView()
    }
}
