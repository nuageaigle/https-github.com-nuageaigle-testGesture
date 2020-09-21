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
    
    @State private var openIndex : Int = 0
    @State private var openView = false
    
    var colors = ["TwoViewResizeView", "TwoViewResizeTapeView", "animationView", "ColorSystem", "CFTimer", "Alignment"]
    
    
    var body: some View {

        ZStack {
            VStack {
                Picker(selection: $openIndex, label: Text("Please choose a color")) {
                            ForEach(0 ..< colors.count) {
                               Text(self.colors[$0])
                                .font(Font.system(size: 32))
                                
                            }
                         }
                
                Text("You selected: \(colors[openIndex])")
                    .font(.largeTitle)
                
                Button(action: {
                    self.openView.toggle()
                }) {
                    Text("Open")
                        .font(.largeTitle)
                        //.fontWeight(.ultraLight)
                }
                
                VStack {
                    Button(action: {}) {
                        Text("Tap here")
                    }
                }.accentColor(.orange)
                
                
                
                Text("kk")
                    .border(Color.red)
                    .background(
                        Color.yellow
                    )
                
            }
            
            if openView {
                switch openIndex {
                case 0: BottomView(showMe : $openView){TwoViewResizeView()}
                case 1: BottomView(showMe : $openView){TwoViewResizeTapView()}
                case 2:BottomView(showMe : $openView){swiftuiAnimations()}
                case 3:BottomView(showMe : $openView){ColorISystemView()}
                case 4:BottomView(showMe : $openView){CFTimerView()}
                case 5:BottomView(showMe : $openView){AlignmentGuides()}
                
                default:
                    BottomView(showMe : $openView){
                        TwoViewResizeTapView()
                        //swiftuiAnimations()
                    }
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
            Rectangle()
                .fill(Color.white)
            
            //Rectangle() // background
            //    .foregroundColor(Color.white)
            
            content()
            Rectangle()
                .fill(Color.orange.opacity(0.3))
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
