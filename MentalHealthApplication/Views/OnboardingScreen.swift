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
    @AppStorage("userAge") private var userAge = 0
    @AppStorage("userGender") private var userGender = ""
    let age = Array(9...69)
    
    var body: some View {
        VStack(alignment: .leading){
            Text("User Setup").font(.largeTitle).bold().padding()
                Form {
                    Section(header: Text("Personal Details")) {
                        TextField(text: $userName, prompt: Text("Name")) {
                            Text("Name")
                        }
                        List {
                            Picker("Age", selection: $userAge) {
                                ForEach(age, id: \.self){
                                    Text("\($0)").tag($0)
                                }
                            }
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



