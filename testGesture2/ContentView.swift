//
//  ContentView.swift
//  testGesture2
//
//  Created by aigle nuage on 2020/9/9.
//  Copyright © 2020 aigle nuage. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var currentAmount: CGFloat = 0
    @State private var finalAmount: CGFloat = 1

    
    @EnvironmentObject var orientationInfo: OrientationInfo
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    


    @State private var fTwoView = false
    @State private var fTwoTapeView = false
    @State private var animationView = false

    var body: some View {

        ZStack {
            VStack {
                Text("Hello World")
                Button(action: {
                    //go to another view
                    self.fTwoView.toggle()
                }) {
                    Text("TwoViewResizeView")
                        .font(.largeTitle)
                        .fontWeight(.ultraLight)
                }

                Button(action: {
                    //go to another view
                    self.fTwoTapeView.toggle()
                }) {
                    Text("TwoViewResizeTapeView")
                        .font(.largeTitle)
                        .fontWeight(.ultraLight)
                }

                Button(action: {
                    //go to another view
                    self.animationView.toggle()
                }) {
                    Text("animationView")
                        .font(.largeTitle)
                        //.fontWeight(.ultraLight)
                }
                
                Text("kk")
                    .border(Color.black)
                    .background(
                        Color.yellow
                    )
                
            }
            
            if fTwoView {
                BottomView(showMe : $fTwoView){
                    TwoViewResizeView()
                    //swiftuiAnimations()
                }
            }
            
            if fTwoTapeView {
                BottomView(showMe : $fTwoTapeView){
                    TwoViewResizeTapView()
                    //swiftuiAnimations()
                }
            }
            
            if animationView {
                BottomView(showMe : $animationView){
                    //TwoViewResizeView()
                    swiftuiAnimations()
                }
            }
            
            
        
        }
        

        
        
        /*
        Text("Hello, World!")
            .scaleEffect(finalAmount + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { amount in
                        self.currentAmount = amount - 1
                    }
                    .onEnded { amount in
                        //self.finalAmount += self.currentAmount
                        self.currentAmount = 0
                    }
            )*/
    }
}


struct BottomView<Content: View>: View {
    @Binding var showMe : Bool
    
    var content: () -> Content
    
    
    var body: some View {
        ZStack {
            content()
            Rectangle()
                .fill(Color.orange)
                .frame(width: 50, height: 50)
                .position(x: 25, y: 25)
                .onTapGesture {
                    self.showMe.toggle()
            }
        }
    }
    
}

struct DragView: View {
    var body: some View {
        VStack {
            Text("Hello, world!").padding()
            //MagnificationGestureView()
            PersonView()
            MajidView()
            PersonView()
        }
    }
}


struct MajidView : View {
    @State private var offset: CGSize = .zero

    var body: some View {
        let drag = DragGesture()
            .onChanged { self.offset = $0.translation }
            .onEnded {
                if $0.translation.width < -100 {
                    self.offset = .init(width: -1000, height: 0)
                } else if $0.translation.width > 100 {
                    self.offset = .init(width: 1000, height: 0)
                } else {
                    self.offset = .zero
                }
        }

        return PersonView()
            .background(Color.red)
            .cornerRadius(8)
            .shadow(radius: 8)
            .padding()
            .offset(x: offset.width, y: offset.height)
            .gesture(drag)
            .animation(.interactiveSpring())
    }
}


struct PersonView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray)
                .cornerRadius(8)
                .frame(height: 100)

            Text("Majid Jabrayilov")
                .font(.title)
                //.color(.white)

            Text("iOS Developer")
                .font(.body)
                //.color(.white)
        }.padding()
    }
}

struct AnimatingStringView: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
        }
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in
                    self.dragAmount = .zero
                    self.enabled.toggle()
                }
        )
    }
}

final class OrientationInfo: ObservableObject {
    enum Orientation {
        case portrait
        case landscape
    }
    
    @Published var orientation: Orientation
    
    private var _observer: NSObjectProtocol?
    
    init() {
        // fairly arbitrary starting value for 'flat' orientations
        if UIDevice.current.orientation.isLandscape {
            self.orientation = .landscape
        }
        else {
            self.orientation = .portrait
        }
        
        // unowned self because we unregister before self becomes invalid
        _observer = NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil) { [unowned self] note in
            guard let device = note.object as? UIDevice else {
                return
            }
            if device.orientation.isPortrait {
                self.orientation = .portrait
            }
            else if device.orientation.isLandscape {
                self.orientation = .landscape
            }
        }
    }
    
    deinit {
        if let observer = _observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
