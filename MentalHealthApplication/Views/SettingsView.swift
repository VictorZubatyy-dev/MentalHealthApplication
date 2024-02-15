//
//  SettingsView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @State private var path = [User]()
    @AppStorage("userName") private var userName = ""
    @AppStorage("userAge") private var userAge = ""
    @AppStorage("userGender") private var userGender = ""
    @AppStorage("userSmokingStatus") private var userSmokingStatus = ""
    @AppStorage("userAwakenings") private var userAwakenings = 0
    @AppStorage("exerciseFrequency") private var exerciseFrequency = 0
    @AppStorage("userExerciseGoal") private var userExerciseGoal = 0
    @AppStorage("userSleepGoal") private var userSleepGoal = 0
    static let userDetails = ["Username", "Age", "Gender", "Smoking Status", "Awakenings", "Exercise Frequency", "Exercise Goal", "Sleep Goal"]
    
    var body: some View {
        VStack(alignment: .leading){
                NavigationStack {
                    List(SettingsView.userDetails, id: \.self) { userDetail in
                        NavigationLink(userDetail, value: userDetail)
                    }
                    .navigationDestination(for: String.self) { userDetail in
                        EditUserView(selectedUserDetail: userDetail)
                    }
                    .navigationTitle("Settings")
                }
            }
    }
}
//#Preview {
//    SettingsView()
//}
