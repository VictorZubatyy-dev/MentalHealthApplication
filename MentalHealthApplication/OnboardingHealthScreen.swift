//
//  OnboardingHealthScreen.swift
//  MentalHealthApplication
//
//  Created by Victor on 05/02/2024.
//

import SwiftUI
import SwiftData

struct OnboardingHealthScreen: View {
    @EnvironmentObject var userDetails: Users
    
    let awakenings: [Double] = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]
    let exerciseFrequency: [Double] = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]

    var body: some View {
        VStack(alignment: .leading){
            Text("User Setup").font(.largeTitle).bold().padding()
            if !userDetails.user.isEmpty{
                Form {
                    Section(header: Text("Health Details")) {
                        List {
                            Picker("Smoking Status", selection: $userDetails.user[0].smokingStatus[0]) {
                                Text("Yes").tag(0)
                                Text("No").tag(1)
                            }}
                        
                        List {
                            Picker("Awakenings", selection: $userDetails.user[0].awakenings[0]) {
                                ForEach(awakenings, id: \.self){
                                    Text("\(Int($0))").tag($0)
                                }
                            }
                        }
                        
                        List {
                            Picker("Exercise Frequency", selection: $userDetails.user[0].Exercise_frequency) {
                                ForEach(exerciseFrequency, id: \.self){
                                    Text("\(Int($0))").tag($0)
                                }
                            }
                        }
                        
                        
                    
                   
                        //
                        //                Section(header: Text("Goals")) {
                        //                    List {
                        //                        Picker("Exercise Goal", selection: $selectedExerciseFrequency) {
                        //                            ForEach(0 ..< 8) {
                        //                                Text("\($0)")
                        //                            }
                        //                        }
                        //                    }
                        //                    List{
                        //                        DisclosureGroup("Sleep Goal", isExpanded: $isExpanded){
                        //                            List {
                        //                                Picker("hi", selection: $selectedSleepGoal) {
                        //                                    ForEach(0 ..< 8) {
                        //                                        Text("\($0)")
                        //                                    }
                        //                                }.pickerStyle(.wheel)
                        //                            }
                        //                        }
                        //                    }
                    }
                }
            }
        }.background(Color.ListBGColor)
    }
}

//#Preview {
//    OnboardingHealthScreen()
//}


