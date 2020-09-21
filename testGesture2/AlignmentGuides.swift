//
//  AlignmentGuides.swift
//  testGesture2
//
//  Created by aigle nuage on 2020/9/17.
//  Copyright © 2020 aigle nuage. All rights reserved.
//

import SwiftUI

struct AlignmentGuides: View {
    @State var LayoutW : CGFloat = 200
    var body: some View {
        VStack {
            TestWrappedLayout(w: LayoutW, texts: ["come what", "now or yet" , "A heigh", "je ne savais pas" , "RUNAWAY", "Boom cha cha la ka", "Fairy temple"])
            
            Button(action: {
                //go to another view
                self.LayoutW = 300
            }) {
                Text("300")
                    .font(.largeTitle)
                    //.fontWeight(.ultraLight)
            }
            
            Button(action: {
                //go to another view
                self.LayoutW = 400
            }) {
                Text("400")
                    .font(.largeTitle)
                    //.fontWeight(.ultraLight)
            }
            
            
            HStack(alignment: .midAccountAndName) {
                VStack {
                    Text("@twostraws")
                        .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    Image(systemName: "command")
                        .resizable()
                        //.font(.system(size: 10, weight: .regular))
                        .frame(width: 34, height: 34)
                }

                VStack {
                    Text("Full name:")
                    Text("PAUL HUDSON")
                        .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.bottom] }
                        .font(.largeTitle)
                }
            }
        }
    }
}

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.firstTextBaseline]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct TestWrappedLayout: View {
    let w: CGFloat
    var texts: [String]

    var body: some View {
        self.generateContent(in: w)
    }

    private func generateContent(in w: CGFloat) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.texts, id: \.self) { t in
                self.item(for: t)
                    .padding([.trailing, .bottom], 4)
                    .alignmentGuide(.leading, computeValue: { d in

                        if (abs(width - d.width) > w)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if t == self.texts.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if t == self.texts.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }

    func item(for text: String) -> some View {
        Text(text)
            .padding([.leading, .trailing], 8)
            .frame(height: 30)
            .font(.subheadline)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(15)
            .onTapGesture {
                print("你好啊")
        }
    }
}

struct AlignmentGuides_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentGuides()
    }
}
