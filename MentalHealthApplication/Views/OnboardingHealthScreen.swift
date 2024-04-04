//
//  OnboardingHealthScreen.swift
//  MentalHealthApplication
//
//  Created by Victor on 05/02/2024.
//

import SwiftUI
import SwiftData

struct OnboardingHealthScreen: View {
    let awakenings = Array(0...4)
    let exerciseFrequencys = Array(0...5)
    @State private var selectedValue: Int = 0
    let numbers: [Int] = stride(from: 5, through: 90, by: 5).map { $0 }
    
    /// State variables to keep track of the selected hour and minute
    @State private var selectedHour: Int = 0
    @State private var selectedMinute: Int = 0
    
    /// Arrays to hold the hours and minutes options for sleep
    let hours = Array(5...10)
    let minutes: [Int] = stride(from: 0, through: 30, by: 30).map { $0 }
    
    ///    Arrays to hold the hours and minutes options for bedtime
    ///    21:00 to 2:30 bedtime hours/minutes
    let hoursBedTime: [Int] = [21,22,23,0,1,2]
    let minutesBedTime: [Int] = stride(from: 0, through: 30, by: 30).map { $0 }
    
    @AppStorage("userSmokingStatus") private var userSmokingStatus = ""
    @AppStorage("userAwakenings") private var userAwakenings = 0
    @AppStorage("exerciseFrequency") private var exerciseFrequency = 0
    @AppStorage("userSleepGoalHour") private var userSleepGoalHour = 0
    @AppStorage("userSleepGoalMinute") private var userSleepGoalMinute = 0
    @AppStorage("userSleepBedTimeHour") private var userSleepBedTimeHour = 0
    @AppStorage("userSleepBedTimeMinute") private var userSleepBedTimeMinute = 0
    
    var body: some View {
        VStack(alignment: .leading){
            Text("User Setup").font(.largeTitle).bold().padding()
            Form {
                Section(header: Text("Health Details")) {
                    List {
                        Picker("Smoking Status", selection: $userSmokingStatus) {
                            Text("Yes").tag("Yes")
                            Text("No").tag("No")
                        }}
                    
                    List {
                        Picker("Awakenings (per day)", selection: $userAwakenings) {
                            ForEach(awakenings, id: \.self){
                                Text("\($0)").tag($0)
                            }
                        }
                    }
                    
                    List {
                        Picker("Exercise Frequency (per week)", selection:  $exerciseFrequency) {
                            ForEach(exerciseFrequencys, id: \.self){
                                Text("\($0)").tag($0)
                            }
                        }
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        Text("Sleep Goal")
                        // Picker for sleep goal hours
                        Picker("Hours", selection: $userSleepGoalHour) {
                            ForEach(hours, id: \.self) { hour in
                                Text("\(hour) hr").tag(hour)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 125, alignment: .center)
                        .clipped()
                        
                        // Picker for sleep goal minutes
                        Picker("Minutes", selection: $userSleepGoalMinute) {
                            ForEach(minutes, id: \.self) { minute in
                                Text("\(minute) min").tag(minute)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 125, alignment: .center)
                        .clipped()
                    }
                    .frame(height: 100)
                    Text("Selected Goal: \(userSleepGoalHour) hour(s) and \(userSleepGoalMinute) minute(s)")
                        .padding(.top, 20)
                    
                    HStack(alignment: .center, spacing: 0) {
                        Text("Bedtime Goal")
                        // Picker for bedtime hours
                        Picker("Hours", selection: $userSleepBedTimeHour) {
                            ForEach(hoursBedTime, id: \.self) { hour in
                                Text("\(hour) hr").tag(hour)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 125, alignment: .center)
                        .clipped()
                        
                        // Picker for bedtime minutes
                        Picker("Minutes", selection: $userSleepBedTimeMinute) {
                            ForEach(minutesBedTime, id: \.self) { minute in
                                Text("\(minute) min").tag(minute)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 125, alignment: .center)
                        .clipped()
                    }
                    .frame(height: 100)
                    Text("Selected Goal: \(userSleepBedTimeHour) hour(s) and \(userSleepBedTimeMinute) minute(s)")
                        .padding(.top, 20)
                }
            }
        }.background(Color.ListBGColor)
    }
}
