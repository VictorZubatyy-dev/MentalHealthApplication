//
//  OnboardingScreen.swift
//  MentalHealthApplication
//
//  Created by Victor on 05/02/2024.
//

import SwiftUI
import SwiftData

struct OnboardingUserScreen: View {
    @Environment(\.modelContext) var modelContext
    @AppStorage("userName") private var userName = ""
    @AppStorage("userAge") private var userAge = ""
    @AppStorage("userGender") private var userGender = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Text("User Setup").font(.largeTitle).bold().padding()
                Form {
                    Section(header: Text("Personal Details")) {
                        TextField(text: $userName, prompt: Text("Name")) {
                            Text("Name")
                        }
                        TextField(text: $userAge, prompt: Text("Age")) {
                            Text("Age")
                        }
                        List {
                            Picker("Gender", selection: $userGender) {
                                Text("Male").tag("Male")
                                Text("Female").tag("Female")
                            }}
                    }
                }
            }.background(Color.ListBGColor)
        }
    }



