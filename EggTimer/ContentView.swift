//
//  ContentView.swift
//  EggTimer
//
//  Created by Yongkun Li on 2/15/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userTimeInfo: timeInfo
    
    @ObservedObject var MM = motionManager()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            // Sandglass
            sandglassView().environmentObject(userTimeInfo)
                .padding()
                .rotationEffect(.degrees(
                    (!self.userTimeInfo.timerIsRunning && (self.userTimeInfo.timeCollapsed == 0 || self.userTimeInfo.timeRemaining == 0))
                        ? 180:0))
                .animation(.spring(dampingFraction: 0.5))
            
            // Setting timer
            HStack{
                VStack{
                    Button(action: {
                        self.userTimeInfo.timeRemaining += 10 * 60
                        if self.userTimeInfo.tenMinute>6 {self.userTimeInfo.timeRemaining -= 10 * 60}
                    }){ digitView(degree: 30, strokeColor: .orange) }
                    Button(action: {
                        self.userTimeInfo.timeRemaining -= 10 * 60
                        if self.userTimeInfo.timeRemaining<0 {self.userTimeInfo.timeRemaining=0}
                    }){
                        digitView(degree: 30, strokeColor: .orange)
                            .rotationEffect(.degrees(180))}
                }
                
                VStack{
                    Button(action: {
                        self.userTimeInfo.timeRemaining += 1 * 60
                        if self.userTimeInfo.tenMinute>6 {self.userTimeInfo.timeRemaining -= 1 * 60}
                    }){ digitView(degree: 30, strokeColor: .orange) }
                    Button(action: {
                        self.userTimeInfo.timeRemaining -= 1 * 60
                        if self.userTimeInfo.timeRemaining<0 {self.userTimeInfo.timeRemaining=0}
                    }){ digitView(degree: 30, strokeColor: .orange)
                        .rotationEffect(.degrees(180)) }
                }
                VStack{
                    Circle()
                    Circle()
                }.padding()
                    .foregroundColor(.gray)
                VStack{
                    Button(action: {
                        self.userTimeInfo.timeRemaining += 10
                        if self.userTimeInfo.tenMinute>6 {self.userTimeInfo.timeRemaining -= 10}
                    }){ digitView(degree: 30, strokeColor: .yellow) }
                    Button(action: {
                        self.userTimeInfo.timeRemaining -= 10
                        if self.userTimeInfo.timeRemaining<0 {self.userTimeInfo.timeRemaining=0}
                    }){ digitView(degree: 30, strokeColor: .yellow)
                        .rotationEffect(.degrees(180)) }
                }
                VStack{
                    Button(action: {
                        self.userTimeInfo.timeRemaining += 1
                        if self.userTimeInfo.tenMinute>6 {self.userTimeInfo.timeRemaining -= 1}
                    }){ digitView(degree: 30, strokeColor: .yellow) }
                    Button(action: {
                        self.userTimeInfo.timeRemaining -= 1
                        if self.userTimeInfo.timeRemaining<0 {self.userTimeInfo.timeRemaining=0}
                    }){ digitView(degree: 30, strokeColor: .yellow)
                        .rotationEffect(.degrees(180))}
                }
            }
            .padding()
            .padding(.leading, 40)
            .padding(.trailing, 40)
            .frame(height: 100)
        }
        .onReceive(timer) { _ in
            if self.userTimeInfo.timeRemaining > 0 && self.userTimeInfo.timerIsRunning {
                self.userTimeInfo.timeRemaining -= 1
                self.userTimeInfo.timeCollapsed += 1
                //                print("Time Remaining:", self.userTimeInfo.timeRemaining)
            }
            
            if self.MM.isHitTable {
                // start or reset timer
                self.userTimeInfo.timerIsRunning.toggle()
                do{ try self.MM.player.start(atTime: 0)}catch{}
                
                if !self.userTimeInfo.timerIsRunning {
                    self.userTimeInfo.timeRemaining = 0
                    self.userTimeInfo.timeCollapsed = 0
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(timeInfo())
    }
}
