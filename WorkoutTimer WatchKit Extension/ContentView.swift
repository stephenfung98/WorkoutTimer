//
//  ContentView.swift
//  WorkoutTimer WatchKit Extension
//
//  Created by Stephen Fung on 1/29/20.
//  Copyright © 2020 Stephen Fung. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var setTime = 0
    @State private var workoutTime = 0
    
    var body: some View {
        VStack {
            NavigationLink(destination: TimerView(timeRemaining: $setTime, constTime: setTime, workoutType: "Set")) {
                Text("Set")
            }
            
            NavigationLink(destination: TimerView(timeRemaining: $workoutTime, constTime: workoutTime, workoutType: "Workout")) {
                Text("Workout")
            }
            
            NavigationLink(destination: SettingsView()) {
                Text("Settings")
            }
        }.onAppear {
            self.setTime = UserDefaults.standard.integer(forKey: "setTimer")
            self.workoutTime = UserDefaults.standard.integer(forKey: "workoutTimer")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
