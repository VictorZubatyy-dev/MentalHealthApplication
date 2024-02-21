//
//  SettingsView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    static let userDetails = ["Username", "Age", "Gender", "Smoking Status", "Awakenings", "Exercise Frequency", "Exercise Goal", "Sleep Goal", "Bedtime Goal"]
    
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
