//
//  TimerView.swift
//  WorkoutTimer WatchKit Extension
//
//  Created by Stephen Fung on 1/29/20.
//  Copyright © 2020 Stephen Fung. All rights reserved.
//

import SwiftUI
import HealthKit

struct TimerView: View {
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var number = 1
    
    @Binding var timeRemaining: Int
    var constTime: Int
    var workoutType: String
    
    var healthStore = HKHealthStore()
    var workoutSession: HKWorkoutSession?
    
    let config = HKWorkoutConfiguration()
    
    init(timeRemaining: Binding<Int>, constTime: Int, workoutType: String) {
        self._timeRemaining = timeRemaining
        self.constTime = constTime
        self.workoutType = workoutType
        config.locationType = .indoor
        
        do {
            workoutSession = nil
            workoutSession = try? HKWorkoutSession(healthStore: healthStore, configuration: config)
            workoutSession?.prepare()
        }
    }
    
    var body: some View {
        VStack {
            Text(workoutType == "Set" ? "\(workoutType) # \(number)" : workoutType)
                .font(.largeTitle)
            
            Spacer()
            
            Text(timeRemaining.timeDisplay())
                .onReceive(timer) { _ in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                        if self.timeRemaining == 10 {
                            WKInterfaceDevice.current().play(.success)
                        } else if self.timeRemaining == 0 {
                            WKInterfaceDevice.current().play(.notification)
                        }
                    }
            }
            .font(.largeTitle)
            .onAppear {
                self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
            
            Spacer()
            
            if timeRemaining == 0 {
                Button(action: {
                    self.timeRemaining = self.constTime
                    self.number += 1
                }) {
                    Text("Reset Timer")
                }
            }
        }
    }
}

extension Int {
    func timeDisplay() -> String {
        let mins:Int = (self / 60) % 60
        let secs:Int = self % 60
        
        let strTimestamp:String = (((mins<10) ? "0" : "") + String(mins) + ":" + ((secs<10) ? "0" : "") + String(secs))
        return strTimestamp
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timeRemaining: .constant(50), constTime: 50, workoutType: "Set # 1")
    }
}
