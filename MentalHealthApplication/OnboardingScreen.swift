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
    @EnvironmentObject var userDetails: Users
    
    var body: some View {
        VStack(alignment: .leading){
            Text("User Setup").font(.largeTitle).bold().padding()
            if !userDetails.user.isEmpty{
                Form {
                    Section(header: Text("Personal Details")) {
                        TextField(text: $userDetails.user[0].name, prompt: Text("Name (Required)")) {
                            Text("Name")
                        }
                        TextField(text: $userDetails.user[0].age, prompt: Text("Age (Required)")) {
                            Text("Age")
                        }
                        TextField(text: $userDetails.user[0].gender, prompt: Text("Gender (Required)")) {
                            Text("Gender")
                        }
                    }
                }
            }
        }.background(Color.ListBGColor)
    }
}



