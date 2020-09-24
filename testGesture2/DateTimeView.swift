//
//  DateTimeView.swift
//  testGesture2
//
//  Created by aigle nuage on 2020/9/24.
//  Copyright © 2020 aigle nuage. All rights reserved.
//

import SwiftUI

struct DateTimeView: View {
    var body: some View {
        VStack {
            TimeView2()
            TimeView()
        }
    }
}

struct TimeView2 : View { // no filter
    
    private func NowTimeData () -> some View {
        let components = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
        
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let month = components.month ?? 0

        return VStack {
            
            Text("h \(hour) m \(minute)")
            Text("m \(month)")
            Text("le passe est passe")
            EmptyView()
        }
    }
    
    var body: some View {
        NowTimeData()
    }
}

struct TimeView : View { // now time with filter
    
    private func NowTimeData () -> some View {
        let components = Calendar.current.dateComponents([.month, .hour, .minute], from: Date())
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let month = components.month ?? 0

        return VStack {
            
            Text("h \(hour) m \(minute)")
            Text("m \(month)")
            Text("la reine des neiges")
            EmptyView()
        }
    }
    
    var body: some View {
        NowTimeData()
    }
}

struct DateTimeView_Previews: PreviewProvider {
    static var previews: some View {
        DateTimeView()
    }
}
