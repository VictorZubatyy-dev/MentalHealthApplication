//
//  OnboardingView.swift
//  MentalHealthApplication
//
//  Created by Victor on 05/02/2024.
//

import SwiftUI

extension Color {
    public static let ListBGColor = Color(UIColor.secondarySystemBackground)
}

struct OnboardingView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var userDetails: Users
    @State private var selectedView = 1
    let maxNumberOfScreens = 2

    @AppStorage(Constants.currentOnboardingVersion) private var hasSeenOnboardingView = false
    
    var body: some View {
        VStack (alignment: .center){
            TabView(selection: $selectedView) {
                if (userDetails.user.isEmpty){
                    OnboardingUserScreen().tag(1)
                    OnboardingHealthScreen().tag(2)
                }
                
                else{
                    OnboardingUserScreen().tag(1)
                    OnboardingHealthScreen().tag(2)
                }
                
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            Button(action: deleteUser){
                Text("delete user")
            }
            
            Button(selectedView == maxNumberOfScreens ? "Done" : "Next") {
                if selectedView == maxNumberOfScreens {
                    hasSeenOnboardingView = true
                } else {
                    selectedView += 1
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.vertical)
        }.background(Color.ListBGColor)
            .ignoresSafeArea(.all)
    }
    
    func deleteUser(){
        do {
            try modelContext.delete(model: User.self)
        } catch {
            print("Failed to clear all Country and City data.")
        }
    }
}

//#Preview {
//    OnboardingView()
//}
