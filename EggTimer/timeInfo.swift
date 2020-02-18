//
//  timeInfo.swift
//  EggTimer
//
//  Created by Yongkun Li on 2/17/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import Foundation

class timeInfo: ObservableObject{
    @Published var timeRemaining = 671
    @Published var timeCollapsed = 0
    @Published var timerIsRunning = false
  
    
    // for drawing
    var tenMinute:Int { get {return timeRemaining/600} }
    var oneMinute:Int { get {return (timeRemaining-tenMinute*600)/60} }
    var tenSencond:Int { get {return (timeRemaining-tenMinute*600-oneMinute*60)/10} }
    var oneSencond:Int { get {return timeRemaining-tenMinute*600-oneMinute*60-tenSencond*10} }
}
