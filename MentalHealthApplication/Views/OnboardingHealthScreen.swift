//
//  OnboardingHealthScreen.swift
//  MentalHealthApplication
//
//  Created by Victor on 05/02/2024.
//

import SwiftUI
import SwiftData

struct OnboardingHealthScreen: View {
    let awakenings = Array(0...10)
    let exerciseFrequencys = Array(0...5)
    @State private var selectedValue: Int = 0
    let numbers: [Int] = stride(from: 5, through: 90, by: 5).map { $0 }
    
// State variables to keep track of the selected hour and minute
    @State private var selectedHour: Int = 0
    @State private var selectedMinute: Int = 0
    
// Arrays to hold the hours and minutes options
//  Max 20 hours
    let hours = Array(1...23)
//  Max 60 mins
    let minutes: [Int] = stride(from: 0, through: 55, by: 5).map { $0 }
    
    @AppStorage("userSmokingStatus") private var userSmokingStatus = ""
    @AppStorage("userAwakenings") private var userAwakenings = 0
    @AppStorage("exerciseFrequency") private var exerciseFrequency = 0
    @AppStorage("userExerciseGoal") private var userExerciseGoal = 0
    @AppStorage("userSleepGoalHour") private var userSleepGoalHour = 0
    @AppStorage("userSleepGoalMinute") private var userSleepGoalMinute = 0
    
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
                    
                    List {
                        Picker("Exercise goal", selection:  $userExerciseGoal) {
                            ForEach(numbers, id: \.self) { number in
                                Text("\(number) min").tag(number)
                            }
                        }
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        Text("Sleep goal")
                        // Picker for hours
                        Picker("Hours", selection: $userSleepGoalHour) {
                            ForEach(hours, id: \.self) { hour in
                                Text("\(hour) hr").tag(hour)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 125, alignment: .center)
                        .clipped()
                        
                        // Picker for minutes
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
                }
            }
        }.background(Color.ListBGColor)
    }
}

//#Preview {
//    OnboardingHealthScreen()
//}
