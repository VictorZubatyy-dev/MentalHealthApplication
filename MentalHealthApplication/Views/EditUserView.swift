//
//  EditUserView.swift
//  MentalHealthApplication
//
//  Created by Victor on 01/02/2024.
//

import SwiftUI
import SwiftData

struct EditUserView: View {
    @AppStorage("userName") private var userName = ""
    @AppStorage("userAge") private var userAge = 0
    @AppStorage("userGender") private var userGender = ""
    @AppStorage("userSmokingStatus") private var userSmokingStatus = ""
    @AppStorage("userAwakenings") private var userAwakenings = 0
    @AppStorage("exerciseFrequency") private var exerciseFrequency = 0
    @AppStorage("userExerciseGoal") private var userExerciseGoal = 0
    @AppStorage("userSleepGoalHour") private var userSleepGoalHour = 0
    @AppStorage("userSleepGoalMinute") private var userSleepGoalMinute = 0
    @AppStorage("userSleepBedTimeHour") private var userSleepBedTimeHour = 0
    @AppStorage("userSleepBedTimeMinute") private var userSleepBedTimeMinute = 0
    
    @State var selectedUserDetail: String
    
// Arrays to hold the hours and minutes options
    let hours = Array(5...10)
    let minutes: [Int] = stride(from: 0, through: 30, by: 30).map { $0 }
    // Arrays to hold the hours and minutes options for bedtime
    //  Max 20 hours
    let hoursBedTime = Array(5...10)
    
//  21:00 to 2:30
//  Max 60 mins
    
    let minutesBedTime: [Int] = stride(from: 0, through: 30, by: 30).map { $0 }
    
    let numbers: [Int] = stride(from: 5, through: 90, by: 5).map { $0 }
    
    let awakenings = Array(0...4)
    let exerciseFrequencys = Array(0...5)
    
    let age = Array(9...69)
    
    var body: some View {
            Form {
                Section(header: Text(selectedUserDetail)) {
                    if (selectedUserDetail == "Username"){
                        TextField(text: $userName, prompt: Text("Name")) {
                            Text("Name")
                        }
                    }
                    
                    else if (selectedUserDetail == "Age"){
                        List {
                            Picker("Age", selection: $userAge) {
                                ForEach(age, id: \.self){
                                    Text("\($0)").tag($0)
                                }
                            }
                        }
                    }
                    
                    else if (selectedUserDetail == "Gender"){
                        List {
                            Picker("Gender", selection: $userGender) {
                                Text("Male").tag("Male")
                                Text("Female").tag("Female")
                            }}
                    }
                    
                    else if (selectedUserDetail == "Exercise Frequency"){
                        List {
                            Picker("Exercise Frequency (per week)", selection:  $exerciseFrequency) {
                                ForEach(exerciseFrequencys, id: \.self){
                                    Text("\($0)").tag($0)
                                }
                            }
                        }
                    }
                    
                    else if (selectedUserDetail == "Exercise Goal"){
                        List {
                            Picker("Exercise Goal", selection:  $userExerciseGoal) {
                                ForEach(numbers, id: \.self) { number in
                                    Text("\(number) min").tag(number)
                                }
                            }
                        }
                    }
                    
                    else if (selectedUserDetail == "Smoking Status"){
                        List {
                            Picker("Smoking Status", selection: $userSmokingStatus) {
                                Text("Yes").tag("Yes")
                                Text("No").tag("No")
                            }}
                    }
                    
                    else if (selectedUserDetail == "Awakenings"){
                        List {
                            Picker("Awakenings (per day)", selection: $userAwakenings) {
                                ForEach(awakenings, id: \.self){
                                    Text("\($0)").tag($0)
                                }
                            }
                        }
                    }
                    
                    else if (selectedUserDetail == "Sleep Goal"){
                        HStack(alignment: .center, spacing: 0) {
                            Text("Sleep Goal")
                            // Picker for hours
                            Picker("Hours", selection: $userSleepGoalHour) {
                                ForEach(hours, id: \.self) { hour in
                                    Text("\(hour) hr").tag(hour)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 125, alignment: .center) // Adjust the width as needed
                            .clipped()
                            
                            // Picker for minutes
                            Picker("Minutes", selection: $userSleepGoalMinute) {
                                ForEach(minutes, id: \.self) { minute in
                                    Text("\(minute) min").tag(minute)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 125, alignment: .center) // Adjust the width as needed
                            .clipped()
                        }
                        .frame(height: 100) // Adjust the height as needed
                        Text("Selected Goal: \(userSleepGoalHour) hour(s) and \(userSleepGoalMinute) minute(s)")
                            .padding(.top, 20)
                    }
                    
                    else if (selectedUserDetail == "Bedtime Goal"){
                        HStack(alignment: .center, spacing: 0) {
                            Text("Bedtime Goal")
                            // Picker for hours
                            Picker("Hours", selection: $userSleepBedTimeHour) {
                                ForEach(hoursBedTime, id: \.self) { hour in
                                    Text("\(hour) hr").tag(hour)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 125, alignment: .center) // Adjust the width as needed
                            .clipped()

                            // Picker for minutes
                            Picker("Minutes", selection: $userSleepBedTimeMinute) {
                                ForEach(minutesBedTime, id: \.self) { minute in
                                    Text("\(minute) min").tag(minute)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 125, alignment: .center) // Adjust the width as needed
                            .clipped()
                        }
                        .frame(height: 100) // Adjust the height as needed
                        Text("Selected Goal: \(userSleepBedTimeHour) hour(s) and \(userSleepBedTimeMinute) minute(s)")
                            .padding(.top, 20)
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
    }
}

