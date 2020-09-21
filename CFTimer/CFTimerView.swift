//
//  CFTimerView.swift
//  testGesture2
//
//  Created by aigle nuage on 2020/9/20.
//  Copyright © 2020 aigle nuage. All rights reserved.
//

import SwiftUI

//
//  ContentView.swift
//  testCFTimer3
//
//  Created by aigle nuage on 2020/8/25.
//

import SwiftUI

let colorLightGray = UIColor(red: 205/255, green: 210/255, blue: 210/255, alpha: 1)

let colorDarkGray1 = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
let colorDarkGray2 = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)

let singleWidth:CGFloat = UIScreen.main.bounds.width
let singleHeight:CGFloat = UIScreen.main.bounds.height

let modleViewOK = EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15)
let mainFlagOnOff = EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)

let edgeSide : CGFloat = 50
let edgeTop : CGFloat = 40
let edgeButtom : CGFloat = 50

struct TimeData {
    var tHour : Int = 0
    var tMinute : Int = 0
    var tSecond : Int = 0
    
    mutating func MinusOne() -> Bool {
        if self.tSecond > 0 {
            self.tSecond -= 1
        } else {
            
            self.tSecond = 59
            if self.tMinute > 0 {
                // delete minute
                self.tMinute -= 1
            } else {
                if self.tHour > 0 {
                    // delete hour
                    self.tMinute = 59
                    self.tHour -= 1
                } else {
                    // counting to 0:0:0
                    tHour = 0
                    tMinute = 0
                    tSecond = 0
                    return false
                }
            }
        }
        
        return true
    }
}

struct ContentView2: View {
    @State private var TimerCountingTD = TimeData (tHour: 0, tMinute: 0, tSecond: 29)
    @State private var TimerSelectedTD = TimeData (tHour: 0, tMinute: 0, tSecond: 29)

    @State private var IntervalCountingTD = TimeData (tHour: 0, tMinute: 0, tSecond: 09)
    @State private var IntervalSelectedTD = TimeData (tHour: 0, tMinute: 0, tSecond: 08)

    
    @State private var coutingRepeat: Int = 2
    @State private var selectedRepeat = 2

    @State var timer: Timer.TimerPublisher = Timer.publish (every: 1, on: .main, in: .common)

    
    @State var showingDetail = false

    @State private var running: Bool = false
    @State private var TimerCounting: Bool = true

    
    @State var halfModal_shown_timer = false
    @State var halfModal_shown_interval = false
    @State var halfModal_shown_repeat = false
    
    @State var flagRepeat = true
    @State var flagInterval = true

    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(colorDarkGray1))
            
            VStack (spacing: 0) {
                //Spacer()
                //    .frame(height: 70)

                Text(String(format: "%02d:%02d:%02d", TimerCountingTD.tHour, TimerCountingTD.tMinute, TimerCountingTD.tSecond))
                    //.font(.largeTitle)
                    .font(.custom("Arial Rounded MT Bold", size: 70))
                    .fontWeight(.bold)
                    .overlay(Rectangle().frame(height: 3).offset(x: 0, y: 35))
                    .foregroundColor(.white)
                    //.scaleEffect(x:2, y: 2.5, anchor: .bottom)
                    .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        self.halfModal_shown_timer.toggle()
                    })
                
                        //.font(.custom("Arial Rounded MT Bold", size: 62))
                        //.font(system(size: 30, weight: .regular, design: .monospaced))
                
                Spacer()
                    .frame(height: 30)
                
                HStack {
                    Text("Interval ")
                        .font(.custom("Arial Rounded MT Bold", size: 22))
                    
                    Text(String(format: "%02d:%02d:%02d", IntervalCountingTD.tHour, IntervalCountingTD.tMinute, IntervalCountingTD.tSecond))
                        .font(.custom("Arial Rounded MT Bold", size: 30))
                        .overlay(Rectangle().frame(height: 3).offset(x: 0, y: 25))
                        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                            self.halfModal_shown_interval.toggle()
                        })
                    
                    
                    Button(action: {
                        self.flagInterval.toggle()
                    }) {
                        Text(flagInterval ? "ON " : "Off")
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(flagInterval ? .gray : .white)
                            .padding(mainFlagOnOff)
                            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(flagInterval ? .white : Color(colorDarkGray1)))
                    }
                }
                .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 30)
                
                HStack {
                    Text("Repeat ")
                        .font(.custom("Arial Rounded MT Bold", size: 22))
                    Text("\(coutingRepeat) times")
                        .font(.custom("Arial Rounded MT Bold", size: 36))
                        .overlay(Rectangle().frame(height: 3).offset(x: 0, y: 25))
                        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                            self.halfModal_shown_repeat.toggle()
                        })
                    
                    Button(action: {
                        self.flagRepeat.toggle()
                    }) {
                        Text(flagRepeat ? " ON" : "Off")
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(flagRepeat ? .gray : .white)
                            .padding(mainFlagOnOff)
                            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(flagRepeat ? .white : Color(colorDarkGray1)))
                    }
                    
                }
                .foregroundColor(.white)
                
                Spacer()
                
                //Text(TimerCounting ? "true" : "false")

                HStack (spacing: 2) {
                    
                    Button(action: {
                        self.cancelTimer()
                        resetCount()
                        
                        running = false
                    }) {
                        Image(systemName: "stop.fill")
                            .font(Font.system(size: 46))
                            .frame(width: (singleWidth - edgeSide) * 0.35 , height: singleHeight * 0.13)
                            .foregroundColor(.white)
                            .background(Rectangle())
                            .foregroundColor(.blue)
                    }
                    
                    Button(action: {
                        if running {
                            self.cancelTimer()
                        } else {
                            self.beginTimer()
                        }
                        running.toggle()
                    }) {
                        
                        Image(systemName: self.running ? "pause.fill" : "play.fill")
                            .font(Font.system(size: 46))
                            .frame(width: (singleWidth - edgeSide) * 0.65 , height: singleHeight * 0.13)
                            .foregroundColor(.white)
                            .background(Rectangle())
                            .foregroundColor(.blue)
                    }
                    
                }
            }
            .onReceive(timer) { _ in
                withAnimation {
                    //guard self.coutingSec < CGFloat(selectedSec)+1 else { return }
                    if TimerCounting {
                        if !self.TimerCountingTD.MinusOne() {
                            // 0:0:0
                            
                            //----
                            if flagInterval {
                                self.TimerCounting = false
                            } else {
                                oneLoopDone()
                            }
                        }
                    } else {
                        if !IntervalCountingTD.MinusOne() {
                            self.TimerCounting = true
                            resetIntervalSec()
                            oneLoopDone()
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: singleWidth - edgeSide, minHeight: 200, maxHeight: singleHeight - edgeTop)
            //.frame(width: singleWidth - edgeSide, height: singleHeight - edgeTop)
            .background(Color(colorDarkGray2))
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            
            HalfModalView(isShown: $halfModal_shown_timer, modalHeight: 350){
                SetTimeView(viewTitle: "timer", showViewB: self.$halfModal_shown_timer, TimerSelectedTDB: self.$TimerSelectedTD) {
                    resetMinSec()
                }
            }
            
            HalfModalView(isShown: $halfModal_shown_interval, modalHeight: 350){
                SetTimeView(viewTitle: "interval", showViewB: self.$halfModal_shown_interval, TimerSelectedTDB: self.$IntervalSelectedTD) {
                    resetIntervalSec()
                }
            }
            
            HalfModalView(isShown: $halfModal_shown_repeat, modalHeight: 350){
                SetRepeatView(showViewB: self.$halfModal_shown_repeat, selectedRepeatB: self.$selectedRepeat) {
                    self.coutingRepeat = selectedRepeat
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func oneLoopDone () {
        if flagRepeat {
            //---- repeat -1
            if self.coutingRepeat > 1 {
                self.coutingRepeat -= 1
                self.resetMinSec()
            } else {
                self.cancelTimer()
                self.running = false
                self.resetCount()
            }
        } else {
            self.cancelTimer()
            self.resetMinSec()
            self.running = false
        }
    }
        
    func resetMinSec() {
        self.TimerCountingTD = TimerSelectedTD
        print("H: \(TimerSelectedTD.tHour) M: \(TimerSelectedTD.tMinute) S:\(TimerSelectedTD.tSecond)")
    }
    
    func resetIntervalSec() {
        self.IntervalCountingTD = IntervalSelectedTD
        print("H: \(TimerSelectedTD.tHour) M: \(TimerSelectedTD.tMinute) S:\(TimerSelectedTD.tSecond)")
    }

    func resetCount() {
        resetMinSec()
        self.coutingRepeat = selectedRepeat
    }
    
    func beginTimer() {
        self.instantiateTimer()
        self.timer.connect()
        return
    }

    func instantiateTimer() {
        self.timer = Timer.publish (every: 0.01, on: .main, in: .common)
        return
    }

    func cancelTimer() {
        self.timer.connect().cancel()
        return
    }
    
}

struct SetRepeatView: View {
    @Binding  var showViewB: Bool

    //@Binding  var TimerSelectedTDB: TimeData
    //@State private var TimerSelectedTDI = TimeData (tHour: 0, tMinute: 1, tSecond: 3)

    @Binding  var selectedRepeatB: Int
    @State private var selectedRepeatI : Int = 1

    
    let content: () -> Void
    
    var body: some View {
        
        VStack {
            Spacer()
                .frame(height: 50)
            
            HStack {
                Text("       ")
                    .foregroundColor(.clear)
                    .padding(modleViewOK)
                
                Spacer()
                
                Text("Repeat")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(Font.system(size: 22))
                Spacer()
                
                Button(action: {
                    copytoOutside()
                    showViewB.toggle()
                    content()
                }) {
                    Text("Done")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(modleViewOK)
                        .background(RoundedRectangle(cornerRadius: 16))
                }
            }
            
            Spacer()
                .frame(height: 20)
            
            HStack (spacing: 20) {

                VStack  {
                    Picker(selection: $selectedRepeatI, label: Text("P")) {
                     ForEach(0 ..< 10, id: \.self) { value in
                          Text("\(value)")
                             .font(Font.system(size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                       }
                    }
                    .frame(width: 50, height: 170)
                    .clipped()
                    
                }

            }
            
            Spacer()
                .frame(height: 50)
        }
        .onAppear() {
            copytoInside()
        }
    }
    
    func copytoInside() {
        selectedRepeatI = selectedRepeatB
    }
    
    func copytoOutside() {
        selectedRepeatB = selectedRepeatI
    }
}

struct SetTimeView: View {
    var viewTitle = "setting"
    @Binding var showViewB: Bool

    @Binding var TimerSelectedTDB: TimeData
    @State private var TimerSelectedTDI = TimeData (tHour: 0, tMinute: 1, tSecond: 3)

    let content: () -> Void
    
    var body: some View {
        
        VStack {
            Spacer()
                .frame(height: 50)
            
            HStack {
                Text("       ")
                    .foregroundColor(.clear)
                    .padding(modleViewOK)
                
                Spacer()
                
                Text(viewTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(Font.system(size: 22))
                Spacer()
                
                Button(action: {
                    copytoOutside()
                    showViewB.toggle()
                    content()
                }) {
                    Text("Done")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(modleViewOK)
                        .background(RoundedRectangle(cornerRadius: 16))
                }
            }
            
            Spacer()
                .frame(height: 20)
            
            HStack (spacing: 20) {

                VStack  {
                    Picker(selection: $TimerSelectedTDI.tHour, label: Text("P")) {
                     ForEach(0 ..< 10, id: \.self) { value in
                          Text("\(value)")
                             .font(Font.system(size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                       }
                    }
                    .frame(width: 50, height: 170)
                    .clipped()
                }

                VStack {
                    Picker(selection: $TimerSelectedTDI.tMinute, label: Text("P")) {
                     ForEach(0 ..< 10, id: \.self) { value in
                          Text("\(value)")
                             .font(Font.system(size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                       }
                    }
                    .frame(width: 50, height: 170)
                    .clipped()
                }
                
                VStack {
                    Picker(selection: $TimerSelectedTDI.tSecond, label: Text("P")) {
                    ForEach(0 ..< 60, id: \.self) { value in
                         Text("\(value)")
                            .font(Font.system(size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                      }
                    }
                   .frame(width: 50, height: 170)
                   .clipped()
                }

            }
            
            Spacer()
                .frame(height: 50)
        }
        .onAppear() {
            copytoInside()
        }
    }
    
    func copytoInside() {
        TimerSelectedTDI = TimerSelectedTDB
    }
    
    func copytoOutside() {
        TimerSelectedTDB = TimerSelectedTDI
    }
}

struct CFTimerView: View {
    var body: some View {
        ContentView2()
    }
}

struct CFTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CFTimerView()
    }
}
