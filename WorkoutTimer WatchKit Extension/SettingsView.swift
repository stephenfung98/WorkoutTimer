//
//  SettingsView.swift
//  WorkoutTimer WatchKit Extension
//
//  Created by Stephen Fung on 1/29/20.
//  Copyright © 2020 Stephen Fung. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State private var setVal = Double(UserDefaults.standard.integer(forKey: "setTimer"))
    @State private var workoutVal = Double(UserDefaults.standard.integer(forKey: "workoutTimer"))
    
    var body: some View {
        VStack {
            Text("Set break: \(Int(setVal))")
            Slider(value: Binding<Double>(get: {
                self.setVal
            }, set: { (newVal) in
                self.setVal = newVal
                UserDefaults.standard.set(Int(self.setVal), forKey: "setTimer")
            }), in: 1...120, step: 1.0)
            
            Spacer()
            
            Text("Workout break: \(Int(workoutVal))")
            Slider(value: Binding<Double>(get: {
                self.workoutVal
            }, set: { (newVal) in
                self.workoutVal = newVal
                UserDefaults.standard.set(Int(self.workoutVal), forKey: "workoutTimer")
            }), in: 1...120, step: 1.0)
        }.onAppear {
            self.workoutVal = Double(UserDefaults.standard.integer(forKey: "workoutTimer"))
            self.setVal = Double(UserDefaults.standard.integer(forKey: "setTimer"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
