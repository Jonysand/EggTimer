//
//  ShakableViewController.swift
//  EggTimer
//
//  Created by Yongkun Li on 2/15/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreMotion
import CoreHaptics

class motionManager: ObservableObject{    
    let motion = CMMotionManager()
    
    var timer: Timer?
    
    // User accelerometer data
    var uAz: Double?
    
    // Detecting Hitting the Table
    @Published var isHitTable = false
    var currentTime = Date()
    let hitInterval:Double = 1
    let zAccelerationThreshold:Double = 1
    
    // Hapic
    var hapticEngine:CHHapticEngine!
    var pattern: CHHapticPattern!
    var player: CHHapticPatternPlayer!
    
    init() {
        
        // Initialize device motion
        guard self.motion.isDeviceMotionAvailable else {return}
        self.motion.deviceMotionUpdateInterval = 1.0 / 60.0
        self.motion.startDeviceMotionUpdates()
        
        // Initialize Haptic
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        do { hapticEngine = try CHHapticEngine()
        } catch let error {
            fatalError("Engine Creation Error: \(error)")}
        hapticEngine.resetHandler = {
            print("Reset Handler: Restarting the engine.")
            do {
                // Try restarting the engine.
                try self.hapticEngine.start()
            } catch {
                fatalError("Failed to restart the engine: \(error)")
            }
        }
        let hapticDict = [
            CHHapticPattern.Key.pattern: [
                [CHHapticPattern.Key.event:
                    [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                      CHHapticPattern.Key.time: 0.001,
                      CHHapticPattern.Key.eventDuration: 1.0] // End of first event
                ], // End of first dictionary entry in the array
                [CHHapticPattern.Key.event:
                    [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                      CHHapticPattern.Key.time: 0.101,
                      CHHapticPattern.Key.eventDuration: 1.0]
                ],
                [CHHapticPattern.Key.event:
                    [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                      CHHapticPattern.Key.time: 0.201,
                      CHHapticPattern.Key.eventDuration: 2.0]
                ],
                [CHHapticPattern.Key.event:
                    [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                      CHHapticPattern.Key.time: 0.401,
                      CHHapticPattern.Key.eventDuration: 2.0]
                ],
                [CHHapticPattern.Key.event:
                    [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                      CHHapticPattern.Key.time: 0.601,
                      CHHapticPattern.Key.eventDuration: 3.0]
                ],
                [CHHapticPattern.Key.event:
                    [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                      CHHapticPattern.Key.time: 0.901,
                      CHHapticPattern.Key.eventDuration: 3.0]
                ]
            ] // End of array
        ] // End of haptic dictionary
        do{
            pattern = try CHHapticPattern(dictionary: hapticDict)
            player = try hapticEngine.makePlayer(with: pattern)
            try hapticEngine.start()
        }catch{}
        
        self.timer = Timer(fire: Date(), interval: (1.0/60.0),
                           repeats: true, block: { (timer) in
                            // Get the device motion data.
                            if let data = self.motion.deviceMotion{
                                self.uAz = data.userAcceleration.z
                            }
                            self.HitTableLoop()
        })
        RunLoop.current.add(self.timer!, forMode: .default)
    }
    
    func HitTableLoop(){
        // print(String(format:"%.1f", self.uAz ?? 0))
        if Date().timeIntervalSince(currentTime) > self.hitInterval {
            if self.isHitTable { self.isHitTable=false }
            
            if self.uAz! > zAccelerationThreshold {
                self.isHitTable = true
//                print ("Hit on \(self.uAz!)")
//                print (Date().timeIntervalSince(currentTime))
                self.currentTime = Date()
            }
        }
    }
}

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
