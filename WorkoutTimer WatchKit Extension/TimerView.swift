//
//  TimerView.swift
//  WorkoutTimer WatchKit Extension
//
//  Created by Stephen Fung on 1/29/20.
//  Copyright © 2020 Stephen Fung. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Binding var timeRemaining: Int
    var constTime: Int
    var workoutType: String
    
    var body: some View {
        VStack {
            Text(workoutType)
            
            Spacer()
            
            Text(timeRemaining.timeDisplay())
                .onReceive(timer) { _ in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                        if self.timeRemaining == 0 {
                            WKInterfaceDevice.current().play(.click)
                        }
                    }
            }.onAppear {
                self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
            
            Spacer()
            
            if timeRemaining == 0 {
                Button(action: {
                    self.timeRemaining = self.constTime
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
        TimerView(timeRemaining: .constant(50), constTime: 50, workoutType: "Set")
    }
}
