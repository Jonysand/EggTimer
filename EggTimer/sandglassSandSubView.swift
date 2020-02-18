//
//  sandglassSandSubView.swift
//  EggTimer
//
//  Created by Yongkun Li on 2/17/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct sandglassSandSubView: View {
    @EnvironmentObject var userTimeInfo: timeInfo
    
    // true for upper side, false for down side
    var upOrdown:Bool
    
    var body: some View {
        GeometryReader{geometry in
            
            VStack{
                // upper sand
                if (self.upOrdown){
                    if !self.userTimeInfo.timerIsRunning && (self.userTimeInfo.timeCollapsed == 0 || self.userTimeInfo.timeRemaining == 0) {
                        VStack{
                            HStack{
                                ForEach(0..<self.userTimeInfo.tenMinute, id: \.self){_ in
                                    RoundedRectangle(cornerRadius: 50, style: .circular)
                                        .foregroundColor(.orange)
                                        .frame(width: 40, height: geometry.size.width/12)
                                }}
                            HStack{
                                ForEach(0..<self.userTimeInfo.oneMinute, id: \.self){_ in
                                    RoundedRectangle(cornerRadius: 50, style: .circular)
                                        .foregroundColor(.orange)
                                        .frame(width: 20, height: geometry.size.width/16)
                                }}
                            HStack{
                                ForEach(0..<self.userTimeInfo.tenSencond, id: \.self){_ in
                                    RoundedRectangle(cornerRadius: 50, style: .circular)
                                        .foregroundColor(.yellow)
                                        .frame(width: 10, height: geometry.size.width/20)
                                }}
                            HStack{
                                ForEach(0..<self.userTimeInfo.oneSencond, id: \.self){_ in
                                    RoundedRectangle(cornerRadius: 50, style: .circular)
                                        .foregroundColor(.yellow)
                                        .frame(width: 5, height: geometry.size.width/24)
                                }}
                            Spacer()
                        }
                    }else{
                        Spacer()
                        RoundedRectangle(cornerRadius: 50, style: .circular)
                            .frame(height: (CGFloat(self.userTimeInfo.timeRemaining)+CGFloat(self.userTimeInfo.timeCollapsed))==0 ? 0:CGFloat(
                                CGFloat(self.userTimeInfo.timeRemaining)/(CGFloat(self.userTimeInfo.timeRemaining)+CGFloat(self.userTimeInfo.timeCollapsed))
                                )*geometry.size.height * 0.9
                        )
                            .foregroundColor(.orange)
                    }
                }
                    
                    // down sand
                else{
                    VStack{
                        Spacer()
                        RoundedRectangle(cornerRadius: 50, style: .circular)
                            .frame(height: (CGFloat(self.userTimeInfo.timeRemaining)+CGFloat(self.userTimeInfo.timeCollapsed))==0 ? 0:CGFloat(
                                CGFloat(self.userTimeInfo.timeCollapsed)/(CGFloat(self.userTimeInfo.timeRemaining)+CGFloat(self.userTimeInfo.timeCollapsed))
                                )*geometry.size.height * 0.9)
                            .foregroundColor(.orange)
                    }
                }
            }
        }
    }
}

struct sandglassSandSubView_Previews: PreviewProvider {
    static var previews: some View {
        sandglassSandSubView(upOrdown: true).environmentObject(timeInfo())
    }
}
