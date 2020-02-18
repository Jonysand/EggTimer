//
//  sandglassBodyView.swift
//  EggTimer
//
//  Created by Yongkun Li on 2/17/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct sandglassBodyView: View {
    @EnvironmentObject var userTimeInfo: timeInfo
    
    var body: some View {
        ZStack{
            // main body
            GeometryReader{ geometry in
                Path {path in
                    let height = geometry.size.height
                    let width = geometry.size.width
                    let curveOffsetPercent:CGFloat = 0.1
                    path.move(to: .init(x: width*curveOffsetPercent, y: 0))
                    path.addLine(to: .init(x: width * (1-curveOffsetPercent), y: 0))
                    path.addQuadCurve(to: .init(x: width*(1-curveOffsetPercent), y: height*(curveOffsetPercent)), control: .init(x: width, y: 0))
                    path.addLine(to: .init(x: width*curveOffsetPercent, y: height*(1-curveOffsetPercent)))
                    path.addQuadCurve(to: .init(x: width*curveOffsetPercent, y: height), control: .init(x: 0, y: height))
                    path.addLine(to: .init(x: width*(1-curveOffsetPercent), y: height))
                    path.addQuadCurve(to: .init(x: width*(1-curveOffsetPercent), y: height*(1-curveOffsetPercent)), control: .init(x: width, y: height))
                    path.addLine(to: .init(x: width*curveOffsetPercent, y: height*curveOffsetPercent))
                    path.addQuadCurve(to: .init(x: width*curveOffsetPercent, y: 0), control: .zero)
                }.stroke(lineWidth: 8)
            }
//            .onTapGesture {
//                self.userTimeInfo.timerIsRunning.toggle()
//                // reset
//                if !self.userTimeInfo.timerIsRunning {
//                    self.userTimeInfo.timeRemaining = 0
//                    self.userTimeInfo.timeCollapsed = 0
//                }
//            }
            
            // pause valve
            ZStack(alignment: .trailing){
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 8)
                    .padding()
                ZStack{
                    Rectangle()
                        .frame(width: 50, height: 8)
                        .rotationEffect(.degrees(120))
                    Rectangle()
                    .frame(width: 50, height: 8)
                    .rotationEffect(.degrees(60))
                }
                .rotation3DEffect(.degrees(self.userTimeInfo.timerIsRunning ? 0: 90), axis: (x:0, y:0, z:1))
                .onTapGesture {
                    self.userTimeInfo.timerIsRunning.toggle()
                }
            }
        }
    }
}

struct sandglassBodyView_Previews: PreviewProvider {
    static var previews: some View {
        sandglassBodyView().environmentObject(timeInfo())
    }
}
